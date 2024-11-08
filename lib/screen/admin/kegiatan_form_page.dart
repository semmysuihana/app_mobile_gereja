import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../koneksi_api.dart';
import 'kegiatan_admin.dart';

class KegiatanFormPage extends StatefulWidget {
  final Kegiatan? kegiatan;

  KegiatanFormPage({Key? key, this.kegiatan}) : super(key: key);

  @override
  _KegiatanFormPageState createState() => _KegiatanFormPageState();
}

class _KegiatanFormPageState extends State<KegiatanFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tanggalController;
  late TextEditingController pukulController;
  late TextEditingController keteranganController;
  late TextEditingController ibadahController;
  String? hari;

  @override
  void initState() {
    super.initState();
    tanggalController = TextEditingController(text: widget.kegiatan?.tanggal);
    pukulController = TextEditingController(text: widget.kegiatan?.pukul);
    keteranganController = TextEditingController(text: widget.kegiatan?.keterangan);
    ibadahController = TextEditingController(text: widget.kegiatan?.ibadah);

    // Initialize hari based on existing date
    if (widget.kegiatan?.tanggal != null) {
      _updateHariFromDate(widget.kegiatan!.tanggal);
    }

    tanggalController.addListener(_updateHari);
  }

  @override
  void dispose() {
    tanggalController.dispose();
    pukulController.dispose();
    keteranganController.dispose();
    ibadahController.dispose();
    super.dispose();
  }

  void _updateHari() {
    if (tanggalController.text.isNotEmpty) {
      _updateHariFromDate(tanggalController.text);
    } else {
      setState(() {
        hari = null;
      });
    }
  }

  void _updateHariFromDate(String date) {
    try {
      DateTime tanggal = DateFormat('yyyy-MM-dd').parse(date);
      String hari = DateFormat('EEEE', 'id').format(tanggal);
      setState(() {
        this.hari = hari;
      });
    } catch (e) {
      // Handle parsing error if any
      setState(() {
        hari = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
        _updateHariFromDate(tanggalController.text); // Update hari when date is picked
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // Get the current date
      final now = DateTime.now();
      // Convert picked TimeOfDay to DateTime in UTC, then add 7 hours to convert to WIB
      final pickedTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      ).toUtc().add(Duration(hours: 7)); // Adjust for WIB (UTC +7)

      setState(() {
        // Format the time in 24-hour format
        pukulController.text = DateFormat('HH:mm').format(pickedTime);
      });
    }
  }

  Future<void> _saveKegiatan() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (widget.kegiatan == null) {
          // Add new kegiatan
          await ApiService.addKegiatan(
            hari ?? '', // Ensure hari is correctly set
            tanggalController.text,
            pukulController.text, // WIB time
            keteranganController.text,
            ibadahController.text,
          );
          Fluttertoast.showToast(msg: 'Kegiatan added successfully');
        } else {
          // Edit existing kegiatan
          await ApiService.editKegiatan(
            widget.kegiatan!.id,
            hari ?? '', // Ensure hari is correctly set
            tanggalController.text,
            pukulController.text, // WIB time
            keteranganController.text,
            ibadahController.text,
          );
          Fluttertoast.showToast(msg: 'Kegiatan updated successfully');
        }
        Navigator.of(context).pop(true); // Return to previous screen and indicate success
      } catch (e) {
        print('Error: $e');
        Fluttertoast.showToast(msg: 'Error saving kegiatan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kegiatan == null ? 'Add Kegiatan' : 'Edit Kegiatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Tanggal';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pukulController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Pukul',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Pukul';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: keteranganController,
                decoration: InputDecoration(labelText: 'Keterangan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Keterangan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ibadahController,
                decoration: InputDecoration(labelText: 'Ibadah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Ibadah';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (hari != null) Text('Hari: $hari'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveKegiatan,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
