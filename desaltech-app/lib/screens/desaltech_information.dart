import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesalTechInformationScreen extends StatelessWidget {
  const DesalTechInformationScreen({
    super.key, 
    required this.desaltechUid
  });

  final String desaltechUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(desaltechUid,
          style: GoogleFonts.robotoCondensed(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
      ),
    );
  }
}