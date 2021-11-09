import 'package:finalsatu/views/login/login_page.dart';
import 'package:finalsatu/views/task/CreateTask.dart';
import 'package:finalsatu/views/task/ListTask.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  const Homepage({Key? key}) : super(key: key);
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  String _nama = '';
  String _email = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    panggil();
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    // shadowColor: Colors.black,
    primary: Colors.white,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.all(12),
  );
  void panggil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              child: Card(
                child: ListTile(
                  leading: Image.network(
                      "https://www.shareicon.net/data/2016/09/15/829466_man_512x512.png"),
                  title: Text(_nama),
                  subtitle: Text(_email),
                  isThreeLine: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Listtask()),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + 150,
                child: GridView(
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: <Widget>[
                    Card(
                      child: Center(
                        child: Column(
                          children: [
                            Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoBh7ISrVhOEG7_7IRaGQaoRCDgCbxzdH8eHVm1aXDN26H4VmFayff5Rla8nakXfnOsnU&usqp=CAU",
                              height: 150,
                            ),
                            Text("Daftar Reflation")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateTask()),
                        );
                      },
                      child: Card(
                        child: Center(
                          child: Column(
                            children: [
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT15sMuffKauuCv6v5H2StE2cBftuxtF-vcsQyEs79XKLXDnX28RgcQt3Ku2kvJu2TelVs&usqp=CAU",
                                height: 150,
                              ),
                              Text("Tambah Reflation")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Login(context);
                },
                child: Text(
                  "Keluar",
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Login(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
