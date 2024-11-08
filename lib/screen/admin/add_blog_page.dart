import 'package:flutter/material.dart';
import '../koneksi_api.dart'; // Import ApiService class
import 'package:intl/intl.dart'; // Import intl package for date formatting

class AddBlogPage extends StatefulWidget {
  @override
  _AddBlogPageState createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _sumberController = TextEditingController();
  final _fileNameController = TextEditingController();
  final _verseController = TextEditingController();
  final _isiController = TextEditingController();
  final _dateCreateController = TextEditingController();
  final _statusController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the _dateCreateController with the current date
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    _dateCreateController.text = formattedDate;
  }

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    // Collect form data
    final newBlog = {
      'judul': _judulController.text,
      'sumber': _sumberController.text,
      'file_name': _fileNameController.text,
      'verse': _verseController.text,
      'isi': _isiController.text,
      'date_create': _dateCreateController.text,
      'status': _statusController.text,
      'author': _authorController.text,
    };

    // Send data to the server
    try {
      await ApiService.addBlog(newBlog); // Implement the addBlog method in ApiService
      
      // Show success alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Blog has been added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the alert dialog
                  Navigator.pop(context, true); // Return to previous page with result
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView( // Ensure the form can scroll
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: InputDecoration(labelText: 'Judul'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sumberController,
                  decoration: InputDecoration(labelText: 'Sumber'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a source';
                    }
                    return null;
                  },
                ),
                
                TextFormField(
                  controller: _isiController,
                  decoration: InputDecoration(labelText: 'Isi'),
                ),
                TextFormField(
                  controller: _dateCreateController,
                  decoration: InputDecoration(labelText: 'Date Create'),
                  readOnly: true, // Make the date field read-only
                ),
                SizedBox(height: 20), // Adjusted height for better spacing
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
