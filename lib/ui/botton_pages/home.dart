import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_detail_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List producets = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("Carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["path"],
        );
        print(qn.docs[i]["path"]);
      }
    });

    return qn.docs;
  }
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("producets").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        producets.add({
          "product_name": qn.docs[i]["product_name"],
          "prouct-driscription": qn.docs[i]["prouct-driscription"],
          "product-price": qn.docs[i]["Product_price"],
          "product_img": qn.docs[i]["product_img"],
        });
      }
    });

    return qn.docs;
  }
  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(fillColor: Colors.white,
                      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.grey)),
                          hintText: "Search products here",
                          hintStyle: TextStyle(fontSize: 15.sp),
                    ),
                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => SearchScreen())),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                  width: 5.sp,
                ),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: CarouselSlider(
                      items: _carouselImages.map((item) => Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)
                          ),
                        ),
                      )
                      ).toList(),
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {
                              _dotPosition = val;
                            });
                          }
                          ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                DotsIndicator(
                  dotsCount:
                  _carouselImages.isEmpty ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.deepOrange,
                    color: Colors.deepOrange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: producets.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          //onTap: ()=> print(producets[index]),
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>productdetails(producets[index]))),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AspectRatio(
                                    aspectRatio: 2,
                                    child: Container(
                                        color: Colors.deepPurpleAccent,
                                        child: Image.network(producets[index]["product_img"], fit: BoxFit.cover,
                                        ),
                                    ),
                                ),
                                Text("${producets[index]["product_name"]}"),
                                Text(producets[index]["product-price"].toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              //  ElevatedButton(onPressed: ()=>print(producets), child: Text("print producets")),
              ],
            ),

          ),
      ),
    );
  }
}

