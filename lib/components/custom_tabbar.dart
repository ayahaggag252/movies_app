import 'package:flutter/material.dart';


class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.tabItems,
  }) : super(key: key);

  final List<Widget> tabItems;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent),
      child: TabBar(
        tabs: tabItems,
        indicatorColor: Colors.transparent,
        automaticIndicatorColorAdjustment: false,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 24.0),
      ),
    );
  }
}
