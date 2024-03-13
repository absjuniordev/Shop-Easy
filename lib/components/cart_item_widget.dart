import 'package:flutter/material.dart';
import 'package:shop/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.nome);
  }
}
