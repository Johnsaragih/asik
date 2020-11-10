import 'package:asik/login.dart';
import 'package:asik/pages/absen.dart';
import 'package:asik/pages/timecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        //  appBar: new AsikAppBar(),
        backgroundColor: Colors.white70,
        body: new Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              _topMenu(),
              _mainMenu(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _topMenu() {
  return new Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Container(
            child: Column(
              children: [
                Text(
                  "Welcome to ASIK",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Aplikasi System Informasi Karyawan",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
    height: 130,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF1565C0), const Color(0xFF90CAF9)],
        ),
        borderRadius: new BorderRadius.only(
            bottomLeft: new Radius.circular(30.0),
            bottomRight: new Radius.circular(30.0))),
  );
}

Widget _mainMenu(context) {
  void _logout() async {
    SharedPreferences logout = await SharedPreferences.getInstance();
    await logout.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Login(),
        ));
  }

  return new SizedBox(
    //height: 400.0,
    height: MediaQuery.of(context).size.height * 0.60,
    child: new Container(
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  MenuIcon(
                    icon: Icons.local_library,
                    iconColor: Colors.green,
                    label: "Personal",
                    onPres: () {
                     
                    },
                  ),
                  MenuIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.red,
                    label: "Timecard",
                    onPres: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Timecard()));
                    },
                  ),
                  MenuIcon(
                    icon: Icons.monetization_on,
                    iconColor: Colors.green,
                    label: "Absen",
                    onPres: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Absen()));
                    },
                  ),
                  MenuIcon(
                    icon: Icons.airplay,
                    iconColor: Colors.blueGrey,
                    label: "Absen Masuk",
                    onPres: () {},
                  ),
                  MenuIcon(
                    icon: Icons.dvr,
                    iconColor: Colors.purple,
                    label: "Info",
                    onPres: () {},
                  ),
                  MenuIcon(
                      icon: Icons.storage,
                      iconColor: Colors.green,
                      label: "Logout",
                      onPres: () {
                        _logout();
                      }),
                  MenuIcon(
                    icon: Icons.textsms,
                    iconColor: Colors.red,
                    label: "Kritik/Saran",
                    onPres: () {},
                  ),
                  MenuIcon(
                    icon: Icons.developer_board,
                    besar: 90,
                    iconColor: Colors.blue,
                    label: "Tentang",
                    onPres: () {},
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    ),
  );
}

class MenuIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Function onPres;
  final double besar;

  MenuIcon({this.icon, this.iconColor, this.label, this.onPres, this.besar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPres,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.9),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
