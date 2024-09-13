import 'package:flutter/material.dart';

class Tela1Page extends StatelessWidget {
  const Tela1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks List'),
        centerTitle: true,
      ),
    );
  }
}
