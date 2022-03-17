import 'package:flutter/material.dart';

class SearchStroke extends StatelessWidget {
  SearchStroke({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black),
          fillColor: Colors.white,
          hintText: 'Поиск',
          hintStyle: Theme.of(context).textTheme.caption,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        controller: controller,
        style: Theme.of(context).textTheme.caption,
        cursorColor: Colors.black12,
      ),
    );
  }
}
