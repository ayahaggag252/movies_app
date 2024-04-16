import 'package:flutter/material.dart';

class MovieSliverGrid extends StatelessWidget {
  const MovieSliverGrid({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Widget> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: data[index],
        );
      },
    );
  }
}
