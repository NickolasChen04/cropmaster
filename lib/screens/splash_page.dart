import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.eco,
                        size: 60,
                        color: const Color(0xFF4ADE80).withOpacity(0.8),
                      ),
                      const Icon(
                        Icons.analytics,
                        size: 30,
                        color: Color(0xFF4ADE80),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: deviceSize.height * 0.03),
              
              // App Name
              const Text(
                'CropMaster',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              
              SizedBox(height: deviceSize.height * 0.02),
              
              // Tagline
              const Text(
                'Smart Farming Solutions',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF718096),
                ),
              ),
              
              SizedBox(height: deviceSize.height * 0.08),
              
              // Tap to continue text
              const Text(
                'Tap anywhere to continue',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA0AEC0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 