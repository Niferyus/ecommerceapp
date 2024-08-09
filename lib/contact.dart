import 'package:flutter/material.dart';

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
            TextFormField(
              autocorrect: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "İsminiz",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid))),
            ),
            TextFormField(
              autocorrect: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Mailiniz",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid))),
            ),
            TextFormField(
              autocorrect: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.message),
                  labelText: "Mesajınız",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid))),
            )
            // TextButton(onPressed: , child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
