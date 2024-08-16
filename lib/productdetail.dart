import 'package:flutter/material.dart';

class Productdetail extends StatefulWidget {
  const Productdetail({super.key});

  @override
  State<Productdetail> createState() => _productdenemeState();
}

class _productdenemeState extends State<Productdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Icon(
              Icons.ac_unit_rounded,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: containerproduct(),
        // child: GridView.count(
        //   crossAxisCount: 4,
        //   children: [
        //     containerproduct(),
        //   ],
        // ),
      ),
    );
  }
}

Widget containerproduct() {
  return Container(
    //color: Colors.red,
    child: Column(
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.circular(48),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48), topRight: Radius.circular(48)),
          child: Image.asset(
            'images/blog.jpg',
            fit: BoxFit.cover,
            width: 400,
            height: 350,
          ),
        ),
        Text('Hello'),
        Text(
          'Selam',
          style: TextStyle(color: Colors.red),
        ),
        Text('Naber'),
      ],
    ),
  );
}
