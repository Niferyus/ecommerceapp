import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Image.asset('images/blog.jpg'),
            const Text(
              "Hakkımızda",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Hoş geldiniz! Bu blog uygulaması, düşüncelerinizi, fikirlerinizi ve ilgi alanlarınızı paylaşabileceğiniz bir platform sunmak amacıyla tasarlanmıştır. Amacımız, her yaştan ve her kesimden insanın, kendi sesini duyurabileceği, bilgi ve deneyimlerini paylaşabileceği bir ortam sağlamaktır.",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
            )
          ],
        ));
  }
}
