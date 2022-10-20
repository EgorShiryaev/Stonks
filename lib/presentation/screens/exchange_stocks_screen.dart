import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stonks/domain/entity/entities.dart';

import '../../data/models/stock_model.dart';
import '../../settings.dart';

final exchanges = [
  'AS',
  'AT',
  'AX',
  'BA',
  'BC',
  'BD',
  'BE',
  'BK',
  'BO',
  'BR',
  'CA',
  'CN',
  'CO',
  'CR',
  'DB',
  'DE',
  'DU',
  'F',
  'HE',
  'HK',
  'HM',
  'IC',
  'IR',
  'IS',
  'JK',
  'JO',
  'KL',
  'KQ',
  'KS',
  'L',
  'LN',
  'LS',
  'MC',
  'ME',
  'MI',
  'MU',
  'MX',
  'NE',
  'NL',
  'NS',
  'NZ',
  'OL',
  'PA',
  'PM',
  'PR',
  'QA',
  'RG',
  'SA',
  'SG',
  'SI',
  'SN',
  'SR',
  'SS',
  'ST',
  'SW',
  'SZ',
  'T',
  'TA',
  'TL',
  'TO',
  'TW',
  'TWO',
  'US',
  'V',
  'VI',
  'VN',
  'VS',
  'WA',
  'HA',
  'SX',
  'TG',
  'SC'
];

class ExchangeStocksScreen extends StatefulWidget {
  const ExchangeStocksScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeStocksScreen> createState() => _ExchangeStocksScreenState();
}

class _ExchangeStocksScreenState extends State<ExchangeStocksScreen> {
  String currentExchange = '';

  List<StockEntity> _stocks = [];
  bool isLoading = true;

  @override
  void initState() {
    setExchange('US');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Биржа:',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton(
                value: currentExchange,
                items: exchanges
                    .map(
                      (e) => DropdownMenuItem<String>(
                        child: Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        ),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: setExchange,
              ),
            ],
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            if (!isLoading) {
              if (_stocks.isNotEmpty) {
                return Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.separated(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _stocks[index].ticker,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  _stocks[index].title,
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _stocks.length,
                  ),
                );
              } else {
                return const Center(
                  child: Text('Ничего не найдено'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          }),
        )
      ],
    );
  }

  void setExchange(String? newValue) {
    setState(() {
      currentExchange = newValue!;
      isLoading = true;
    });
    getAll();
  }

  Future<void> getAll() async {
    final response = await Client()
        .get(SETTINGS.getUrl('stock/symbol?exchange=$currentExchange'));

    if (response.statusCode == 200) {
      final List<dynamic> stocks = json.decode(response.body) as List<dynamic>;

      setState(() {
        _stocks = stocks
            .map((e) => StockModel.fromSearch(e as Map<String, dynamic>))
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        _stocks = [];
        isLoading = false;
      });
    }
  }
}
