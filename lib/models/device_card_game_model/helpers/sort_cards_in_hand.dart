import 'package:test_provider/models/device_card_game_model/helpers/card_data_model.dart';

class SortCardsInHand {
  List<CardDataModel> sortCardsInHand(
      List<CardDataModel> cardsInHand, String trumps) {
    List<String> suitOrder = ['S', 'H', 'D', 'C'];
    if (trumps == 'N' || trumps == 'S') {
      // NO-TRUMPS OR SPADES
    } else if (trumps == 'H') {
      suitOrder = ['H', 'S', 'D', 'C'];
    } else if (trumps == 'D') {
      suitOrder = ['D', 'S', 'H', 'C'];
    } else if (trumps == 'C') {
      suitOrder = ['C', 'H', 'S', 'D'];
    }

    final Map<String, List<CardDataModel>> cardsInSuits =
        _splitCardsIntoSuits(cardsInHand);
    _sortCardsInSuit(cardsInSuits[suitOrder[0]]);
    _sortCardsInSuit(cardsInSuits[suitOrder[1]]);
    _sortCardsInSuit(cardsInSuits[suitOrder[2]]);
    _sortCardsInSuit(cardsInSuits[suitOrder[3]]);
    return [
      ...cardsInSuits[suitOrder[0]],
      ...cardsInSuits[suitOrder[1]],
      ...cardsInSuits[suitOrder[2]],
      ...cardsInSuits[suitOrder[3]]
    ];
  }

  void _sortCardsInSuit(List<CardDataModel> cardsInSuit) {
    cardsInSuit.sort((a, b) {
      if (a.getFacevalueAsInt() > b.getFacevalueAsInt()) {
        return -1;
      }
      return 1;
    });
  }

  Map<String, List<CardDataModel>> _splitCardsIntoSuits(
      List<CardDataModel> cardsInHand) {
    Map<String, List<CardDataModel>> result = {
      'S': [],
      'H': [],
      'D': [],
      'C': []
    };
    cardsInHand.forEach((item) {
      if (item.getSuit() == 'S') {
        result['S'].add(item);
      } else if (item.getSuit() == 'H') {
        result['H'].add(item);
      } else if (item.getSuit() == 'D') {
        result['D'].add(item);
      } else if (item.getSuit() == 'C') {
        result['C'].add(item);
      }
    });
    return result;
  }
}
