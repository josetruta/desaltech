import 'package:flutter/material.dart';

import 'package:desaltech_app/widgets/main_app_bar.dart';
import 'package:desaltech_app/screens/update_user_informations.dart';
import 'package:desaltech_app/widgets/user_informations.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MainAppBar.getAppBar(context, 'Meu Perfil'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserInformations(),
          const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const UpdateUserInformations(),
                    ),
                  );
                }, 
                child: const Text('Quero atualizar meus dados')
              ),
            ),           
          const SizedBox(height: 20)
        ],
      ),
    );     
  }
}