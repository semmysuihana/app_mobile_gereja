import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import GestureRecognizer
import 'nav_drawer.dart'; // Import NavDrawer
import 'home_page.dart'; // Pastikan untuk mengimport HomePage jika belum diimport

class SejarahPage extends StatelessWidget {
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
                              text: 'Sejarah',
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
                    'Sejarah',
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
                  SizedBox(height: 10),
                  Text(
                    'Melalui surat keputusan Majelis Sinode GPIB No. 0274/75/MS/XI/KPTS, tanggal 24 Februari 1975 perihal pembatalan SK tanggal 18 Februari 1975. Tapi SK tidak dilaksanakan, keputusan ini membuat sebagian jemaat Eirene yang masih menghendaki bimbingan dan pimpinan Pdt. E.F. Tokoh kecewa dan bersepakat membentuk suatu kesatuan jemaat baru, dengan surat pernyataan pelepasan diri dari keanggotaan GPIB jemaat Eirene tertanggal 25 Juli 1975, terhitung mulai tanggal 4 Mei 1975',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/gereja_lama.jpg',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Surat pelepasan diri dari keanggotaan Eirene ditanda-tangani oleh: Bapak. Dimoe Djami, Bapak Hengki Thoerhakh, Bapak Paulus Selly, dan Bapak D.T Nisah Pih. Jemaat yang berbakti di Jl. Gadang No.73',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/gereja.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dengan doa dan pergumulan selama beberapa bulan akhirnya persekutuan ini diberi nama Yayasan Gereja Protestan Soteria (GPS). Nama ini disepakati oleh beberapa orang pemuka persekutuan mewakili jemaat bersama Bpk. Pdt E.F Tokoh, selanjutnya persekutuan ini didaftarkan secara hukum dengan Akte Notaris Ridwan Susilo No. 313 tahun 1976 (Yayasan Gereja Protestan Soteria di Indonesia).',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status gereja Protestan pada awalnya bernaung di bawah Yayasan Gereja Protestan Soteria di Indonesia, dan sebagai bentuk usaha Yayasan adalah mendirikan sekolah tinggi teologi, rumah sakit/klinik, kepramukaan dan usaha-usaha sosial lainya. Waktu berjalan terus berkat doa dan pertolongan Tuhan jemaat Soteria mendapatkan tanah dan gubuk di tengah-tengah empang, tepatnya di Jl. Gembira Terusan No. 24 Tanjung Priok dan dalam waktu tidak terlalu lama pada tanggal 7 Desember 1975 bangunan rumah tersebut direnovasi menjadi bangunan semi permanen.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pada hari Minggu tanggal 21 Desember 1975 bangunan tersebut dipergunakan sebagai gedung gereja Protestan Soteria (GPS) Ini adalah gedung Gereja Protestan Soteria semi permanen.Gereja ini terletak di tengah-tengah empang atau dikenal dengan gereja empang atau gereja Timor, Jl Gembira Terusan No. 24 Tg Priok.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/bg_gereja.jpg',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Seminggu kemudian, lonceng kuningan ini sudah terpasang pada menara pertama Gereja Protestan Soteria. Lonceng ini akan dibunyikan setiap Minggu pagi dan sore sebelum kebaktian dimulai.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kemudian daripada itu untuk mendapatkan legalitas dari pemerintah, maka GPSI Soteria didaftarkan pada kantor Wilayah Departemen DKI Jakarta dengan No. L.j./5/1650/143/76 tertanggal 13 Oktober 1976 dan Departemen Agama Republik Indonesia, melalui Direktorat Bimbingan Masyarakat Kristen Protestan dengan No. E.Ket.376/1628/76 tertanggal 25 Oktober 1976.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selanjutnya untuk menangani organisasi gereja dan pelayanan firman Tuhan dibentuklah pengurus tingkat pusat yang disebut : Badan Pekerja Am (BPAm), yang mengatur anggaran dasar (AD) dan anggaran rumah tangga (ART) dan kemudian dari itu dibentuklah komisi-komisi yang menunjang kegiatan gereja seperti : Komisi Sekolah Minggu, Komisi Pemuda, Komisi Wanita, Komisi Pendidikan, Komisi Pembangunan, Komisi Sosial dan lain-lain, sesuai dengan AD ART Yayasan Protestan Soteria.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dalam pertumbuhan Yayasan Gereja Protestan Soteria di Indonesia menyesuaikan status gereja sebagai suatu organisasi masyarakat sesuai UU No. 8 tahun 1985, melalui Akte Notaris N.R Makahanap No. 37 tanggal 17 Juni 1987.Setelah diadakan perubahan anggaran dasar (AD) Yayasan GPSI ditetapkan status GPSI suatu organisasi masyarakat, yang artinya tidak lagi bernaung di bawah Yayasan.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Demikian selayang pandang berdirinya GPSI Soteria di Jl. Gembira Terusan No. 24.Kelurahan Sungai Bambu, Tanjung Priok.Jakarta Utara.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
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
