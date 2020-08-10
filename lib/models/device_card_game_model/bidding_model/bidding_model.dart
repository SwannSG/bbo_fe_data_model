import 'package:test_provider/constants.dart';
import 'package:validators/validators.dart';

class BiddingModel {}

class Bid {
  Bid({this.side, this.bid}) {
    bool isValidBid = false;
    if (bid == 'P') {
      isValidBid = true;
    } else if (bid == 'D') {
      isValidBid = true;
    } else if (bid == 'R') {
      isValidBid = true;
    } else if (isNumeric(bid[0])) {
      if ((int.parse(bid[0]) >= 1 && int.parse(bid[0]) <= 1) &&
          ['N', 'S', 'H', 'D', 'C'].contains(bid[1])) {
        isValidBid = true;
      }
    }
  }
  final Side side;
  final String bid;
}
