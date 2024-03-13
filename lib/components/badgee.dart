import 'package:flutter/material.dart';

class Badgee extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const Badgee({
    super.key,
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 10,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? Theme.of(context).hintColor,
            ),
            constraints: const BoxConstraints(
              minHeight: 16,
              maxWidth: 16,
            ),
            child: Text(
              textAlign: TextAlign.center,
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
