import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wait for 3 seconds before navigating
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });

    return Scaffold(// Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ใช้ Image.asset สำหรับการแสดงรูป
            Image.asset(
              'assets/splash.png',
              fit: BoxFit.cover,  // ทำให้ภาพเต็มพื้นที่
              height: MediaQuery.of(context).size.height,  // ใช้ขนาดความสูงของหน้าจอ
              width:MediaQuery.of(context).size.width,    // ใช้ขนาดความกว้างของหน้าจอ
            ),

          ],
        ),
      ),
    );
  }
}
