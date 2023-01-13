// ignore_for_file: control_flow_in_finally

import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        // Tratar Login
        await AuthService().login(formData.email, formData.password);
      } else {
        // Tratar Registrar
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (e) {
      // tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(226, 8, 23, 110),
              Color.fromARGB(227, 9, 80, 138),
              Color.fromARGB(125, 10, 143, 196),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width * 0.44,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/chat.png'),
                        ),
                      ),
                    ),
                    AuthForm(onSubmit: _handleSubmit),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
