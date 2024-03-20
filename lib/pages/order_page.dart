import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/model/provider/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orderList.itemsCounts,
        itemBuilder: (ctx, i) {
          return OrderWidget(
            order: orderList.items[i],
          );
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
