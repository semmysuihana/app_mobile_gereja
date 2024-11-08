import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../koneksi_api.dart'; // Import ApiService class

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _addUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final String name = _nameController.text;
        final String email = _emailController.text;
        final String password = _passwordController.text;

        await ApiService.addUser({
          'nama': name,
          'email': email,
          'password': password, // Include password
        });

        Fluttertoast.showToast(msg: 'User added successfully');
        Navigator.pop(context, true); // Return true to indicate that the user was added
      } catch (e) {
        print('Error: $e');
        Fluttertoast.showToast(msg: 'Error adding user');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // Add additional email validation if needed
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // Hide the password text
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addUser,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
