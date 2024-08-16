// ignore_for_file: prefer_const_constructors
import 'package:blogcom/about.dart';
import 'package:blogcom/contact.dart';
import 'package:blogcom/posts.dart';
import 'package:blogcom/productdetail.dart';
import 'package:blogcom/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BLOGCOM"),
      ),
      drawer: Drawer(
        // backgroundColor: const Color.fromARGB(255, 190, 202, 223),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Text("BLOGCOM"),
            ),
            // const Divider(),
            Drawercontainer(
                const About(), context, "About", Icons.article_rounded),
            Drawercontainer(
                const Contact(), context, "Contact", Icons.contact_page),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.create), label: "Create"),
            NavigationDestination(
                icon: Icon(Icons.insert_chart_outlined_rounded), label: "Read")
          ]),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          containers(context, Icons.book, "Posts", Colors.red, Posts()),
          containers(context, CupertinoIcons.arrow_turn_left_up, "OK",
              Colors.green, Products()),
          containers(context, CupertinoIcons.burst, "Burst", Colors.blue, null),
          containers(context, CupertinoIcons.app_badge_fill, "APP",
              const Color.fromARGB(255, 242, 145, 177), null),
          containers(
              context, Icons.wifi_lock_sharp, "Burst", Colors.amber, null),
          containers(
              context, Icons.apple_sharp, "Apple", Colors.deepPurple, null),
        ],
      ),
    );
  }
}

///
///
///
/// Anasayfadaki diğer sayfalara gitmeye yarayan containerlerın şablonu
///
///

Widget containers(
  BuildContext context,
  IconData icon,
  String title,
  Color clr,
  Widget? destination,
) =>
    InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailPage(heading: title, clr: clr, icon: icon),
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: clr,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(color: Colors.black38, blurRadius: 20),
            ],
            border: Border.all(
                color: Colors.black54, width: 1, style: BorderStyle.solid)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                ),
              )
            ]),
      ),
    );

class DetailPage extends StatelessWidget {
  late String heading;
  late Color clr;
  late IconData icon;

  DetailPage(
      {required this.heading, this.clr = Colors.red, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clr,
        centerTitle: true,
        title: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(heading),
          ],
        ),
      ),
    );
  }
}

///
///
/// Drawer içindeki menülerin şablonu
///
///
Widget Drawercontainer(
        Widget page, BuildContext context, String text, IconData icon) =>
    InkWell(
      hoverColor: Colors.red,
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        height: 50,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(right: 10), child: Icon(icon)),
              Text(
                text,
              )
            ],
          ),
        ),
      ),
    );
