import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../nav_drawer.dart';
import '../koneksi_api.dart';
import 'add_user_page.dart'; // Import AddUserPage

class User {
  final String id;
  final String nama;
  final String email;
  final String joinDate;

  User({required this.id, required this.nama, required this.email, required this.joinDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['prof_id'],
      nama: json['nama'],
      email: json['email'],
      joinDate: json['joinDate'],
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<List<User>> _users;
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _users = fetchUsersData();
    _searchController.addListener(_filterUsers);
  }

  Future<List<User>> fetchUsersData() async {
    try {
      List<Map<String, dynamic>> userData = await ApiService.fetchUsers();
      List<User> users = userData.map((json) => User.fromJson(json)).toList();
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
      });
      return users;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  void _filterUsers() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.nama.toLowerCase().contains(searchQuery) ||
               user.email.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  Future<void> deleteUserData(String id) async {
    try {
      await ApiService.deleteUser(id);
      Fluttertoast.showToast(msg: 'User deleted successfully');
      setState(() {
        _users = fetchUsersData();
      });
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error deleting user');
    }
  }

  void _editUserData(User user) {
    // Implement your edit functionality here
    // For now, let's just show a toast message
    Fluttertoast.showToast(msg: 'Edit user: ${user.nama}');
  }

  Future<void> _navigateToAddUser() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUserPage()),
    );

    if (result == true) {
      setState(() {
        _users = fetchUsersData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddUser,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users available'));
          } else {
            return ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(user.nama),
                    subtitle: Text('Email: ${user.email}\nJoined: ${user.joinDate}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editUserData(user);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteUserData(user.id);
                          },
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
    );
  }
}
