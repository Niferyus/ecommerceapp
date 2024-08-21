// ignore_for_file: prefer_const_constructors
import 'package:blogcom/models/productdetailmodel.dart';
import 'package:blogcom/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Productdetail extends StatefulWidget {
  final int id;

  Productdetail(this.id, {super.key});

  @override
  State<Productdetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<Productdetail> {
  ProductDetailModel? model;
  bool isLoad = true;
  CarouselController _controller = new CarouselController();
  int currentindex = 0;

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
      ),
      body: isLoad
          ? Center(child: CircularProgressIndicator())
          : model != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          model!.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20),
                        ),
                        Column(children: [
                          CarouselSlider.builder(
                            itemCount: model!.images.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                model!.images[index],
                                fit: BoxFit.cover,
                              );
                            },
                            carouselController: _controller,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) => setState(() {
                                currentindex = index;
                              }),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                model!.images.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(currentindex == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]),
                        Divider(),
                        Text(model!.description),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 28,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      model!.rating.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_basket,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      model!.stock.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      model!.price.toString(),
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            spacing: 6.0,
                            children: List.generate(
                              model!.tags.length,
                              (index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 20),
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
                        Divider(),
                        Column(
                          children: [
                            ...List.generate(
                              model!.reviews.length,
                              (index) {
                                return reviewContainer(model!.reviews[index]);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Center(child: Text("Error loading product details")),
    );
  }
}

Widget reviewContainer(Review review) {
  String name = review.reviewerName.split(" ")[0];
  String surname = review.reviewerName.split(" ")[1];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.indigoAccent),
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.lime,
          child: Text(
            name[0] + surname[0],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.reviewerName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  // SizedBox(
                  //   width: 100,
                  // ),
                  Text(review.date.toString().split(" ")[0])
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                review.comment,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Divider(),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      color: i < review.rating ? Colors.amber : Colors.grey,
                    )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
