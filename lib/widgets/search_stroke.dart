import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/prefix_provider.dart';

class SearchStroke extends StatelessWidget {
  SearchStroke({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.black),
            onPressed: () =>
                Provider.of<PrefixProvider>(context, listen: false).search(
              controller.text,
            ),
          ),
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
        onChanged: (text) {
          if (text.isEmpty) {
            Provider.of<PrefixProvider>(context, listen: false).clear();
          }
        },
        onSubmitted: (text) {
          if (text.isEmpty) {
            Provider.of<PrefixProvider>(context, listen: false).search(
              text,
            );
          }
        },
        
      ),
    );
  }
}
