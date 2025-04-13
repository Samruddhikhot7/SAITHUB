import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'admin_dashboard.dart';
import 'student_dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedRole = "";

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (selectedRole == "Admin") {
        if (usernameController.text == "admin" && passwordController.text == "admin123") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        } else {
          _showErrorMessage("Invalid Admin Credentials");
        }
      } else if (selectedRole == "Student") {
        if (usernameController.text == "student" && passwordController.text == "student123") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentDashboard()),
          );
        } else {
          _showErrorMessage("Invalid Student Credentials");
        }
      } else {
        _showErrorMessage("Please select a role");
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade900, Colors.blue.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: 15),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Welcome To\n SAITHub",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
                            ),
                            SizedBox(height: 20),
                            ToggleButtons(
                              isSelected: [selectedRole == "Student", selectedRole == "Admin"],
                              onPressed: (int index) {
                                setState(() {
                                  selectedRole = index == 0 ? "Student" : "Admin";
                                });
                              },
                              borderRadius: BorderRadius.circular(8),
                              selectedColor: Colors.white,
                              fillColor: Colors.indigo.shade900,
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("STUDENT")),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("ADMIN")),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) => value!.isEmpty ? "Enter username" : null,
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (value) => value!.length < 6 ? "Password must be 6+ chars" : null,
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text("LOGIN", style: TextStyle(color:Colors.indigo.shade900, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                              },
                              child: Text("Don't have an account? Sign Up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo.shade900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
