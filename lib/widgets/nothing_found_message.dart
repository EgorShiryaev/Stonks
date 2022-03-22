import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/stocks_provider.dart';

class NothingFoundMessage extends StatelessWidget {
  const NothingFoundMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          'По запросу «${Provider.of<StocksProvider>(context).lastQuery} ничего не найдено',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
