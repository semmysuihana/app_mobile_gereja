import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'http://192.168.1.5/gpsi/';
  static const String _token = 'fd1e85db9d100aaece935e903dfa657b';

  // Method to fetch users
  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    final url = Uri.parse('${_baseUrl}users.php?token=$_token');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedJson = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return decodedJson;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Method to delete a user
  static Future<void> deleteUser(String id) async {
    final url = Uri.parse('${_baseUrl}delete_user.php?token=$_token');

    final response = await http.post(
      url,
      body: {'id': id},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  // Method to add a user
  static Future<void> addUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('${_baseUrl}add_user.php?token=$_token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }

  // Method to update a user
  static Future<void> updateUser(String id, String name, String email) async {
    final url = Uri.parse('${_baseUrl}update_user.php?token=$_token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'id': id,
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  // Method to fetch blogs
  static Future<List<Map<String, dynamic>>> fetchBlog() async {
    final url = Uri.parse('${_baseUrl}blog.php?token=$_token');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedJson = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return decodedJson;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Method to add a blog
  static Future<void> addBlog(Map<String, dynamic> blogData) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}add_blog.php'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
      body: json.encode(blogData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add blog post');
    }
  }

  // Method to fetch activities
  static Future<List<Map<String, dynamic>>> fetchKegiatan() async {
    final url = Uri.parse('${_baseUrl}kegiatan.php?token=$_token');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedJson = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return decodedJson;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Method to add activities
  static Future<void> addKegiatan(String hari, String tanggal, String pukul, String keterangan, String ibadah) async {
    final url = Uri.parse('${_baseUrl}add_kegiatan.php?token=$_token');

    final body = jsonEncode(<String, String>{
      'hari': hari,
      'tanggal': tanggal,
      'pukul': pukul,
      'keterangan': keterangan,
      'ibadah': ibadah,
    });

    print('Request body: $body');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add kegiatan. Server responded with: ${response.body}');
    }
  }

  // Method to edit an activity
  static Future<void> editKegiatan(String id, String nama, String tanggal, String pukul, String keterangan, String ibadah) async {
    final url = Uri.parse('${_baseUrl}edit_kegiatan.php?token=$_token');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nama': nama,
        'tanggal': tanggal,
        'pukul': pukul,
        'keterangan': keterangan,
        'ibadah': ibadah,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update kegiatan');
    }
  }

  // Method to delete an activity
  static Future<void> deleteKegiatan(String id) async {
    final url = Uri.parse('${_baseUrl}delete_kegiatan.php?token=$_token');

    final response = await http.post(
      url,
      body: {'id': id},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete kegiatan');
    }
  }

  // Method to login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${_baseUrl}login.php?token=$_token');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
