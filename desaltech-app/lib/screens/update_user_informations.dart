import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:desaltech_app/widgets/main_app_bar.dart';

class UpdateUserInformations extends StatefulWidget {
  const UpdateUserInformations({super.key});

  @override
  State<UpdateUserInformations> createState() {
    return _UpdateUserInformationsState();
  }
}

final _firebase = FirebaseAuth.instance;
final authenticatedUserId = _firebase.currentUser!.uid;

class _UpdateUserInformationsState extends State<UpdateUserInformations> {
  final _formKey = GlobalKey<FormState>();

  var _enteredNome = '';
  var _enteredSobrenome = '';
  var _enteredCidade = '';
  var _enteredEstado = '';
  var _enteredPais = '';
  var _enteredCelular = '';
  var _isSetting = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
        _isSetting = true;
      });

    await FirebaseFirestore.instance
            .collection('users')
            .doc(authenticatedUserId)
            .update({
              'nome': _enteredNome,
              'sobrenome': _enteredSobrenome,
              'cidade': _enteredCidade,
              'estado': _enteredEstado,
              'pais': _enteredPais,
              'celular': _enteredCelular
            });
    
    setState(() {
      _isSetting = false;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dados salvos com sucesso.'),
          action: SnackBarAction(
              label: 'Fechar',
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              }),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.getAppBar(context, 'Meu Perfil'),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
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
                                labelText: 'Nome',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
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
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Sobrenome',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
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
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Cidade',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value == null ||
                                  value.trim().isEmpty) {
                                    return 'Por favor, insira uma cidade válida.';
                                  }
                    
                                return null;
                              },
                              onSaved: (value) {
                                _enteredCidade = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Estado (UF)',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 2) {
                                    return 'Por favor, insira um estado válido. (Formato: UF)';
                                  }
                    
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEstado = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'País',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value == null ||
                                  value.trim().isEmpty) {
                                    return 'Por favor, insira um país válido.';
                                  }
                    
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPais = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Número de celular',
                                labelStyle: TextStyle(fontSize: 14)
                                ),
                              keyboardType: TextInputType.phone,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value == null ||
                                  value.trim().isEmpty) {
                                    return 'Por favor, insira um número de celular válido.';
                                  }
                    
                                return null;
                              },
                              onSaved: (value) {
                                _enteredCelular = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (!_isSetting)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _submit, 
                          child: const Text('Salvar alterações')
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade200,
                            foregroundColor: Colors.white
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text('Sair')
                        ),
                      ],
                    ),
                  ),
                if (_isSetting)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}