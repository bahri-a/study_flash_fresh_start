import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/providers/app_user_provider.dart';
import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/repositories/auth_repository.dart';
import 'package:study_flash/src/core/models/app_user/app_user.dart';
import 'package:study_flash/src/features/home/presentation/home_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
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
              decoration: const InputDecoration(labelText: "Passwort"),
              obscureText: true,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Benutzername"),
              autocorrect: false,
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: Colors.red)),

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
                        // Warte bis der Username geladen ist (für den Homescreen)
                        AppUser? user = await ref.read(userRepositoryProvider).getCurrentAppUserData();
                        do {
                          user = await ref.read(userRepositoryProvider).getCurrentAppUserData();
                          await Future.delayed(Duration(milliseconds: 100));
                        } while (user == null);

                        if (user != null && context.mounted) {
                          context.go("/");
                        } else if (context.mounted) {
                          setState(() {
                            errorMessage = "Zeitüberschreitung: Profil konnte nicht geladen werden.";
                            isLoading = false;
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          setState(() {
                            if (e.code == "email-already-in-use") {
                              errorMessage = "Diese E-Mail-Adresse ist bereits registriert.";
                            } else if (e.code == "invalid-email") {
                              errorMessage = "Die E-Mail-Adresse ist ungültig.";
                            } else if (e.code == "weak-password") {
                              errorMessage = "Ungültiges Passwort";
                            }
                            isLoading = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          errorMessage = "Ein unerwarteter Fehler ist aufgetreten: $e";
                        });
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
