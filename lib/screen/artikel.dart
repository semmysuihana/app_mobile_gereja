import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'nav_drawer.dart';
import 'home_page.dart';
import 'artikel_detail.dart';
import 'koneksi_api.dart'; // Import the API connection file

class Artikel extends StatefulWidget {
  @override
  _ArtikelState createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  int _visibleArticleCount = 3;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Map<String, dynamic>> reflections = []; // Initialize the list

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreArticles();
    }
  }

  void _loadMoreArticles() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _visibleArticleCount += 3;
        _isLoading = false;
      });
    });
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> articles = await ApiService.fetchBlog();
      setState(() {
        reflections = articles;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // You might want to show an error message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPSI SOTERIA'),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'Artikel',
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
                                text: 'Artikel',
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

              SizedBox(height: 20),

              // Artikel Section
              Column(
                children: _buildArticles(),
              ),

              // Load More button or loading indicator
              if (_isLoading)
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              if (!_isLoading && _visibleArticleCount < reflections.length)
                TextButton(
                  onPressed: _loadMoreArticles,
                  child: Text('Load More'),
                ),

              // Footer
              Container(
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
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildArticles() {
    List<Widget> widgets = [];

    for (int i = 0; i < _visibleArticleCount && i < reflections.length; i++) {
      widgets.add(Column(
        children: [
          buildReflectionCard(
            title: reflections[i]['judul'],
            date: reflections[i]['date_create'],
            verse: reflections[i]['isi'],
            reflection: reflections[i]['isi'],
            imagePath: 'assets/images/renungan.jpeg', // Static image path
            author: reflections[i]['sumber'],
          ),
          SizedBox(height: 20),
        ],
      ));
    }

    return widgets;
  }

  Widget buildReflectionCard({
    required String title,
    required String date,
    required String verse,
    required String reflection,
    required String imagePath,
    required String author,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtikelDetailPage(
              title: title,
              date: date,
              isi: verse,
              reflection: reflection,
              sumber: author,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 200, // Adjust height as needed
                width: double.infinity, // Adjust width as needed
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                verse.length <= 100 ? verse : '${verse.substring(0, 100)}...',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '- $author',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
