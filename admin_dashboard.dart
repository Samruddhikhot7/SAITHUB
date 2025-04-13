import 'package:flutter/material.dart';
import 'report.dart';
import 'report_edit.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedRole = "";

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (selectedRole == "Teacher") {
        if (usernameController.text == "teacher" &&
            passwordController.text == "teacher123") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Report()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Invalid Teacher Credentials")));
        }
      } else if (selectedRole == "Member") {
        if (usernameController.text == "member" &&
            passwordController.text == "member123") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReportEdit()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Invalid Member Credentials")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select a role")));
      }
    }
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Admin Dashboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Role Selection
                      Text(
                        "Select Role",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 10),

                      ToggleButtons(
                        borderRadius: BorderRadius.circular(10),
                        selectedColor: Colors.white,
                        fillColor: Colors.indigo.shade800,
                        color: Colors.black54,
                        selectedBorderColor: Colors.indigo,
                        isSelected: [
                          selectedRole == "Teacher",
                          selectedRole == "Member"
                        ],
                        onPressed: (index) {
                          setState(() {
                            selectedRole = index == 0 ? "Teacher" : "Member";
                          });
                        },
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Teacher", style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Member", style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Username
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person, color: Colors.indigo.shade900),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter username" : null,
                      ),
                      SizedBox(height: 15),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.indigo.shade900),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                        value!.length < 6 ? "Password must be 6+ chars" : null,
                      ),
                      SizedBox(height: 20),

                      // Login Button
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                          backgroundColor: Colors.indigo.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
