import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppBar {
  MainAppBar();

  static PreferredSizeWidget getAppBar(BuildContext context, String titulo) {
    return AppBar(
        title: Text(titulo,
          style: GoogleFonts.robotoCondensed(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      );
  }
}