import 'package:stonks/domain/entity/stock_entity.dart';

abstract class ListenLastPriceState {}

class ListenLastPriceConnectingState extends ListenLastPriceState {}

class ListenLastPriceConnectedState extends ListenLastPriceState {}

class ListenLastPriceDisconnectedState extends ListenLastPriceState {}

class ListenLastPriceErrorConnectingState extends ListenLastPriceState {}

class ListenLastPriceNewDataState extends ListenLastPriceState {
  final List<StockEntity> stocks;

  ListenLastPriceNewDataState({required this.stocks});
}
