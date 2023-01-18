// ignore_for_file: control_flow_in_finally

import 'package:chat/exceptions/auth_exceptions.dart';
import 'package:flutter/material.dart';

import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;
  final _authException = AuthException();

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Ocorreu um erro!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        content: Text(msg, textAlign: TextAlign.center),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

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
    } catch (error) {
      if (error.toString() == _authException.emailExists) {
        _showErrorDialog('E-mail já cadastrado!');
      } else if (error.toString() == _authException.emailNotFound) {
        _showErrorDialog('E-mail não encontrado!');
      } else if (error.toString() == _authException.invalidPassword) {
        _showErrorDialog('Senha informada incorreta!');
      } else if (error.toString() == _authException.blockedAccess) {
        _showErrorDialog(
            'Acesso bloqueado temporariamente. Tente novamente mais tarde!');
      } else if (error.toString() == _authException.disableAccount) {
        _showErrorDialog(
            'A conta do usuário foi desativada por um administrador!');
      } else if (error.toString() == _authException.unformattedEmail) {
        _showErrorDialog('O endereço de e-mail está com formato incorreto!');
      } else if (error.toString() == _authException.networkFailed) {
        _showErrorDialog(
            'Ocorreu um erro na rede. Verifique se sua internet está ativa!');
      } else {
        _showErrorDialog('Ocorreu um erro no processo de autenticação');
      }
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
