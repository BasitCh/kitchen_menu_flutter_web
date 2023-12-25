import 'package:flutter/material.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // onDrawerPressed: Scaffold.of(context).openDrawer,
        // onNotificationPressed: () {},
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Page is under construction',
        ),
      ),
    );
  }
}
