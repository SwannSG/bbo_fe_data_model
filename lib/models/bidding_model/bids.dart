import 'package:test_provider/models/bidding_model/bid.dart';
import 'package:test_provider/models/bidding_model/bid_box.dart';
import 'package:validators/validators.dart';

class Bids {
  List<Bid> bids;

  void addBid(Bid bid) {
    bids.add(bid);
  }

  BidBox getBidBox() {
    // must not be end of bidding !!
    assert(!isEndOfBidding(), 'getBidBox() called when end of bidding reached');
    int levelStart;
    String suitStart;
    List<String> levels;
    Map<String, List<String>> suits;
    String other;
    Map<String, String> lastDetails = _getLastDetails();

    if (lastDetails['lastSuit'] == 'N') {
      levelStart = int.parse(lastDetails['lastLevel']) + 1;
    } else if (lastDetails['lastSuit'] == '') {
      levelStart = 1;
    } else {
      levelStart = int.parse(lastDetails['lastLevel']);
    }
    if (lastDetails['lastLevel'] == '7' && lastDetails['lastSuit'] == 'N') {
      // 7NT SPECIAL CASE
      levels = [];
      suits = {'': []};
    } else {
      suitStart = _nextSuitUp(lastDetails['lastSuit']);
      levels = _getLevels(levelStart);
      suits = _getSuits(levelStart, suitStart);
    }
    other = _getOther(lastDetails['lastSuit']);
    return BidBox(levels: levels, suits: suits, other: other);
    // METHOD END
  }

  String _getOther(String lastSuit) {
    String result;
    int indexLastSuit;
    int i;
    if (lastSuit == '') {
      result = '';
    } else {
      indexLastSuit =
          bids.lastIndexWhere((bid) => bid.bid == lastSuit ? true : false);
      i = bids.length;
      result = '';
      while (i > indexLastSuit && i < bids.length) {
        if (bids[i].bid == 'R') {
          // RDBL
          result = '';
          break;
        } else if (bids[i].bid == 'D') {
          // DBL
          result = 'D';
          break;
        }
        i = i - 1;
      }
    }
    return result;
  }

  Map<String, List<String>> _getSuits(int levelStart, String suitStart) {
    Map<String, List<String>> result = {};
    int i = levelStart;
    while (i <= 7) {
      if (i == levelStart) {
        result[i.toString()] = _suitsToInclude(suitStart);
      } else {
        result[i.toString()] = ['C', 'D', 'H', 'S', 'N'];
      }
    }
    return result;
    // HIDDEN FUNCTION END
  }

  List<String> _suitsToInclude(String suit) {
    const Map<String, List<String>> suitsToIncludeLookup = {
      'C': ['C', 'D', 'H', 'S', 'N'],
      'D': ['D', 'H', 'S', 'N'],
      'H': ['H', 'S', 'N'],
      'S': ['S', 'N'],
      'N': ['N'],
    };
    return suitsToIncludeLookup[suit];
  }

  String _nextSuitUp(String suit) {
    const Map<String, String> nextSuitLookup = {
      '': 'C',
      'C': 'D',
      'D': 'H',
      'H': 'S',
      'S': 'N',
      'N': 'C',
    };
    return nextSuitLookup[suit];
  }

  List<String> _getLevels(int levelStart) {
    assert(levelStart > 0 && levelStart < 8);
    const Map<int, List<String>> levelsLookup = {
      1: ['1', '2', '3', '4', '5', '6', '7'],
      2: ['2', '3', '4', '5', '6', '7'],
      3: ['3', '4', '5', '6', '7'],
      4: ['4', '5', '6', '7'],
      5: ['5', '6', '7'],
      6: ['6', '7'],
      7: ['7'],
    };
    return levelsLookup[levelStart];
  }

  Map<String, String> _getLastDetails() {
    int i;
    int lastSuitIndex;
    Map<String, String> result = {
      'lastSuit': '',
      'lastLevel': '',
      'lastOther': ''
    };

    i = bids.length - 1;
    while (!_isBidASuit(bids[i])) {
      i = i - 1;
      if (i == -1) {
        // no suit found
        break;
      }
    }
    if (i == -1) {
      result['lastSuit'] = '';
      result['lastLevel'] = '';
      result['lastOther'] = '';
    } else {
      result['lastSuit'] = bids[i].bid[1];
      result['lastLevel'] = bids[i].bid[0];
      lastSuitIndex = i;
      i = bids.length - 1;
      while (i > lastSuitIndex) {
        if (_isBidDblOrRdbl(bids[i])) {
          result['lastOther'] = bids[i].bid;
          break;
        }
        i = i - 1;
        if (i == lastSuitIndex) {
          result['lastOther'] = '';
          break;
        }
      }
    }
    return result;
  }

  bool _isBidDblOrRdbl(Bid bid) {
    // DBL or RDBL
    bool result = false;
    if (bid.bid[0] == 'D' || bid.bid[0] == 'R') {
      result = true;
    }
    return result;
  }

  bool _isBidASuit(Bid bid) {
    bool result = false;
    if (isNumeric(bid.bid[0])) {
      result = true;
    }
    return result;
  }

  bool isEndOfBidding() {
    int l = bids.length;
    bool result;
    if (l < 4) {
      result = false;
    } else if (bids[l - 1].bid == 'P' &&
        bids[l - 2].bid == 'P' &&
        bids[l - 3].bid == 'P') {
      // last 3 bids are PASS
      result = true;
    }
    return result;
  }
}
