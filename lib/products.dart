// ignore_for_file: prefer_const_constructors
import 'package:blogcom/models/productmodel.dart';
import 'package:blogcom/productdetail.dart';
import 'package:blogcom/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Color.fromARGB(153, 203, 21, 21),
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

  Widget productContainer(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productdetail(product.id),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(5, 5),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  product.thumbnail,
                  height: 160,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  product.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  product.category,
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.price} \$",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      "Stok: ${product.stock}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
