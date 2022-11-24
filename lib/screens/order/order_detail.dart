import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final String name;
  final int orderNumber;
  final String status;
  final String date;
  final String city;
  final String phone;
  final String email;
  final String payment;
  final int total;
  final String ward;
  final String address;
  final List orders;

  const OrderDetail(
      {Key? key,
      required this.name,
      required this.orderNumber,
      required this.date,
      required this.city,
      required this.phone,
      required this.email,
      required this.payment,
      required this.total,
      required this.status,
      required this.orders,
      required this.ward,
      required this.address})
      : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            elevation: 2,
            centerTitle: true,
            title: Text(
              'Order ${widget.orderNumber.toString()}',
              style: const TextStyle(color: Colors.white, fontFamily: 'roboto'),
            )),
        backgroundColor: Colors.orangeAccent,
        body: SingleChildScrollView(
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.local_shipping,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Order Information',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 27,
                            ),
                            const Text(
                              'Date : ',
                            ),
                            Text(widget.date)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 27,
                            ),
                            const Text(
                              'Status: ',
                            ),
                            Text(
                              widget.status,
                              style: TextStyle(
                                  color: widget.status == 'Rejected By Admin'
                                      ? Colors.red
                                      : Colors.green),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 20,
                          color: Colors.brown,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.house,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Address Information',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 27,
                            ),
                            const Text(
                              'Customer Name: ',
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 27,
                                ),
                                const Text(
                                  'Address: ',
                                ),
                                Text(
                                  widget.address,
                                  style: const TextStyle(color: Colors.orange),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(',',
                                    style: TextStyle(color: Colors.orange)),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 27,
                                ),
                                Text(
                                  widget.ward,
                                  style: const TextStyle(color: Colors.orange),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(',',
                                    style: TextStyle(color: Colors.orange)),
                                Text(
                                  widget.city,
                                  style: const TextStyle(color: Colors.orange),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 27,
                            ),
                            const Text(
                              'Email: ',
                            ),
                            Text(
                              widget.email,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 27,
                            ),
                            const Text(
                              'Phone: ',
                            ),
                            const Text('(+84)',
                                style: TextStyle(color: Colors.orange)),
                            Text(
                              widget.phone,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 1,
                          height: 20,
                          color: Colors.brown,
                        ),
                        Card(
                            child: Column(
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: widget.orders.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(children: [
                                    const SizedBox(height: 10),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.brown,
                                    ),
                                    ListTile(
                                      title: SizedBox(
                                        width: 250,
                                        child: Text(
                                          widget.orders[index]['Title'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              widget.orders[index]['Category']),
                                          Text(
                                              'x${widget.orders[index]['Quantity']}'),
                                        ],
                                      ),
                                      leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              widget.orders[index]['Image'])),
                                      trailing: Text(
                                        '\$${widget.orders[index]['Price']}',
                                        style: const TextStyle(
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  ]);
                                }),
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
                                      '\$${widget.total.toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                    const SizedBox(
                                      width: 17,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.payment,
                                      color: Colors.greenAccent,
                                    ),
                                    const Text(
                                      'Payment:  ',
                                    ),
                                    Text(
                                      widget.payment.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 17,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ))),
        ));
  }
}
