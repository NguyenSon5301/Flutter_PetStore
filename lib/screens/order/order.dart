import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screens/order/order_detail.dart';

import '../../models/order.dart';
import 'order_title.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> orders = [];
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Your Orders',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.email.toString())
            .collection('Orders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDetail(
                                  orderNumber: snapshot.data.docs[index]
                                      ['OrderNumber'],
                                  name: snapshot.data.docs[index]['Name'],
                                  email: snapshot.data.docs[index]['Email'],
                                  city: snapshot.data.docs[index]['City'],
                                  phone: snapshot.data.docs[index]['Phone'],
                                  date: snapshot.data.docs[index]['Date'],
                                  payment: snapshot.data.docs[index]['Payment'],
                                  total: snapshot.data.docs[index]['Total'],
                                  status: snapshot.data.docs[index]['Status'],
                                  orders: snapshot.data.docs[index]['Orders'],
                                  address: snapshot.data.docs[index]['Address'],
                                  ward: snapshot.data.docs[index]['Ward'],
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text('Order Number:'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  snapshot.data.docs[index]['OrderNumber']
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Date: ${snapshot.data.docs[index]['Date']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Status: ${snapshot.data.docs[index]['Status'].toString()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: snapshot.data.docs[index]
                                                  ['Status'] ==
                                              'Rejected By Admin'
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              ],
                            ),
                            dense: false,
                          ),
                          OrderTile(
                              orders: snapshot.data.docs[index]['Orders']),
                          const Divider(
                            thickness: 2,
                            height: 10,
                            color: Colors.brown,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.money_rounded,
                                    color: Colors.greenAccent,
                                  ),
                                  const Text(
                                    'Total amount:  ',
                                  ),
                                  Text(
                                    '\$${snapshot.data.docs[index]['Total']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ));
              },
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
