import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/screens/customer/customer_infor.dart';
import 'package:test_app/screens/product/cat_product.dart';
import 'package:test_app/screens/product/dog_product.dart';

import '../order/order.dart';
import '../services/auth.dart';
import '../product/all_product.dart';
import '../cart/cart_page.dart';
import '../saved/saved.dart';

class NhomePage extends StatefulWidget {
  const NhomePage({super.key});
  @override
  State<NhomePage> createState() => _NhomePageState();
}

class _NhomePageState extends State<NhomePage> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "";
  final searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Center(child: Text("Shopping App")),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text(
                'AH',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              Container(
                padding: const EdgeInsets.all(15),
                child: Wrap(
                  runSpacing: 0,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Home",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.favorite_border,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Favourites",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(const Saved(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(seconds: 1));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Cart",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(const NCartPage(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(seconds: 1));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Orders",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(const OrderPage(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(seconds: 1));
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_outline_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Profile",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(const CustomInfo(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(seconds: 1));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                      onTap: () async {
                        final AuthService auth = new AuthService();
                        await auth.signOut();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1)),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              hintText: "Search Products"),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            title = searchController.text.toString();
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 250,
              // color: Colors.amber,
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://res.cloudinary.com/dekklgarv/image/upload/v1668766519/Group%205/banner2_p2sxvh.jpg"))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://res.cloudinary.com/dekklgarv/image/upload/v1668766519/Group%205/banner1_xmvoxd.png"))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://res.cloudinary.com/dekklgarv/image/upload/v1668766519/Group%205/banner3_tcwe88.jpg"))),
                  ),
                ],
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ),
            TabBar(isScrollable: true, controller: tabController, tabs: const [
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Dog",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Cat",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
            const SizedBox(
              height: 1,
            ),
            SizedBox(
              height: 1000,
              child: TabBarView(controller: tabController, children: <Widget>[
                AllProducts(
                  title: title,
                ),
                DogProducts(
                  title: title,
                ),
                CatProducts(
                  title: title,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundColor: Colors.orangeAccent,
            child: Text(
              'AH',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
