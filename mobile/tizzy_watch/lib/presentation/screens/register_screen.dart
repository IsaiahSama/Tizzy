import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/core/auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Tizzy',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text('Register to get Tizzied', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthService.registerUser("boy");
                      if (context.mounted) {
                        context.go('/');
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text("I'm the Boy!", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthService.registerUser("girl");
                      if (context.mounted) {
                        context.go('/');
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: Text("I'm the Girl!", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
