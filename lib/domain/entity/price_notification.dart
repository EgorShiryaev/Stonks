class PriceNotification {
  final int price;
  final bool needLarge;

  PriceNotification({required this.price, required this.needLarge});

  bool needNotify(int currentPrice) {
    if (needLarge) {
      return currentPrice >= price;
    } else {
      return currentPrice <= price;
    }
  }
}
