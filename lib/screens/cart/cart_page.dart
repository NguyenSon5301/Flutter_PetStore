import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:get/get.dart';
import '../order/orderinfo_page.dart';

class NCartPage extends StatefulWidget {
  const NCartPage({Key? key}) : super(key: key);

  @override
  State<NCartPage> createState() => NCartPageState();
}

class CustomTextStyle {
  static const TextStyle titleOfTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle priceOfTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle qtyOfTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
}

class NCartPageState extends State<NCartPage> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('Cart')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          offset: const Offset(
                              1.0, 1.0), // shadow direction: bottom right
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(
                                  snapshot.data.docs[index]["Image"]),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      snapshot.data.docs[index]["Title"],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.titleOfTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Price: \$",
                                          style:
                                              CustomTextStyle.priceOfTextStyle,
                                        ),
                                        Text(
                                          snapshot.data.docs[index]["Price"],
                                          style:
                                              CustomTextStyle.priceOfTextStyle,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Quantity :  ",
                                            style:
                                                CustomTextStyle.qtyOfTextStyle),
                                        Text(
                                            snapshot.data.docs[index]
                                                ["Quantity"],
                                            style:
                                                CustomTextStyle.qtyOfTextStyle)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  barrierColor:
                                                      Colors.transparent,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 221, 219, 219),
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 500,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            SizedBox(
                                                              height: 200,
                                                              width: 300,
                                                              child: Image.network(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      "Image"]),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ["Title"],
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: CustomTextStyle
                                                                  .titleOfTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Price :  \$",
                                                                  style: CustomTextStyle
                                                                      .priceOfTextStyle,
                                                                ),
                                                                Text(
                                                                    snapshot.data
                                                                            .docs[index]
                                                                        [
                                                                        "Price"],
                                                                    style: CustomTextStyle
                                                                        .priceOfTextStyle),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Quantity : ",
                                                                  style: CustomTextStyle
                                                                      .qtyOfTextStyle,
                                                                ),
                                                                CustomNumberPicker(
                                                                  valueTextStyle:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                  customAddButton:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width: 50,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "+",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  customMinusButton:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width: 50,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "-",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  initialValue: int.parse(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      [
                                                                      "Quantity"]),
                                                                  maxValue: 10,
                                                                  minValue: 1,
                                                                  step: 1,
                                                                  onValue:
                                                                      (value) {
                                                                    print(value
                                                                        .toString());
                                                                    setState(
                                                                        () {
                                                                      qty = int.parse(
                                                                          value
                                                                              .toString());
                                                                    });
                                                                    print(qty);
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "User")
                                                                        .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .email)
                                                                        .collection(
                                                                            "Cart")
                                                                        .doc(snapshot
                                                                            .data
                                                                            .docs[index][
                                                                                "Title"]
                                                                            .toString())
                                                                        .update({
                                                                      "Quantity":
                                                                          value
                                                                              .toString()
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                MaterialButton(
                                                                    color: Colors
                                                                        .orange,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    minWidth:
                                                                        100,
                                                                    elevation:
                                                                        10,
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "User")
                                                                          .doc(FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .email)
                                                                          .collection(
                                                                              "Cart")
                                                                          .doc(snapshot
                                                                              .data
                                                                              .docs[index][
                                                                                  "Title"]
                                                                              .toString())
                                                                          .update({
                                                                        "Quantity":
                                                                            qty.toString()
                                                                      }).then((value) =>
                                                                              Navigator.pop(context));
                                                                    },
                                                                    child: const Text(
                                                                        "Save")),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                            )),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("User")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.email
                                                      .toString())
                                                  .collection("Cart")
                                                  .doc(snapshot.data.docs[index]
                                                      ["Title"])
                                                  .delete();
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("Nothing to show here.....");
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('User')
                        .doc(
                            FirebaseAuth.instance.currentUser!.email.toString())
                        .collection('Cart')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        double total = 0;
                        if (snapshot.hasData) {
                          for (var result in snapshot.data!.docs) {
                            total += double.parse(result['Price']) *
                                double.parse(result['Quantity']);
                          }
                          return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.money,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Total amount: \$${total.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ));
                        } else {
                          return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Total amount: \$${total.toString()}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ));
                        }
                      }
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.white),
                    onPressed: () {
                      Get.to(const OrderInfo(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 2));
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
