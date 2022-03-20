import 'package:flutter/material.dart';

import 'search_stroke.dart';


class StonksFlexibleAppBar extends StatelessWidget {
  const StonksFlexibleAppBar({Key? key}) : super(key: key);
  static const appBarHeight = 70.0;
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 15, right: 15),
      height: appBarHeight + statusBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SearchStroke(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
