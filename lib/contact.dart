import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                autocorrect: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Your name:",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                autocorrect: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Your email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                autocorrect: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.message),
                    labelText: "Messsage",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid))),
              ),
            ),
            // TextButton(onPressed: , child: Text("Submit"))
            Divider(),

            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  child: Column(
                children: [
                  contactinfocontainer("05540261758", Icons.phone),
                  contactinfocontainer(
                      "varislifurkansahin@gmail.com", Icons.mail),
                  contactinfocontainer("Konya", Icons.home),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

Widget contactinfocontainer(
  String text,
  IconData icon,
) =>
    Container(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: 10), child: Icon(icon)),
          Text(text),
        ]),
      ),
    ]));
