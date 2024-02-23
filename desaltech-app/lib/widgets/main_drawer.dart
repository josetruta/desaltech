import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:desaltech_app/widgets/hello_card.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen
  });

  final void Function(String identifier) onSelectScreen;
  
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
                    Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)
                  ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
                ),
              ),
              child: const HelloCard(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_filled,
              size: 22,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              'Página Inicial',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 18
              )
            ),
            onTap: () {
              onSelectScreen('pagina-inicial');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 22,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              'Meu Perfil',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 18
              )
            ),
            onTap: () {
              onSelectScreen('perfil');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.water_drop,
              size: 22,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              'Meus DesalTechs',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 18
              )
            ),
            onTap: () {
              onSelectScreen('lista-desaltech');
            },
          ),
          const Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 22,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            title: Text(
              'Sair',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 18
              )
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          Text(
            'VERSÃO BETA',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer
            )
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}