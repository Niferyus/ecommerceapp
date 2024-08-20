// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:blogcom/models/productmodel.dart';
import 'package:blogcom/productdetail.dart';
import 'package:blogcom/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductService service = ProductService();
  List<Product> products = [];
  bool isLoaded = false;

  @override
  initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    Productmodel? model = await service.fetchProducts();
    setState(() {
      if (model != null) {
        print("modelll nulll değilll");
        products = model.products;
        isLoaded = true;
      } else {
        print("modell null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products"),
      ),
      body: isLoaded
          ? GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return productContainer(context, product);
              })
          : Center(child: CircularProgressIndicator()),
    );
  }

  Container productContainerr(Product product) {
    return Container(
      width: 600,
      // height: 600,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.red),
          color: Colors.amber),
      // color: Colors.amber,
      child: Column(
        children: [
          Text(product.title),
          Text(product.category),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.red),
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text("Price: " + product.price.toString() + " \$"),
                ),
                Text("Stok: " + product.stock.toString()),
              ],
            ),
          ),
          Container(
              color: Colors.white,
              width: double.infinity,
              child: Text(product.sku),
              alignment: Alignment.center),
        ],
      ),
    );
  }
}

Widget productContainer(BuildContext context, Product product) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Productdetail(product.id),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Color.fromARGB(153, 247, 205, 205)),
          boxShadow: const [
            BoxShadow(offset: Offset.infinite, color: Colors.black45)
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            Text(product.title),
            Text(product.category),
            Text(product.price.toString())
          ],
        ),
      ),
    ),
  );
}
