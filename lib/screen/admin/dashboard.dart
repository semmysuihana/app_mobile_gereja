import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blog.dart'; // Import the blog.dart file
import '../nav_drawer.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _username;
  Future<List<Blog>>? _blogPosts;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _blogPosts = Blog.fetchBlog();
  }

  Future<void> _fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_username != null)
              Text(
                'Hello, $_username!',
                style: TextStyle(fontSize: 20),
              ),
            if (_username == null)
              CircularProgressIndicator(),
            SizedBox(height: 20),
            FutureBuilder<List<Blog>>(
              future: _blogPosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Failed to load blog posts');
                } else if (snapshot.hasData) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Icon for the logo
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.article,
                              size: 50,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Blog Posts',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Count: ${snapshot.data!.length}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to Blog page
                                    Navigator.pushNamed(context, '/blog');
                                  },
                                  child: Text('Detail'),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                } else {
                  return Text('No blog posts available');
                }
              },
            ),
           
          ],
        ),
      ),
    );
  }
}
