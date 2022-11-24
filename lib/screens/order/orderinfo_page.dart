import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'order.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({Key? key}) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  double total = 0;
  Random random = new Random();
  final formkey = GlobalKey<FormState>();
  String _value = 'Cash On Delivey';
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int randomNumber = random.nextInt(1000000);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.email.toString())
            .collection('CusInfo')
            // .doc(FirebaseAuth.instance.currentUser!.email.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.size != 0) {
            wardController = TextEditingController(
              text: snapshot.data!.docs[0]['Ward'].toString(),
            );
            nameController = TextEditingController(
              text: snapshot.data!.docs[0]['Name'].toString(),
            );
            cityController = TextEditingController(
              text: snapshot.data!.docs[0]['City'].toString(),
            );
            addressController = TextEditingController(
              text: snapshot.data!.docs[0]['Address'].toString(),
            );
            emailController = TextEditingController(
              text: snapshot.data!.docs[0]['Email'].toString(),
            );
            phoneController = TextEditingController(
              text: snapshot.data!.docs[0]['Phone'].toString(),
            );
            return Scaffold(
              // backgroundColor: Color.fromARGB(255, 43, 55, 65),
              appBar: AppBar(
                foregroundColor: Colors.black,
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: const Text(
                  'Enter Information',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: MaterialButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      final user = FirebaseAuth.instance.currentUser!;
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection('User')
                          .doc(user.email.toString())
                          .collection('Cart')
                          .get();

                      for (var result in querySnapshot.docs) {
                        total += double.parse(result['Price']) *
                            double.parse(result['Quantity']);
                      }
                      final allData =
                          querySnapshot.docs.map((doc) => doc.data()).toList();
                      final String format =
                          DateFormat('y-MM-d').format(DateTime.now());
                      Map<String, dynamic> orders = {
                        'Orders': allData,
                        'User': user.email.toString(),
                        'Name': nameController.text,
                        'City': cityController.text,
                        'Ward': wardController.text,
                        'Address': addressController.text,
                        'Email': emailController.text,
                        'Phone': phoneController.text,
                        'Payment': _value,
                        'Total': total,
                        'OrderNumber': randomNumber,
                        'Date': format,
                        'Status': 'Pending'
                      };
                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(user.email)
                          .collection('Orders')
                          .doc(randomNumber.toString())
                          .set(orders);

                      FirebaseFirestore.instance
                          .collection('AllOrders')
                          .doc(randomNumber.toString())
                          .set(orders);

                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(user.email)
                          .collection('Cart')
                          .get()
                          .then((value) {
                        for (DocumentSnapshot ds in value.docs) {
                          ds.reference.delete();
                        }
                      });
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const OrderPage()));
                    }
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 3),
                  ),
                ),
              ),

              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue: snapshot.data.docs[0]['Name'],
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Full Name',
                                  label: const Text(
                                    'Name',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: addressController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.house,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Address House',
                                  label: const Text(
                                    'Address Name',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: wardController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.landscape,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter ward near you',
                                  label: const Text(
                                    'Ward',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cityController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.location_city,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your City',
                                  label: const Text(
                                    'City',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue:
                              //     FirebaseAuth.instance.currentUser!.email.toString(),
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return "Enter correct email";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Email',
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct phone";
                                }
                                return null;
                              },
                              controller: phoneController,
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Phone Number',
                                  label: const Text(
                                    'Phone Number',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Gender',
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'roboto'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Cash On Delivery',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Cash On Delivery')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Walets',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Walets')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Card',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Card')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              // backgroundColor: Color.fromARGB(255, 43, 55, 65),
              appBar: AppBar(
                foregroundColor: Colors.black,
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: const Text(
                  'Enter Information',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: MaterialButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      final user = FirebaseAuth.instance.currentUser!;
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection('User')
                          .doc(user.email.toString())
                          .collection('Cart')
                          .get();

                      for (var result in querySnapshot.docs) {
                        total += double.parse(result['Price']) *
                            double.parse(result['Quantity']);
                      }
                      final allData =
                          querySnapshot.docs.map((doc) => doc.data()).toList();
                      final String format =
                          DateFormat('y-MM-d').format(DateTime.now());
                      Map<String, dynamic> orders = {
                        'Orders': allData,
                        'User': user.email.toString(),
                        'Name': nameController.text,
                        'City': cityController.text,
                        'Ward': wardController.text,
                        'Address': addressController.text,
                        'Email': emailController.text,
                        'Phone': phoneController.text,
                        'Payment': _value,
                        'Total': total,
                        'OrderNumber': randomNumber,
                        'Date': format,
                        'Status': 'Pending'
                      };
                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(user.email)
                          .collection('Orders')
                          .doc(randomNumber.toString())
                          .set(orders);

                      FirebaseFirestore.instance
                          .collection('AllOrders')
                          .doc(randomNumber.toString())
                          .set(orders);

                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(user.email)
                          .collection('Cart')
                          .get()
                          .then((value) {
                        for (DocumentSnapshot ds in value.docs) {
                          ds.reference.delete();
                        }
                      });
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const OrderPage()));
                    }
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 3),
                  ),
                ),
              ),

              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue: snapshot.data.docs[0]['Name'],
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Full Name',
                                  label: const Text(
                                    'Name',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: addressController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.house,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Address House',
                                  label: const Text(
                                    'Address Name',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: wardController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.landscape,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter ward near you',
                                  label: const Text(
                                    'Ward',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cityController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct value";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.location_city,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your City',
                                  label: const Text(
                                    'City',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue:
                              //     FirebaseAuth.instance.currentUser!.email.toString(),
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return "Enter correct email";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Email',
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct phone";
                                }
                                return null;
                              },
                              controller: phoneController,
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.orange,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter Your Phone Number',
                                  label: const Text(
                                    'Phone Number',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Gender',
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'roboto'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Cash On Delivery',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Cash On Delivery')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Walets',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Walets')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 'Card',
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as String;
                                          });
                                        }),
                                    const Text('Card')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
