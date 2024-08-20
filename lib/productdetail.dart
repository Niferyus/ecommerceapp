// ignore_for_file: prefer_const_constructors
import 'package:blogcom/models/productdetailmodel.dart';
import 'package:blogcom/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Productdetail extends StatefulWidget {
  final int id;

  Productdetail(this.id, {super.key});

  @override
  State<Productdetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<Productdetail> {
  ProductDetailModel? model;
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    loadProductDetail();
  }

  Future<void> loadProductDetail() async {
    ProductService service = new ProductService();
    ProductDetailModel? tempmodel = await service.fetchSingleProduct(widget.id);
    setState(() {
      if (tempmodel != null) {
        model = tempmodel;
      }
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            if (model != null)
              Text(model!.brand.toString())
            else
              Text("Loading..."),
          ],
        ),
      ),
      body: isLoad
          ? Center(child: CircularProgressIndicator())
          : model != null
              ? Container(
                  child: Column(
                    children: [
                      Image.network(
                        model!.images[0],
                        width: 400,
                        height: 400,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text(
                            model!.brand,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(model!.title, textAlign: TextAlign.start),
                        ],
                      ),
                      Text(model!.description),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(model!.rating.toString()),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.storage_rounded),
                                Text(model!.stock.toString()),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.green,
                                ),
                                Text(model!.price.toString())
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          spacing: 6.0,
                          children: List.generate(
                            model!.tags.length,
                            (index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: const [
                                      Colors.blue,
                                      Colors.cyan,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  model!.tags[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model!.reviews.length,
                          itemBuilder: (context, index) =>
                              reviewContainer(model!.reviews[index]),
                        ),
                      )
                    ],
                  ),
                )
              : Center(child: Text("Error loading product details")),
    );
  }
}

Widget reviewContainer(Review review) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.indigoAccent),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lime),
                child: Text(review.reviewerName),
              ),
              Text(review.comment),
            ],
          ),
        )
      ],
    ),
  );
}
