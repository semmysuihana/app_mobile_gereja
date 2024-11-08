import 'package:flutter/material.dart';
import 'koneksi_api.dart'; // Import the API connection file
import 'nav_drawer.dart';
import 'sejarah.dart'; // Pastikan diimpor dengan benar untuk navigasi
import 'artikel_detail.dart'; // Import halaman artikel detail

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> reflections = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<dynamic> latestReflections = await ApiService.fetchBlog();
    setState(() {
      reflections = latestReflections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPSI SOTERIA'),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Hero image and text
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
                        'Selamat Datang di\nGPSI SOTERIA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Short history section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sejarah Singkat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tertanggal 18 Februari 1975 mengenai pengakhiran masa tugas Pdt. E.F. Tokoh sebagai Pendeta Jemaat Eirene Tanjung Priok dan ditetapkan sebagai Pendeta.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Detail button linked to SejarahPage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SejarahPage()),
                  );
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Image below detail button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/gereja_lama.jpg',
                height: 99,
                fit: BoxFit.cover,
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

            SizedBox(height: 20),

            // Reflection cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: reflections.map<Widget>((reflection) {
                  return buildReflectionCard(
                    title: reflection['judul'],
                    date: reflection['date_create'],
                    verse: reflection['isi'],
                    reflection: reflection['isi'],
                    imagePath: 'assets/images/renungan.jpeg', // Static image path
                    author: reflection['sumber'],
                    onTap: () {
                      // Navigate to ArtikelDetailPage and pass data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtikelDetailPage(
                            title: reflection['judul'],
                            date: reflection['date_create'],
                            isi: reflection['isi'],
                            reflection: reflection['isi'],
                            imagePath: 'assets/images/renungan.jpeg', // Static image path
                            sumber: reflection['sumber'],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Footer
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

  Widget buildReflectionCard({
    required String title,
    required String date,
    required String verse,
    required String reflection,
    required String imagePath,
    required String author,
    required VoidCallback onTap, // New parameter for onTap function
  }) {
    return GestureDetector(
      onTap: onTap, // Use the onTap function passed from outside
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                     verse.length <= 100 ? verse : '${verse.substring(0, 100)}...',
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Penulis: $author',
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
