import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'student_dashboard.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StudentDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.indigo.shade900)
                    : null,
              ),
            ),
            SizedBox(height: 20),

            // Editable Fields
            ProfileDetail(icon: Icons.person, label: "Name", controller: nameController),
            ProfileDetail(icon: Icons.school, label: "Branch", controller: branchController),
            ProfileDetail(icon: Icons.calendar_today, label: "Year", controller: yearController),
            ProfileDetail(icon: Icons.phone, label: "Mobile No", controller: mobileController),
            ProfileDetail(icon: Icons.email, label: "Email", controller: emailController),
            SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Editable Profile Details
class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;

  ProfileDetail({required this.icon, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo.shade900),
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
