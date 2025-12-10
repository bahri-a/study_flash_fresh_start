import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/services/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _firebaseAuth = AuthRepository(
    FirebaseAuth.instance,
  );

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anmelden")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-Mail"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Passwort",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),

            ElevatedButton(
              onPressed: () {
                _firebaseAuth.signInWithEmail(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                context.push("/");
              },
              child: const Text("Einloggen"),
            ),

            TextButton(
              onPressed: () {
                // Navigation zum Registrieren-Screen
                context.push("/register");
              },
              child: const Text("Noch kein Konto?\nRegistrieren"),
            ),
          ],
        ),
      ),
    );
  }
}
