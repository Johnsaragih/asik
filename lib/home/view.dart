import 'package:asik/pages/cuti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    child: Row(
      children: [Container(child: Text("datas"))],
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
  return new SizedBox(
    //height: 400.0,
    height: MediaQuery.of(context).size.height *0.60,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cuti()));
                    },
                  ),
                  MenuIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.red,
                    label: "Timecard",
                    onPres: () {},
                  ),
                  MenuIcon(
                    icon: Icons.monetization_on,
                    iconColor: Colors.green,
                    label: "Cuti",
                    onPres: () {},
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
                    label: "Info2",
                    onPres: () {},
                  ),
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
              child: Icon(icon, color: Colors.white,size: 40,),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(label,style: TextStyle(fontSize: 16.0),),
        ],
      ),
    );
  }
}
