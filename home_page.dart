import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'about_us.dart';
import 'setting_page.dart';
import 'profile_see.dart';
import 'techfusion.dart';
import 'club_service.dart';
import 'activities.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _navigateTo(String page) {
    if (page == 'About Us') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
    } else if (page == 'Settings') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
    } else if (page == 'Logout') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: PopupMenuButton<String>(
          icon: Image.asset('assets/logo.png', width: 40),
          onSelected: _navigateTo,
          itemBuilder: (context) => [
            PopupMenuItem(value: 'About Us', child: Text('About Us')),
            PopupMenuItem(value: 'Settings', child: Text('Settings')),
            PopupMenuItem(value: 'Logout', child: Text('Logout')),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSee()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Image Carousel
                  Container(
                    height: 200,
                    child: PageView(
                      children: [
                        Image.asset('assets/image1.jpg', fit: BoxFit.cover),
                        Image.asset('assets/image2.jpg', fit: BoxFit.cover),
                        Image.asset('assets/image3.jpg', fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Grid View for Navigation
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: [
                      _buildCategoryCard('TechFusion', 'assets/techfusion.jpg', Techfusion()),
                      _buildCategoryCard('Club Service', 'assets/clubservice.jpg', ClubService()),
                      _buildCategoryCard('Activities', 'assets/activities.jpg', Activities()),
                      _buildCategoryCard('About Us', 'assets/aboutus.jpg', AboutUs()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
