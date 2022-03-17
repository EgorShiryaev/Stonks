class Stock {
  final String prefix;
  double lastPrice;
  final String description;

  Stock({
    required this.prefix,
    required this.lastPrice,
    required this.description,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      prefix: json['s'],
      lastPrice: double.parse(json['p'].toString()),
      description: '',
    );
  }

  updateLastPrice(String newPrice) => lastPrice = double.parse(newPrice);
}
