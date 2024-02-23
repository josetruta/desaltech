import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final authenticatedUserId = FirebaseAuth.instance.currentUser!.uid;
final _usersData = FirebaseFirestore.instance.collection('users').doc(authenticatedUserId).snapshots();

class FormattedText {
  const FormattedText();

  Widget getFormattedText(title, data, context) {
    data ??= 'Não informado';
    
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ))
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  width: double.infinity,
                  child: Text(data)
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}

class UserInformations extends StatelessWidget {
  const UserInformations({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersData,
      builder: (context, snapshot) {
        
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            )
          );
        }

        final data = snapshot.data!.data()!;
        FormattedText formattedText = const FormattedText();

        return Column(
          children: [
            const SizedBox(height: 15),
            formattedText.getFormattedText('Nome', data['nome'], context),
            formattedText.getFormattedText('Sobrenome', data['sobrenome'], context),
            formattedText.getFormattedText('Endereço de e-mail', data['email'], context),
            formattedText.getFormattedText('Cidade', data['cidade'], context),
            formattedText.getFormattedText('Estado', data['estado'], context),
            formattedText.getFormattedText('País', data['pais'], context),
            formattedText.getFormattedText('Número de celular', data['celular'], context),
          ],
        );
      },
      );
  }
}