import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/providers/app_user_provider.dart';
import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/repositories/auth_repository.dart';
import 'package:study_flash/src/features/home/presentation/home_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

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
              autocorrect: false,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Passwort",
              ),
              obscureText: true,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Benutzername",
              ),
              autocorrect: false,
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
                            .read(userRepositoryProvider)
                            .signUpUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text,
                            );
                        await ref.refresh(
                          //! funzt ned
                          currentUserDataProvider.future,
                        );
                        context.go("/");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "email-already-in-use")
                          errorMessage =
                              "Diese E-Mail-Adresse ist bereits registriert.";
                        setState(() {
                          errorMessage = errorMessage;
                        });
                      } catch (e) {
                        setState(() {
                          errorMessage =
                              "Ein unerwarteter Fehler ist aufgetreten: $e";
                        });
                      } finally {
                        isLoading = false;
                      }
                    },
                    child: const Text("Registrieren"),
                  ),

            TextButton(
              onPressed: () {
                // Geht zurück zum Login Screen
                context.pop();
              },
              child: const Text("Zurück zum Login"),
            ),
          ],
        ),
      ),
    );
  }
}
