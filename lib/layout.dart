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
        child: ListView(children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border(),
              ),
              child: Text("BLOGCOM")),
          ListTile(
            title: Text("Menu 1"),
          ),
          ListTile(
            title: Text("Menu 2"),
          ),
          ListTile(
            title: Text("Menu 3"),
          )
        ]),
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
          containers(
              context, Icons.airplanemode_on_rounded, "Uçak", Colors.red),
          containers(
              context, CupertinoIcons.arrow_turn_left_up, "OK", Colors.green),
          containers(context, CupertinoIcons.burst, "Burst", Colors.blue),
          containers(context, CupertinoIcons.app_badge_fill, "APP",
              const Color.fromARGB(255, 242, 145, 177)),
          containers(context, Icons.wifi_lock_sharp, "Burst", Colors.amber),
          containers(context, Icons.apple_sharp, "Apple", Colors.deepPurple),
        ],
      ),
    );
  }
}

Widget containers(
  BuildContext context,
  IconData icon,
  String title,
  Color clr,
) =>
    InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailPage(heading: title, clr: clr, icon: icon))),
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: clr,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
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
                    size: 40,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ])));

class DetailPage extends StatelessWidget {
  late String heading;
  late Color clr;
  late IconData icon;

  DetailPage({required this.heading, required this.clr, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(heading),
        backgroundColor: clr,
      ),
      body: Container(child: Icon(icon)),
    );
    throw UnimplementedError();
  }
}

// Widget Drawercontainer(
//   BuildContext context,
//   String text,
// ) => GestureDetector(
//   // onTap: () => Navigator.push(context,MaterialPageRoute(builder: DetailPage(clr: Color,))),

// )
