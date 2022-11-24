import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alltitle_product.dart';
import 'detail_page.dart';

class AllProducts extends StatefulWidget {
  final String title;
  const AllProducts({Key? key, required this.title}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ScrollController scrollController = ScrollController();
  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title.isEmpty) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 1000,
              child: GridView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return AllTile(
                      image: snapshot.data.docs[index]['Image'],
                      title: snapshot.data.docs[index]['Title'],
                      price: snapshot.data.docs[index]['Price'],
                      category: snapshot.data.docs[index]['Category'],
                      callback: () {
                        Get.to(
                            DetailPage(
                                title: snapshot.data.docs[index]['Title'],
                                image: snapshot.data.docs[index]['Image'],
                                dec: snapshot.data.docs[index]['Dec'],
                                price: snapshot.data.docs[index]['Price'],
                                category: snapshot.data.docs[index]
                                    ['Category']),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 1));
                      });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 285,
                ),
              ),
            );
          } else {
            return const Center(
                child: Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            ));
          }
        },
      );
    } else {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('Title',
                isGreaterThanOrEqualTo: widget.title,
                isLessThan: '${widget.title}z')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 1000,
              child: GridView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return AllTile(
                      image: snapshot.data.docs[index]['Image'],
                      title: snapshot.data.docs[index]['Title'],
                      price: snapshot.data.docs[index]['Price'],
                      category: snapshot.data.docs[index]['Category'],
                      callback: () {
                        Get.to(
                            DetailPage(
                                title: snapshot.data.docs[index]['Title'],
                                image: snapshot.data.docs[index]['Image'],
                                dec: snapshot.data.docs[index]['Dec'],
                                price: snapshot.data.docs[index]['Price'],
                                category: snapshot.data.docs[index]
                                    ['Category']),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 1));
                      });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 285,
                ),
              ),
            );
          } else {
            return const Center(
                child: Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            ));
          }
        },
      );
    }
  }
}
