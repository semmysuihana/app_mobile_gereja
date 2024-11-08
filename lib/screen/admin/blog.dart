import 'package:flutter/material.dart';
import '../koneksi_api.dart'; // Import ApiService class
import '../nav_drawer.dart';
import '../artikel_detail.dart'; // Import ArtikelDetailPage
import 'add_blog_page.dart'; // Import AddBlogPage

class Blog {
  final String id;
  final String profId;
  final String sumber;
  final String judul;
  final String fileName;
  final String isi;
  final DateTime dateCreate; // Changed to DateTime
  final String status;

  Blog({
    required this.id,
    required this.profId,
    required this.sumber,
    required this.judul,
    required this.fileName,
    required this.isi,
    required this.dateCreate,
    required this.status,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      profId: json['prof_id'],
      sumber: json['sumber'],
      judul: json['judul'],
      fileName: json['file_name'],
      isi: json['isi'],
      dateCreate: DateTime.parse(json['date_create']), // Convert to DateTime
      status: json['status'],
    );
  }

  static Future<List<Blog>> fetchBlog() async {
    List<Map<String, dynamic>> jsonList = await ApiService.fetchBlog();
    return jsonList.map((json) => Blog.fromJson(json)).toList();
  }
}

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<List<Blog>> _blogPosts;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _blogPosts = Blog.fetchBlog();
  }

  void _deleteBlog(String id) {
    // Implement delete functionality
  }

  void _editBlog(Blog blog) {
    // Implement edit functionality
  }

  void _viewDetails(Blog blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtikelDetailPage(
          title: blog.judul,
          date: blog.dateCreate.toLocal().toString(), // Display formatted date
          isi: blog.isi,
          reflection: blog.isi,
          imagePath: 'assets/images/renungan.jpeg', // Replace with a valid image path or URL
          sumber: blog.sumber,
        ),
      ),
    );
  }

  Future<void> _navigateToAddBlog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBlogPage()),
    );

    if (result == true) {
      setState(() {
        _blogPosts = Blog.fetchBlog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddBlog,
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: FutureBuilder<List<Blog>>(
        future: _blogPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load blog posts'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No blog posts available'));
          } else {
            final filteredPosts = snapshot.data!.where((post) {
              return post.judul.toLowerCase().contains(_searchText.toLowerCase());
            }).toList();

            // Sort the filteredPosts by dateCreate in descending order (newest first)
            filteredPosts.sort((a, b) => b.dateCreate.compareTo(a.dateCreate));

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _searchText = text;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final blogPost = filteredPosts[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(blogPost.judul),
                          subtitle: Text('${blogPost.sumber}\n${blogPost.dateCreate.toLocal().toString()}'), // Display date
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.details),
                                onPressed: () => _viewDetails(blogPost),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editBlog(blogPost),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteBlog(blogPost.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
