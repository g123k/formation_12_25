import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 1000,
        itemBuilder: (BuildContext context, int position) {
          print(position);
          return SizedBox(height: 30.0, child: Text(position.toString()));
        },
        separatorBuilder: (BuildContext context, int position) {
          return Divider();
        },
        cacheExtent: 30.0,
      ),
    );
  }
}
