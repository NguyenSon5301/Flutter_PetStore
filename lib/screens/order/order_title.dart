import 'package:flutter/material.dart';

class OrderTile extends StatefulWidget {
  final List orders;

  const OrderTile({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.orders[index]['Category']),
                      Text('x${widget.orders[index]['Quantity']}'),
                    ],
                  ),
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.orders[index]['Image'])),
                  trailing: Text(
                    '\$${widget.orders[index]['Price']}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ]);
            }),
      ],
    );
  }
}
