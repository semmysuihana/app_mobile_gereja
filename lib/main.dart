import 'package:flutter/material.dart';
import 'screen/home_page.dart'; // Sesuaikan dengan lokasi file HomePage.dart
import 'screen/sejarah.dart'; // Sesuaikan dengan lokasi file SejarahPage.dart
import 'screen/visi_misi.dart'; // Sesuaikan dengan lokasi file SejarahPage.dart
import 'screen/majelis_jemaat.dart';
import 'screen/Artikel.dart';
import 'screen/kegiatan.dart';
import 'screen/kontak.dart';
import 'screen/login.dart';
import 'screen/admin/dashboard.dart';
import 'screen/admin/blog.dart';
import 'screen/admin/user.dart';
import 'screen/admin/kegiatan_admin.dart';
void main() {
  // Required for webview_flutter package
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/sejarah': (context) => SejarahPage(),
        '/visi_misi': (context) => VisiMisiPage(),
        '/majelis_jemaat': (context) => MajelisJemaat(),
        '/artikel': (context) => Artikel(),
        '/kegiatan': (context) => KegiatanPage(),
        '/kontak': (context) => KontakPage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/blog': (context) => BlogPage(),
        '/user': (context) => UserPage(),
        '/kegiatan_admin': (context) => KegiatanAdminPage(),
        // Tambahkan rute untuk halaman lain di sini jika diperlukan
      },
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
    );
  }
}
