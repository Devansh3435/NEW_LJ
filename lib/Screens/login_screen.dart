import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_lj/Authentication/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Address TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16.0),

            // Login Button
            ElevatedButton(
              onPressed: () async {
                // Access the input values using the controllers
                String email = emailController.text;
                String password = passwordController.text;

                // Call the authentication method from AuthService
                User? user = await AuthService()
                    .signInWithEmailAndPassword(email, password);

                if (user != null) {
                  // Check if the user is authenticated before navigating
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    // Navigate to the authenticated section of your app
                    Navigator.pushReplacementNamed(context, '/authenticated');
                  } else {
                    // Handle the case where the user is not authenticated (optional)
                    print('User is not authenticated');
                  }
                } else {
                  // Handle unsuccessful login (show error message, etc.)
                  print('Login failed');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
