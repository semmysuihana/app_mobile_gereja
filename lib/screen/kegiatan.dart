import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'nav_drawer.dart';
import 'home_page.dart';
import 'koneksi_api.dart'; // Import the API service

// Define a model class for Kegiatan
class Kegiatan {
  final String id;
  final String hari;
  final String tanggal;
  final String pukul;
  final String keterangan;
  final String ibadah;

  Kegiatan({
    required this.id,
    required this.hari,
    required this.tanggal,
    required this.pukul,
    required this.keterangan,
    required this.ibadah,
  });

  // Factory method to create a Kegiatan object from JSON
  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'],
      hari: json['hari'],
      tanggal: json['tanggal'],
      pukul: json['pukul'],
      keterangan: json['keterangan'],
      ibadah: json['ibadah'],
    );
  }
}

class KegiatanPage extends StatefulWidget {
  @override
  _KegiatanPageState createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
  List<Kegiatan> kegiatanLi = [];
  bool _isLoading = true;
  DateTime currentWeekStartDate = DateTime.now();
  DateTime currentWeekEndDate = DateTime.now();
  DateTime previousWeekStartDate = DateTime.now();
  DateTime previousWeekEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    calculateWeekDates();
    fetchKegiatan();
  }

  void calculateWeekDates() {
    DateTime today = DateTime.now();
    int weekday = today.weekday;

    // Calculate the start and end dates for the current week
    currentWeekStartDate = today.subtract(Duration(days: weekday - DateTime.sunday));
    currentWeekEndDate = currentWeekStartDate.add(Duration(days: 6));

    // Calculate the start and end dates for the previous week
    previousWeekStartDate = currentWeekStartDate.subtract(Duration(days: 7));
    previousWeekEndDate = currentWeekEndDate.subtract(Duration(days: 7));
  }

  // Method to fetch data from API using the service
  Future<void> fetchKegiatan() async {
    try {
      List<dynamic> data = await ApiService.fetchKegiatan();
      List<Kegiatan> fetchedKegiatanLi = data.map((item) => Kegiatan.fromJson(item)).toList();

      setState(() {
        kegiatanLi = fetchedKegiatanLi;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  List<Kegiatan> filterKegiatanByWeek(DateTime startDate, DateTime endDate) {
    return kegiatanLi.where((kegiatan) {
      DateTime kegiatanDate = DateFormat('yyyy-MM-dd').parse(kegiatan.tanggal);
      return kegiatanDate.isAfter(startDate.subtract(Duration(days: 1))) &&
             kegiatanDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Kegiatan> currentWeekKegiatan = filterKegiatanByWeek(currentWeekStartDate, currentWeekEndDate);
    List<Kegiatan> previousWeekKegiatan = filterKegiatanByWeek(previousWeekStartDate, previousWeekEndDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('GPSI SOTERIA'),
      ),
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header image and text
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/hero_image.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Kontak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Beranda',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                      );
                                    },
                                ),
                                TextSpan(text: ' -> '),
                                TextSpan(
                                  text: 'Kontak',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      // SizedBox(height: 20),
                      // // Show a loading indicator if data is being fetched
                      // if (_isLoading)
                      //   Center(child: CircularProgressIndicator())
                      // else
                      //   // Display fetched data in a DataTable for the current week
                      //   SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: DataTable(
                      //       columnSpacing: 0,
                      //       decoration: BoxDecoration(
                      //         border: Border.all(color: Colors.black),
                      //       ),
                      //       columns: [
                      //         DataColumn(
                      //           label: Container(
                      //             width: 120,
                      //             child: Text('Hari & Tanggal', textAlign: TextAlign.center),
                      //           ),
                      //         ),
                      //         DataColumn(
                      //           label: Container(
                      //             width: 120,
                      //             child: Text('Jam', textAlign: TextAlign.center),
                      //           ),
                      //         ),
                      //         DataColumn(
                      //           label: Container(
                      //             width: 180,
                      //             child: Text('Jenis Kegiatan', textAlign: TextAlign.center),
                      //           ),
                      //         ),
                      //         DataColumn(
                      //           label: Container(
                      //             width: 200,
                      //             child: Text('Pelaksanaan', textAlign: TextAlign.center),
                      //           ),
                      //         ),
                      //         DataColumn(
                      //           label: Container(
                      //             width: 180,
                      //             child: Text('Tempat', textAlign: TextAlign.center),
                      //           ),
                      //         ),
                      //       ],
                      //       rows: currentWeekKegiatan.map((kegiatan) {
                      //         return DataRow(cells: [
                      //           DataCell(Container(
                      //             width: 120,
                      //             child: Text(kegiatan.hari, textAlign: TextAlign.center),
                      //           )),
                      //           DataCell(Container(
                      //             width: 120,
                      //             child: Text(kegiatan.pukul, textAlign: TextAlign.center),
                      //           )),
                      //           DataCell(Container(
                      //             width: 180,
                      //             child: Text(kegiatan.ibadah, textAlign: TextAlign.center),
                      //           )),
                      //           DataCell(Container(
                      //             width: 200,
                      //             child: Text(kegiatan.keterangan, textAlign: TextAlign.center),
                      //           )),
                      //           DataCell(Container(
                      //             width: 180,
                      //             child: Text('', textAlign: TextAlign.center),
                      //           )),
                      //         ]);
                      //       }).toList(),
                      //     ),
                      //   ),

                      SizedBox(height: 40),

                      Text(
                        'Kegiatan Minggu Ini (${DateFormat('yyyy-MM-dd').format(previousWeekStartDate)} - ${DateFormat('yyyy-MM-dd').format(previousWeekEndDate)})',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Display fetched data in a DataTable for the previous week
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          columns: [
                            DataColumn(
                              label: Container(
                                width: 120,
                                child: Text('Hari & Tanggal', textAlign: TextAlign.center),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                width: 120,
                                child: Text('Jam', textAlign: TextAlign.center),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                width: 180,
                                child: Text('Keterangan', textAlign: TextAlign.center),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                width: 200,
                                child: Text('Ibadah', textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                          rows: previousWeekKegiatan.map((kegiatan) {
                            return DataRow(cells: [
                              DataCell(Container(
                                width: 120,
                                child: Text(kegiatan.hari, textAlign: TextAlign.center),
                              )),
                              DataCell(Container(
                                width: 120,
                             
                             
                                child: Text(kegiatan.pukul, textAlign: TextAlign.center),
                              )),
                              DataCell(Container(
                                width: 200,
                                child: Text(kegiatan.keterangan, textAlign: TextAlign.center),
                              )),
                              DataCell(Container(
                                width: 180,
                                child: Text(kegiatan.ibadah, textAlign: TextAlign.center),
                              )),
                              
                            ]);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
