import 'package:banking_app/Modules/Home%20Screen/home_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            const SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage('./assets/images/welcome.jpg'),
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Container(
              height: 40.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 13, 71),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => const HomePage()), 
                    (route) => false,
                  );
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
