import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/model/provider/order_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // bool _isLoading = true;

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<OrderList>(
  //     context,
  //     listen: false,
  //   ).loadOrders().then((_) {
  //     setState(() => _isLoading = false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
        centerTitle: true,
      ),
      // body: _isLoading
      //     ? const Center(child: CircularProgressIndicator())
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemCount: orderList.itemsCounts,
          itemBuilder: (ctx, i) {
            return OrderWidget(
              order: orderList.items[i],
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
