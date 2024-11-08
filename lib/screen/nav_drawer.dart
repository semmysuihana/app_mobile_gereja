import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    setState(() {
      _username = null;
    });
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                if (_username != null)
                  Text(
                    'Welcome, $_username!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/'); // Navigate to home page
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.info),
            title: Text('Tentang'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Sejarah'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/sejarah'); // Navigate to history page
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Visi & Misi'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/visi_misi'); // Navigate to vision-mission page
                },
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Majelis Jemaat'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/majelis_jemaat'); // Navigate to council page
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Artikel'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/artikel'); // Navigate to articles page
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Kegiatan Minggu ini'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/kegiatan'); // Navigate to current week's activities page
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Kontak'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/kontak'); // Navigate to contact page
            },
          ),
          SizedBox(height: 20), // Add some space before the login/logout button
          if (_username != null)
            ExpansionTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.dashboard_customize),
                  title: Text('View Dashboard'),
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pushNamed(context, '/dashboard'); // Navigate to dashboard page
                  },
                ),
              ListTile(
                leading: Icon(Icons.article), // Updated icon to represent a blog
                title: Text('Blog'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/blog'); // Navigate to blog page
                },
              ),
              ListTile(
                leading: Icon(Icons.person), // Updated icon to represent a blog
                title: Text('Users'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/user'); // Navigate to blog page
                },
              ),
              ListTile(
                leading: Icon(Icons.event_available),
                title: Text('Kegiatan'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/kegiatan_admin'); // Navigate to current week's activities page
                },
              ),
              ],
            ),
          if (_username != null)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await _logout();
              },
            )
          else
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/login'); // Navigate to login page
              },
            ),
        ],
      ),
    );
  }
}
