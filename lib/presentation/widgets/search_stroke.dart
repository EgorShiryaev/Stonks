import 'package:flutter/material.dart';

class SearchStroke extends StatefulWidget {
  final void Function(String text) search;
  final void Function() clear;

  const SearchStroke({
    Key? key,
    required this.search,
    required this.clear,
  }) : super(key: key);

  @override
  State<SearchStroke> createState() => _SearchStrokeState();
}

class _SearchStrokeState extends State<SearchStroke> {
  final controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black),
                  onPressed: _clear,
                  splashColor: Colors.white,
                )
              : null,
          fillColor: Colors.grey.shade300,
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
        onChanged: _onChanged,
      ),
    );
  }

  void _onChanged(String text) {
    setState(() {});
    if (text.isEmpty) {
      return widget.clear();
    }
    return widget.search(text);
  }

  _clear() {
    controller.clear();
    _onChanged(controller.text);
    if (_focusNode.hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
