import 'dart:convert';

import 'package:finalsatu/views/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrasiPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final nameku = TextEditingController();
  final usernameku = TextEditingController();
  final passwordku = TextEditingController();
  final emailku = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameku.dispose();
    usernameku.dispose();
    passwordku.dispose();
    emailku.dispose();
    super.dispose();
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.lightGreenAccent,
    //primary: Colors.lightGreenAccent,
    //minimumSize: Size(88, 36),
    padding: EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.network(
            'https://www.hacktiv8.com/images/logo/hacktiv8-dark.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailku,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
    final username = TextFormField(
      keyboardType: TextInputType.text,
      controller: usernameku,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
    final name = TextFormField(
      keyboardType: TextInputType.text,
      controller: nameku,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Full name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordku,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Signin(emailku.text, usernameku.text, nameku.text, passwordku.text,
              context);
        },
        child: Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            name,
            SizedBox(height: 8.0),
            username,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 10.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}

Signin(email, username, name, pass, context) async {
  var url = Uri.parse('https://hacktiv8final1.herokuapp.com/register');
  var response = await http.post(url, body: {
    'email': email,
    'name': name,
    'username': username,
    'password': pass
  });
  Map data = jsonDecode(response.body);
  if (data['status'] == true) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
