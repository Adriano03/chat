// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // A função onSubmit passará os dados para o authPage via parâmetro;
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    //Verifica se o form está válido;
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    //Garantir que a imagem não seja nula apenas no modo cadastro;
    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada.');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSignup)
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  //Não perde o texto caso saia da tela e volte.(Necessário onChanged);
                  initialValue: _formData.name,
                  //Nos parentes pega os dados e passa para a model,
                  onChanged: (name) => _formData.name = name,
                  //Uma boa pratica para identificar cada campo;
                  key: const ValueKey('name'),
                  textInputAction: TextInputAction.next,
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    label: Text('Nome'),
                  ),
                ),
              TextFormField(
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                key: const ValueKey('email'),
                textInputAction: TextInputAction.next,
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@') ||
                      email.trim().length < 5 ||
                      !email.contains('.')) {
                    return 'E-mail informado não é válido.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  label: Text('E-mail'),
                ),
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                key: const ValueKey('password'),
                obscureText: true,
                onFieldSubmitted: (_) => _submit(),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  label: Text('Senha'),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _formData.isLogin
                          ? 'Criar uma nova conta?'
                          : 'Já possui conta?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
