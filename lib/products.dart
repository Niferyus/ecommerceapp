// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products"),
      ),
      // body: ListView.builder(itemCount: ,itemBuilder: itemBuilder),
    );
  }
}
