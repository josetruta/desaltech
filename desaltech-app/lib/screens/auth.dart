import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = false;
  var _isAuthenticating = false;
  var _enteredEmail = '';
  var _enteredSenha = '';
  var _enteredNome = '';
  var _enteredSobrenome = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredSenha);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredSenha);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
              'nome': _enteredNome,
              'sobrenome': _enteredSobrenome,
              'email': _enteredEmail
            });
      }
    } on FirebaseAuthException catch (error) {
      String? mensagemErro;

      if (error.code == 'email-already-in-use') {
        mensagemErro = 'Este email já está em uso.';
      }

      if (error.code == 'user-not-found') {
        mensagemErro = 'Usuário não encontrado.';
      }

      if (error.code == 'wrong-password') {
        mensagemErro = 'Senha incorreta.';
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemErro ?? 'Erro ao autenticar conta.'),
          action: SnackBarAction(
              label: 'Fechar',
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              }),
        ),
      );

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    top: 30, bottom: 10, left: 20, right: 20),
                width: 150,
                height: 100,
                child: Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.white, size: 80),
                    Text(
                      "#",
                      style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 90,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Text(
                'DesalTech',
                style: GoogleFonts.robotoCondensed(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 54,
                    fontWeight: FontWeight.bold),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 14)),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Por favor, insira um email válido.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if (!_isLogin)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Nome',
                                        labelStyle: TextStyle(fontSize: 14)),
                                    keyboardType: TextInputType.name,
                                    autocorrect: false,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Por favor, insira um nome válido.';
                                      }

                                      return null;
                                    },
                                    onSaved: (value) {
                                      _enteredNome = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Sobrenome',
                                      labelStyle: TextStyle(fontSize: 14),
                                    ),
                                    keyboardType: TextInputType.name,
                                    autocorrect: false,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Por favor, insira um sobrenome válido.';
                                      }

                                      return null;
                                    },
                                    onSaved: (value) {
                                      _enteredSobrenome = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Senha fraca. Deve possuir ao menos 6 caracteres.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredSenha = value!;
                            },
                          ),
                          const SizedBox(height: 15),
                          if (!_isAuthenticating)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  child:
                                      Text(_isLogin ? 'Entrar' : 'Criar conta'),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                    },
                                    child: Text(_isLogin
                                        ? 'Criar nova conta'
                                        : 'Já tenho uma conta')),
                              ],
                            ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'VERSÃO BETA',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
