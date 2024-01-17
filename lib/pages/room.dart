import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Steigenberger Makadi'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        color: Colors.purple[800],
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/booking');
          },
          child: Text('CHOOSE A ROOM'),
        ),
      ),
    );
  }
}
