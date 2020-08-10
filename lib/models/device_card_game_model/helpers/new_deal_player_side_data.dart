import 'package:test_provider/constants.dart';

class NewDealPlayerSideData {
  NewDealPlayerSideData({this.playerSide, this.playerName, this.cardsDealt});
  final Side playerSide;
  final String playerName;
  final List<String> cardsDealt;
}
