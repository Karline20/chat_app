import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
