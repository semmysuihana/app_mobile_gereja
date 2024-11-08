import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import GestureRecognizer
import 'nav_drawer.dart'; // Import NavDrawer
import 'home_page.dart'; // Pastikan untuk mengimport HomePage jika belum diimport

class MajelisJemaat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPSI SOTERIA'),
      ),
      drawer: NavDrawer(), // Tambahkan NavDrawer ke dalam Scaffold
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header image and text
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
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
                        'Majelis Jemaat',
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
                              text: 'Tentang',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: ' -> '),
                            TextSpan(
                              text: 'Majelis Jemaat',
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
                  Text(
                    'Majelis Jemaat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'GPSI Soteria Periode 2016 - 2020',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Table of Majelis Jemaat
                  DataTable(
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Jabatan')),
                      DataColumn(label: Text('Nama')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('Pedeta Jemaat')),
                        DataCell(Text('	Pdt. Debora Tonglo, MTh')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('Ketua')),
                        DataCell(Text('Pnt. Herson Patrianto Suan')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('Sekertaris')),
                        DataCell(Text('Pnt. A.Novita Lengkey Doke')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('4')),
                        DataCell(Text('Ketua I')),
                        DataCell(Text('Pnt. Amelia Magdalena Korodi')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('Sekertaris I')),
                        DataCell(Text('Dkn. Belendina Asraka')),
                      ]),
                      
                       DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('Ketua II')),
                        DataCell(Text('Dkn. Yansen D. Malelak')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('6')),
                        DataCell(Text('Seketaris II')),
                        DataCell(Text('Dkn. Windy Andika Makahekung')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('7')),
                        DataCell(Text('Bendahara')),
                        DataCell(Text('Dkn. Heri Bowo Santoso')),
                      ]),
                       DataRow(cells: [
                        DataCell(Text('8')),
                        DataCell(Text('Wakil Bendahara')),
                        DataCell(Text('Pnt. Mudjiati Ester Ruge')),
                      ]),
                      // Add more DataRow as needed
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Theme of the year section
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
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
                        'Tema Tahunan 2018\nPergi dan beritakan\n(Menjadi saksi Kristus dimana saja, baik atau tidak baik waktunya)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 20, // Tambahkan margin atas sebesar 20
              child: Container(
                height: 20.0,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '© 2024 GPSI SOTERIA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
