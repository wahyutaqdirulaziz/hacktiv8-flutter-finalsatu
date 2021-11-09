import 'dart:convert';
import 'package:finalsatu/views/home/homepage.dart';
import 'package:finalsatu/views/login/Registrasi_page%20.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cek();
  }

  void cek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _ambiltext = prefs.getBool('status');
    if (_ambiltext == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      print(_ambiltext);
    }
  }

  final passwordku = TextEditingController();
  final emailku = TextEditingController();
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
          Login(emailku.text, passwordku.text, context);
        },
        child: Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    final forgotLabel = TextButton(
      onPressed: () {},
      child: Text(
        "Forgot password?",
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );

    final regLabel = TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrasiPage()),
        );
      },
      child: Text(
        "Create account !",
        style: TextStyle(
          color: Colors.black54,
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
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            regLabel,
          ],
        ),
      ),
    );
  }
}

Future<void> Login(email, pass, context) async {
  var url = Uri.parse('https://hacktiv8final1.herokuapp.com/login');
  var response = await http.post(url, body: {'email': email, 'password': pass});
  Map<String, dynamic> data = jsonDecode(response.body);
  if (data['status'] == true) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('status', data['status']);
    await prefs.setString('name', data['data']['name']);
    await prefs.setString('email', data['data']['email']);
    await prefs.setString('token', data['token']);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Column(
            children: [
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.network(
                      'https://www.hacktiv8.com/images/logo/hacktiv8-dark.png'),
                ),
              ),
              Text(data['message']),
            ],
          ),
        );
      },
    );
  }

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
