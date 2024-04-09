import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shop/pages/auth_or_home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Animate(
          onComplete: (_) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                duration: const Duration(seconds: 2),
                child: const AuthOrHomePage(),
                type: PageTransitionType.fade,
              ),
            );
          },
          effects: const [
            FadeEffect(
              delay: Duration(seconds: 1),
              duration: Duration(seconds: 4),
            )
          ],
          child: const Text(
            "ShopEase",
            style: TextStyle(
              fontSize: 41,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
