import 'package:test_provider/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:test_provider/models/device_card_game_model/device_card_game_model.dart';
import 'package:test_provider/models/device_card_game_model/helpers/sort_cards_in_hand.dart';
import 'package:test_provider/models/device_card_game_model/helpers/new_deal_player_side_data.dart';
import 'package:test_provider/models/device_card_game_model/helpers/card_data_model.dart';

class ScreenSideModel extends ChangeNotifier with SortCardsInHand {
  ScreenSideModel({DeviceCardGameModel cardGameModel})
      : _deviceCardGameModel = cardGameModel;

  DeviceCardGameModel _deviceCardGameModel;
  List<CardDataModel> _cardsInHand;

  String _playerName;
  Side _playerSide;
  bool _yourTurn = false;

  Side get playerSide => _playerSide;
  set playerSide(Side newValue) {
    _playerSide = newValue;
  }

  String get playerName => _playerName;
  set playerName(newValue) {
    if (newValue != _playerName) {
      _playerName = newValue;
      print('set playerName: ${this.runtimeType}');
      notifyListeners();
    }
  }

  List<CardDataModel> get cardsInHand => _cardsInHand;

  void startOfNewHand(NewDealPlayerSideData newValue, Side dealer) {
    _yourTurn = (dealer == playerSide) ? true : false;
    _playerName = newValue.playerName;
    _playerSide = newValue.playerSide;
    _cardsInHand = sortCardsInHand(
        _cardsAsStringToCardsDataModel(newValue.cardsDealt), 'N');
    print('startOfNewHand: ${this.runtimeType}');
    notifyListeners();
  }

  List<CardDataModel> _cardsAsStringToCardsDataModel(List<String> cardsDealt) {
    List<CardDataModel> result = [];
    cardsDealt.forEach((element) {
      result.add(
        CardDataModel(
          cardValue: element,
          isDraggable: false,
          isCardFaceback:
              _playerSide == _deviceCardGameModel.playerSideForThisScreen
                  ? false
                  : true,
        ),
      );
    });
    return result;
  }

  void cardDraggedAndDropped(String cardValue) {
    // HOW DO WE HANDLE AN UNDO ? AND WHERE ?
    _deviceCardGameModel.localCardPlayed(
        cardValue: cardValue, side: _playerSide);
  }

  void animatePlayOfCard(String cardValue) {
    // INFORM UI -
    // ANIMATE CARD MOVEMENT FROM HAND
    // NOT SURE HOW WE HANDLE THIS
  }

  void sortHand(String trumps) {
    assert(['N', 'S', 'H', 'D', 'C'].contains(trumps));
    _cardsInHand = sortCardsInHand(_cardsInHand, trumps);

    print('sortHand: ${this.runtimeType}');
    notifyListeners();
  }
}
