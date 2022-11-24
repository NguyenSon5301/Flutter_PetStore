import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomInfo extends StatefulWidget {
  const CustomInfo({Key? key}) : super(key: key);

  @override
  State<CustomInfo> createState() => _CustomInfoState();
}

class _CustomInfoState extends State<CustomInfo> {
  double total = 0;
  Random random = new Random();
  final formkey = GlobalKey<FormState>();
  String _value = 'Boy';
  DateTime selectedDate = DateTime.now();
  bool checkday = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(
        text: FirebaseAuth.instance.currentUser!.email.toString());
  }

  @override
  Widget build(BuildContext context) {
    // int randomNumber = random.nextInt(1000000);
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
          if (checkday == false) {
            checkday = true;
            birthdayController = TextEditingController(
              text: snapshot.data!.docs[0]['BirthDay'].toString(),
            );
          }
          return Scaffold(
            // backgroundColor: Color.fromARGB(255, 43, 55, 65),
            appBar: AppBar(
              foregroundColor: Colors.black,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Enter Information',
                style: TextStyle(color: Colors.black, fontFamily: 'roboto'),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: MaterialButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    final user = FirebaseAuth.instance.currentUser!;
                    Map<String, dynamic> info = {
                      'Name': nameController.text,
                      'City': cityController.text,
                      'Ward': wardController.text,
                      'Address': addressController.text,
                      'Email': emailController.text,
                      'Phone': phoneController.text,
                      'Gender': _value,
                      'BirthDay': birthdayController.text,
                      'User': user.email.toString(),
                    };
                    FirebaseFirestore.instance
                        .collection('User')
                        .doc(user.email)
                        .collection('CusInfo')
                        .doc(user.email.toString())
                        .update(info);
                  }
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => const CustomInfo()));
                },
                child: const Text(
                  'Save Information',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
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
                            controller: birthdayController,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Select correct value";
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  birthdayController.text = DateFormat('y-MM-d')
                                      .format(
                                          pickedDate); //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
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
                                hintText: 'Select Your BirthDay',
                                label: const Text(
                                  'BirthDay',
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
                            readOnly: true,
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
                          style: TextStyle(fontSize: 20, fontFamily: 'roboto'),
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
                                      value: 'Boy',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Boy')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'Girl',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Girl')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'Other',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Other')
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
                style: TextStyle(color: Colors.black, fontFamily: 'roboto'),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: MaterialButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    final user = FirebaseAuth.instance.currentUser!;
                    Map<String, dynamic> info = {
                      'Name': nameController.text,
                      'City': cityController.text,
                      'Ward': wardController.text,
                      'Address': addressController.text,
                      'Email': emailController.text,
                      'Phone': phoneController.text,
                      'Gender': _value,
                      'BirthDay': birthdayController.text,
                      'User': user.email.toString(),
                    };
                    FirebaseFirestore.instance
                        .collection('User')
                        .doc(user.email)
                        .collection('CusInfo')
                        .doc(user.email.toString())
                        .set(info)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content:
                                    Text('Update information successly!!!'))));
                  }
                },
                child: const Text(
                  'Save Information',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
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
                            controller: birthdayController,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Select correct value";
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  birthdayController.text = DateFormat('y-MM-d')
                                      .format(
                                          pickedDate); //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
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
                                hintText: 'Select Your BirthDay',
                                label: const Text(
                                  'BirthDay',
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
                            readOnly: true,
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
                          style: TextStyle(fontSize: 20, fontFamily: 'roboto'),
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
                                      value: 'Boy',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Boy')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'Girl',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Girl')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'Other',
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as String;
                                        });
                                      }),
                                  const Text('Other')
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
      },
    );
  }
}
