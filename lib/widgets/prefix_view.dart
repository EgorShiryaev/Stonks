import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/models/stock.dart';
import 'package:stonks/providers/prefix_provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

class PrefixView extends StatelessWidget {
  final List<Stock> prefixes;
  const PrefixView({Key? key, required this.prefixes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: prefixes.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Provider.of<StocksProvider>(context, listen: false).add(
            prefixes[index].prefix,
            prefixes[index].description,
          );
          Provider.of<PrefixProvider>(context, listen: false).clear();
        },
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prefixes[index].prefix,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                prefixes[index].description,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Divider(color: Colors.grey.shade700),
      ),
    );
  }
}
