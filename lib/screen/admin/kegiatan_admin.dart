import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../koneksi_api.dart';
import '../nav_drawer.dart';
import 'package:intl/intl.dart';
import 'kegiatan_form_page.dart';

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

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'] ?? '',
      hari: json['hari'] ?? '',
      tanggal: json['tanggal'] ?? '',
      pukul: json['pukul'] ?? '',
      keterangan: json['keterangan'] ?? '',
      ibadah: json['ibadah'] ?? '',
    );
  }
}

class KegiatanAdminPage extends StatefulWidget {
  @override
  _KegiatanAdminPageState createState() => _KegiatanAdminPageState();
}

class _KegiatanAdminPageState extends State<KegiatanAdminPage> {
  late Future<List<Kegiatan>> _kegiatanList;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    selectedStartDate = _getCurrentWeekStartDate();
    selectedEndDate = _getCurrentWeekEndDate();
    _kegiatanList = fetchKegiatanData();
  }

  Future<List<Kegiatan>> fetchKegiatanData() async {
    try {
      List<Map<String, dynamic>> kegiatanData = await ApiService.fetchKegiatan();
      List<Kegiatan> kegiatanList = kegiatanData.map((json) => Kegiatan.fromJson(json)).toList();
      return kegiatanList.where((kegiatan) {
        DateTime kegiatanDate = DateFormat('yyyy-MM-dd').parse(kegiatan.tanggal);
        return kegiatanDate.isAfter(selectedStartDate!.subtract(Duration(days: 1))) &&
               kegiatanDate.isBefore(selectedEndDate!.add(Duration(days: 1)));
      }).toList();
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> deleteKegiatanData(String id) async {
    try {
      await ApiService.deleteKegiatan(id);
      Fluttertoast.showToast(msg: 'Kegiatan deleted successfully');
      setState(() {
        _kegiatanList = fetchKegiatanData();
      });
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error deleting kegiatan');
    }
  }

  void _addEditKegiatan({Kegiatan? kegiatan}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KegiatanFormPage(kegiatan: kegiatan),
      ),
    );

    if (result == true) {
      // Refresh the list if the form was successfully saved
      setState(() {
        _kegiatanList = fetchKegiatanData();
      });
    }
  }

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        if (selectedEndDate != null && selectedEndDate!.isBefore(selectedStartDate!)) {
          selectedEndDate = selectedStartDate;
        }
        _kegiatanList = fetchKegiatanData();
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? (selectedStartDate ?? DateTime.now()),
      firstDate: selectedStartDate ?? DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        _kegiatanList = fetchKegiatanData();
      });
    }
  }

  DateTime _getCurrentWeekStartDate() {
    final today = DateTime.now();
    final weekday = today.weekday;
    final diff = weekday - DateTime.monday;
    return today.subtract(Duration(days: diff));
  }

  DateTime _getCurrentWeekEndDate() {
    return _getCurrentWeekStartDate().add(Duration(days: 6));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Kegiatan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addEditKegiatan(),
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _selectStartDate,
                  child: Text('Start Date: ${selectedStartDate != null ? DateFormat('yyyy-MM-dd').format(selectedStartDate!) : 'Select Date'}'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _selectEndDate,
                  child: Text('End Date: ${selectedEndDate != null ? DateFormat('yyyy-MM-dd').format(selectedEndDate!) : 'Select Date'}'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Kegiatan>>(
              future: _kegiatanList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No activities found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Kegiatan kegiatan = snapshot.data![index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        elevation: 5,
                        child: ListTile(
                          title: Text(kegiatan.hari),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tanggal: ${kegiatan.tanggal}'),
                              Text('Pukul: ${kegiatan.pukul}'),
                              Text('Ibadah: ${kegiatan.ibadah}'),
                              Text('Keterangan: ${kegiatan.keterangan}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _addEditKegiatan(kegiatan: kegiatan),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteKegiatanData(kegiatan.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
