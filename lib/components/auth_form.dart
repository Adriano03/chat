import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              if (_formData.isSignup)
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  key: const ValueKey('name'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
              TextFormField(
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                key: const ValueKey('password'),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                child: Text(_formData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui conta?'),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
