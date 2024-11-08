import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import GestureRecognizer
import 'nav_drawer.dart'; // Import NavDrawer
import 'home_page.dart'; // Pastikan untuk mengimport HomePage jika belum diimport

class VisiMisiPage extends StatelessWidget {
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
                        'Sejarah',
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
                              text: 'Visi & Misi',
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
                    'Visi & Misi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Visi & Misi Container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Visi
                        Text(
                          'Visi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '"JEMAAT BERTUMBUH DAN MENJADI DEWASA DALAM KRISTUS"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Misi
                        Text(
                          'Misi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '"MELAKSANAKAN TUGAS DENGAN DEDIKASI DALAM BEKERJA MENGHASILKAN BUAH"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  // Header for UL line 3
                  // Text(
                  //   'UL line 3',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 6),
                  // Unordered List
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Menciptakan hubungan yang baik antara jemaat Soteria dengan jemaat lain dan lingkungannya (Koinonia).',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Menyediakan sarana dan prasarana Diakonia dalam peningkatan pelayanan.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Meningkatkan iman jemaat melalui pemberitaan Firman dan menjadi saksi-saksi Kristus (Marturia).',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  // Header for UL line 3
                  Text(
                    'TUJUAN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  // Unordered List
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Jemaat Menjadi Dewasa Dalam Kristus.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Menjadi Teguh Di dalam Iman.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Menjadi Kawan Sekerja Allah.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'Menjadi Saksi Kristus dan menghasilkan buah.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  // Header for UL line 3
                  Text(
                    'KIAT PELAYANAN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  // Unordered List
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'SETIA DALAM PERKARA KECIL.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'SEHATI SEPIKIR.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'DAN BEKERJA MENGHASILKAN BUAH.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        leading: Icon(Icons.arrow_right),
                        title: Text(
                          'AGAR DIA MAKIN DITINGGIKAN DAN DIMULIAKAN.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
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
