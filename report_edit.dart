import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ReportEdit extends StatefulWidget {
  @override
  _ReportEditState createState() => _ReportEditState();
}

class _ReportEditState extends State<ReportEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Report Submitted Successfully!")),
      );
      // Clear input fields after submission
      _eventNameController.clear();
      _dateController.clear();
      _linkController.clear();
      _participantsController.clear();
      setState(() {
        _selectedFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Report", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo.shade900,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_eventNameController, "Event Name"),
              _buildTextField(_dateController, "Date", keyboardType: TextInputType.datetime),
              _buildTextField(_linkController, "Event Link", keyboardType: TextInputType.url),
              _buildTextField(_participantsController, "No. of Participants", keyboardType: TextInputType.number),
              SizedBox(height: 20),

              // File Upload Section
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.upload_file),
                label: Text("Upload Report PDF"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade900,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              if (_selectedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Selected File: ${_selectedFile!.path.split('/').last}",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),

              SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitReport,
                  child: Text("Submit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
