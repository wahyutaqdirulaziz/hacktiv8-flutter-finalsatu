import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Listtask extends StatefulWidget {
  const Listtask({Key? key}) : super(key: key);

  @override
  _ListtaskState createState() => _ListtaskState();
}

class _ListtaskState extends State<Listtask> {
  final String apiUrl = "https://hacktiv8final1.herokuapp.com/reflections";
  Future<List<dynamic>> _fecthDataUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _token = prefs.getString('token') ?? '';
    var result = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'authorization': "$_token",
    });
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Data reflections', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                            "https://cdn2.vectorstock.com/i/1000x1000/57/36/book-icon-isolated-on-round-background-vector-15985736.jpg"),
                        title: Text(snapshot.data[index]['success']),
                        subtitle: Text(snapshot.data[index]['low_point']),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
