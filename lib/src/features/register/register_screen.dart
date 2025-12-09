import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/services/auth_service.dart';
import 'package:study_flash/src/features/home/presentation/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _firebaseAuth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;

  // Future<void> _register() async {
  //   try {
  //     await AuthService().createAccount(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     // Nach erfolgreicher Registrierung schließen wir diesen Screen,
  //     // damit der User (nun eingeloggt) im Main-Flow landet.
  //     if (mounted) Navigator.of(context).pop();
  //   } catch (e) {
  //     setState(() => errorMessage = e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrieren")),
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
                _firebaseAuth.createAccount(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                context.push("/");
              },
              child: const Text("Registrieren"),
            ),

            TextButton(
              onPressed: () {
                // Geht zurück zum Login Screen
                context.push("/login");
              },
              child: const Text("Zurück zum Login"),
            ),
          ],
        ),
      ),
    );
  }
}
