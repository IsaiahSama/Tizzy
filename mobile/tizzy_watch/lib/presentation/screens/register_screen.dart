import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/core/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String companionID = '';
  bool isProcessing = false;

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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Know your partner's ID?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Companion ID',
                            ),
                            onChanged: (text) {
                              setState(() {
                                companionID = text;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed:
                          isProcessing
                              ? null
                              : () async {
                                setState(() {
                                  isProcessing = true;
                                });
                                await _registerUser("boy", context);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "I'm the Boy!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed:
                          isProcessing
                              ? null
                              : () async {
                                setState(() {
                                  isProcessing = true;
                                });
                                await _registerUser("girl", context);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: Text(
                        "I'm the Girl!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser(String gender, BuildContext context) async {
    try {
      await AuthService.registerUser(gender, context);
      if (companionID.isNotEmpty) {
        await AuthService.setCompanion(companionID, context);
      }
      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }
  }
}
