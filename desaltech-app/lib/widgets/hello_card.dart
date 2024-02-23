import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _usersData = FirebaseFirestore.instance.collection('users').doc(authenticatedUserId).snapshots();

class HelloCard extends StatelessWidget {
  const HelloCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersData, 
      builder: (context, snapshot) {        

        if (snapshot.hasError) {
          return const Text('Houve algum erro. Tente mais tarde.');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.data()!;

        return Row(
          children: [
            Icon(
              Icons.person_pin,
              size: 52,
              color: Theme.of(context).colorScheme.onPrimaryContainer
            ),
            const SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo,',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer
                  )
                ),
                Text(
                  '${data['nome']} ${data['sobrenome']}',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 29,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
  }
}

final authenticatedUserId = FirebaseAuth.instance.currentUser!.uid;