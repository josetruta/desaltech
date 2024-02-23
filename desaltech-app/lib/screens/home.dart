import 'package:desaltech_app/screens/desaltech_list.dart';
import 'package:desaltech_app/widgets/main_app_bar.dart';
import 'package:desaltech_app/widgets/weather_card.dart';
import 'package:flutter/material.dart';

import 'package:desaltech_app/widgets/main_drawer.dart';
import 'package:desaltech_app/screens/perfil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _selectPage(String identifier) async {
    Navigator.of(context).pop(); 
    if (identifier == 'perfil') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const PerfilScreen(),
        ),
      );
    }
    if (identifier == 'lista-desaltech') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const DesalTechListScreen(),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _selectPage,
      ),
      appBar: MainAppBar.getAppBar(context, 'DesalTech'),
      body: const Column(
        children: [
          WeatherCard()
        ]
      ),
    );
  }
}