import 'package:flutter/material.dart';
import 'package:shop/model/order.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'R\$ ${order.total.toStringAsFixed(2)}',
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(order.date),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
