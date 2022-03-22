import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

class SearchStroke extends StatefulWidget {
  final TextEditingController controller;
  const SearchStroke({Key? key, required this.controller}) : super(key: key);

  @override
  State<SearchStroke> createState() => _SearchStrokeState();
}

class _SearchStrokeState extends State<SearchStroke> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.black),
            onPressed: _onSearch,
            splashColor: Colors.white,
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black),
                  onPressed: _onClear,
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
        controller: widget.controller,
        style: Theme.of(context).textTheme.caption,
        cursorColor: Colors.black12,
        onChanged: _onChanged,
      ),
    );
  }

  _onSearch() => Provider.of<StocksProvider>(context, listen: false)
      .searchStock(widget.controller.text);

  _onChanged(String text) {
    if (text.isEmpty) {
      Provider.of<StocksProvider>(context, listen: false)
          .deleteSearchedStocks();
    }
  }

  _onClear() {
    widget.controller.clear();
    Provider.of<StocksProvider>(context, listen: false).deleteSearchedStocks();
  }
}
