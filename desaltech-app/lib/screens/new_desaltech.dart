import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:desaltech_app/models/desaltech.dart';
import 'package:desaltech_app/widgets/main_app_bar.dart';

class NewDesaltechScreen extends StatefulWidget {
  const NewDesaltechScreen({super.key});

  @override
  State<NewDesaltechScreen> createState() => _NewDesaltechScreenState();
}

const uuid = Uuid();

final _firebase = FirebaseAuth.instance;
final authenticatedUserId = _firebase.currentUser!.uid;

class _NewDesaltechScreenState extends State<NewDesaltechScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isSubmitting = false;
  var _enteredName = '';
  var _enteredLocation = '';
  var _enteredVolumeReservatorio = '';
  var _enteredVolumeDestilado = '';
  Model _selectedModel = Model.padrao;
  final _enteredCreatedAt = DateTime.now();
  final _desaltechUid = uuid.v4();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    FocusManager.instance.primaryFocus?.unfocus();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    

    setState(() {
        _isSubmitting = true;
      });

    await FirebaseFirestore.instance
            .collection('users')
            .doc(authenticatedUserId)
            .update({
              'desaltech-uid': FieldValue.arrayUnion([_desaltechUid])
            });
    
    await FirebaseFirestore.instance
            .collection('desaltechs')
            .doc(_desaltechUid)
            .set({
              'desaltech-name': _enteredName,
              'location': _enteredLocation,
              'model': _selectedModel.toString(),
              'createdAt': _enteredCreatedAt,
              'owner-uid': authenticatedUserId,
              'vol-reservatorio': _enteredVolumeReservatorio,
              'vol-destilado': _enteredVolumeDestilado
            });
    
    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Desaltech cadastrado com sucesso.'),
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
      appBar: MainAppBar.getAppBar(context, 'Novo DesalTech'),
      body: SingleChildScrollView(
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'DADOS DO DESALTECH',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'ID do DesalTech',
                              labelStyle: TextStyle(fontSize: 14)
                              ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.characters,
                            validator: (value) {
                              if (value == null ||
                                value.trim().isEmpty) {
                                  return 'Por favor, insira o ID válido do seu DesalTech.';
                                }
                    
                              return null;
                            },
                            onSaved: (value) {
                              _enteredName = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Localização do DesalTech',
                              labelStyle: TextStyle(fontSize: 14)
                              ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                value.trim().isEmpty) {
                                  return 'Por favor, insira o ID válido do seu DesalTech.';
                                }
                    
                              return null;
                            },
                            onSaved: (value) {
                              _enteredLocation = value!;
                            },
                          ),
                          TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Volume do Reservatório (em litros)',
                                    labelStyle: TextStyle(fontSize: 14)
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                      value.trim().isEmpty ||
                                      value == '0') {
                                        return 'Por favor, insira uma capacidade válida.';
                                      }
                                                    
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredVolumeReservatorio = value!;
                                  },
                                ),
                          TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Volume do Tanque Destilado (em litros)',
                                    labelStyle: TextStyle(fontSize: 14)
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                      value.trim().isEmpty ||
                                      value == '0') {
                                        return 'Por favor, insira uma capacidade válida.';
                                      }
                                                    
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredVolumeDestilado = value!;
                                  },
                                ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Modelo: ',
                                style: TextStyle(
                                  color: Colors.grey.shade800
                                )),
                              const SizedBox(width: 8),
                              DropdownButton(
                                value: _selectedModel,
                                items: Model.values.map(
                                  (model) => DropdownMenuItem(
                                    value: model,
                                    child: Text(model.name.toUpperCase()),
                                  ),
                                ).toList(), 
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedModel = value;
                                  });
                                }
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'OBS: Tenha certeza que o ID do DesalTech está igual ao seu equipamento.',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (!_isSubmitting)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                      ),
                      child: const Text('Catalogar DesalTech'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ),
                    ),
                  ],
                ),
              if (_isSubmitting)
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      );
    
  }
}