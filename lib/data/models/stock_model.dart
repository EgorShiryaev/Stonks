import '../../domain/entity/entities.dart';

class StockModel extends StockEntity {
  StockModel({
    required String ticker,
    required String title,
    required int price,
  }) : super(
          ticker: ticker,
          title: title,
          price: price,
        );

  factory StockModel.fromLastPriceService(Map<String, dynamic> json) {
    return StockModel(
      ticker: json['s'] as String,
      title: '',
      price: ((json['p'] * 100) as num).round(),
    );
  }

  factory StockModel.fromSearch(Map<String, dynamic> json) {
    return StockModel(
      ticker: json['symbol'] as String,
      title: json['description'] as String,
      price: 0,
    );
  }
}
