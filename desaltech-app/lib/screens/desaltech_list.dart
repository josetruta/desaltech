import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desaltech_app/screens/desaltech_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:desaltech_app/screens/new_desaltech.dart';
import 'package:desaltech_app/widgets/desaltech_item.dart';
import 'package:desaltech_app/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';

DocumentSnapshot? snapshot;
final authenticatedUserId = FirebaseAuth.instance.currentUser!.uid;

class DesalTechListScreen extends StatefulWidget {
  const DesalTechListScreen({
    super.key,
  });

  @override
  State<DesalTechListScreen> createState() => _DesalTechListScreenState();
}

class _DesalTechListScreenState extends State<DesalTechListScreen> {
  late DocumentSnapshot snap;
  
  final _usersData = FirebaseFirestore.instance
        .collection('users')
        .doc(authenticatedUserId)
        .snapshots();

  @override
  Widget build(BuildContext context) {

    Widget? content;

    Widget button = ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.9),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const NewDesaltechScreen(),
                  ),
                );
              },
              child: const Text('Adicionar novo DesalTech'));

    return StreamBuilder(
      stream: _usersData, 
      builder: (context, snapshot) {
        
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        final data = snapshot.data!.data()!;
        List<dynamic>? listaDesalTechs = data['desaltech-uid'];

        if (listaDesalTechs == null) {
          content = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Sem equipamentos catalogados.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 15),
                Text('Tente adicionar algum!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 30),
                button
              ],
            ),
          );
        }

        if (listaDesalTechs != null) {
          content = ListView.builder(
                  itemCount: listaDesalTechs.length,
                  itemBuilder:(ctx, index) => DesalTechItem(
                    desaltechUid: listaDesalTechs[index],
                    onSelectDesaltech: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DesalTechInformationScreen(
                            desaltechUid: listaDesalTechs[index]),
                        ),
                      );
                    }
                  ),
                );
        }

        return Scaffold(
        appBar: AppBar(
          title: Text('Meus Desaltechs',
            style: GoogleFonts.robotoCondensed(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const NewDesaltechScreen(),
                  ),
                );
              }, 
              icon: const Icon(
                Icons.add_box_outlined,
              ),
            ),
          ]
        ),
        body: content
      );
    }
  );
}
}
