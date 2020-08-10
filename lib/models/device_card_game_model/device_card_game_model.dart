import 'screen_side_model/west_screen_side_model.dart';
import 'screen_side_model/north_screen_side_model.dart';
import 'screen_side_model/east_screen_side_model.dart';
import 'screen_side_model/south_screen_side_model.dart';
import 'package:test_provider/constants.dart';
import 'package:test_provider/models/device_card_game_model/helpers/new_deal_player_side_data.dart';
import 'package:test_provider/models/device_card_game_model/screen_side_model/screen_side_model.dart';

class DeviceCardGameModel {
  WestScreenSideModel _westScreenSideModel;
  NorthScreenSideModel _northScreenSideModel;
  EastScreenSideModel _eastScreenSideModel;
  SouthScreenSideModel _southScreenSideModel;
  Map<Side, ScreenSideModel> _mapPlayerToScreenSide = {};
  Side _playerSideForThisScreen;
  String _trumps;

  Side get playerSideForThisScreen => _playerSideForThisScreen;

  get southScreenSideModel => _southScreenSideModel;
  set southScreenSideModel(SouthScreenSideModel value) {
    _southScreenSideModel = value;
  }

  get westScreenSideModel => _westScreenSideModel;
  set westScreenSideModel(WestScreenSideModel value) {
    _westScreenSideModel = value;
  }

  get northScreenSideModel => _northScreenSideModel;
  set northScreenSideModel(NorthScreenSideModel value) {
    _northScreenSideModel = value;
  }

  get eastScreenSideModel => _eastScreenSideModel;
  set eastScreenSideModel(EastScreenSideModel value) {
    _eastScreenSideModel = value;
  }

  // RECEIVED FROM "SOME EXTERNAL SOURCE"
  void setDeviceSide(Side side) {
    // MAP PLAYER_SIDE TO SCREEN_SIDE
    // eg. MAP SIDE.west --> _westScreenSideModel object
    _playerSideForThisScreen = side;
    if (side == Side.south) {
      _southScreenSideModel.playerSide = Side.south;
      _westScreenSideModel.playerSide = Side.west;
      _northScreenSideModel.playerSide = Side.north;
      _eastScreenSideModel.playerSide = Side.east;
      _mapPlayerToScreenSide[Side.south] = _southScreenSideModel;
      _mapPlayerToScreenSide[Side.west] = _westScreenSideModel;
      _mapPlayerToScreenSide[Side.north] = _northScreenSideModel;
      _mapPlayerToScreenSide[Side.east] = _eastScreenSideModel;
    } else if (side == Side.west) {
      _southScreenSideModel.playerSide = Side.west;
      _westScreenSideModel.playerSide = Side.north;
      _northScreenSideModel.playerSide = Side.east;
      _eastScreenSideModel.playerSide = Side.south;
      _mapPlayerToScreenSide[Side.south] = _westScreenSideModel;
      _mapPlayerToScreenSide[Side.west] = _northScreenSideModel;
      _mapPlayerToScreenSide[Side.north] = _eastScreenSideModel;
      _mapPlayerToScreenSide[Side.east] = _southScreenSideModel;
    } else if (side == Side.north) {
      _southScreenSideModel.playerSide = Side.north;
      _westScreenSideModel.playerSide = Side.east;
      _northScreenSideModel.playerSide = Side.south;
      _eastScreenSideModel.playerSide = Side.west;
      _mapPlayerToScreenSide[Side.south] = _northScreenSideModel;
      _mapPlayerToScreenSide[Side.west] = _eastScreenSideModel;
      _mapPlayerToScreenSide[Side.north] = _southScreenSideModel;
      _mapPlayerToScreenSide[Side.east] = _westScreenSideModel;
    } else if (side == Side.east) {
      _southScreenSideModel.playerSide = Side.east;
      _westScreenSideModel.playerSide = Side.south;
      _northScreenSideModel.playerSide = Side.west;
      _eastScreenSideModel.playerSide = Side.north;
      _mapPlayerToScreenSide[Side.south] = _eastScreenSideModel;
      _mapPlayerToScreenSide[Side.west] = _southScreenSideModel;
      _mapPlayerToScreenSide[Side.north] = _westScreenSideModel;
      _mapPlayerToScreenSide[Side.east] = _northScreenSideModel;
    }
  }

  // RECEIVED FROM "SOME EXTERNAL SOURCE"
  // START OF NEW DEAL
  void newDeal(
      {Side dealer,
      NewDealPlayerSideData southPlayerSideData,
      NewDealPlayerSideData westPlayerSideData,
      NewDealPlayerSideData northPlayerSideData,
      NewDealPlayerSideData eastPlayerSideData}) {
    _mapPlayerToScreenSide[southPlayerSideData.playerSide]
        .startOfNewHand(southPlayerSideData, dealer);

    _mapPlayerToScreenSide[westPlayerSideData.playerSide]
        .startOfNewHand(westPlayerSideData, dealer);
    _mapPlayerToScreenSide[northPlayerSideData.playerSide]
        .startOfNewHand(northPlayerSideData, dealer);
    _mapPlayerToScreenSide[eastPlayerSideData.playerSide]
        .startOfNewHand(eastPlayerSideData, dealer);
  }

  // RECEIVED FROM "SOME EXTERNAL SOURCE"
  void playCard({String cardValue, Side side}) {
    if (side == _playerSideForThisScreen) {
      // the card has visually already been dragged and dropped
      // on the local screen
    } else {
      _mapPlayerToScreenSide[side].animatePlayOfCard(cardValue);
    }
  }

  // RECEIVED FROM LOCAL UI
  void localCardPlayed({String cardValue, Side side}) {}

  void setTrumpsAfterBidding(String trumps) {
    assert(['N', 'S', 'H', 'D', 'C'].contains(trumps));
    _trumps = trumps;
    _southScreenSideModel.sortHand(trumps);
    _westScreenSideModel.sortHand(trumps);
    _northScreenSideModel.sortHand(trumps);
    _eastScreenSideModel.sortHand(trumps);
  }
}
