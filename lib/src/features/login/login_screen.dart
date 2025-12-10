import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

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

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        errorMessage = null;
                        isLoading = true;
                      });
                      try {
                        await ref
                            .read(authRepositoryProvider)
                            .signInWithEmail(
                              email: _emailController.text.trim(),
                              password: _passwordController.text
                                  .trim(),
                            );
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            errorMessage = "Fehler: $e";
                            isLoading = false;
                          });
                        }
                      }
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
