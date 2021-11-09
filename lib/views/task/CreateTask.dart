import 'dart:convert';
import 'package:finalsatu/views/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title:
            Text('Tambah reflections', style: TextStyle(color: Colors.white)),
      ),
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final s = TextEditingController();
  final l = TextEditingController();
  final t = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: s,
            decoration: const InputDecoration(
              hintText: 'Enter your success',
              labelText: 'success',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: l,
            decoration: const InputDecoration(
              hintText: 'Enter your low point',
              labelText: 'low point',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid phone number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: t,
            decoration: const InputDecoration(
              hintText: 'Enter your take away',
              labelText: 'take away',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid date';
              }
              return null;
            },
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new RaisedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    // ICf the form is valid, display a Snackbar.
                    Createt(s.text, l.text, t.text, context);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Data is in processing.')));
                  }
                },
              )),
        ],
      ),
    );
  }
}

Createt(s, l, t, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _token = prefs.getString('token') ?? '';
  var url = Uri.parse('https://hacktiv8final1.herokuapp.com/reflections');
  var response = await http.post(url, body: {
    'success': s,
    'low_point': l,
    'take_away': t,
  }, headers: {
    'authorization': "$_token",
  });
  Map data = jsonDecode(response.body);
  if (data['status'] == true) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
