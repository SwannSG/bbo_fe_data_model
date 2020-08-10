class CardDataModel {
  CardDataModel({String cardValue, bool isCardFaceback, bool isDraggable})
      : cardValue = cardValue,
        isCardFaceback = isCardFaceback,
        isDraggable = isDraggable {
    isDraggable = isCardFaceback ? false : isDraggable;
    assert(['S', 'H', 'D', 'C'].contains(cardValue[1]),
        'CardDartModel.cardValue invalid suit');
    assert(
        ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
            .contains(cardValue[0]),
        'CardDartModel.cardValue invalid facevalue');
  }
  final String cardValue;
  final bool isCardFaceback;
  final bool isDraggable;

  String getSuit() => cardValue[1];
  int getFacevalueAsInt() {
    return {
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9,
      'T': 10,
      'J': 11,
      'Q': 12,
      'K': 13,
      'A': 14
    }[cardValue[0]];
  }

  @override
  String toString() {
    // '2s'     2s, not back of card, not draggable
    // '2s*'    2s, back of card, is always not draggable
    // '2s\u2193
    String result;
    if (!isCardFaceback && !isDraggable) {
      // card facevalue & not draggable
      result = cardValue;
    } else if (isCardFaceback) {
      // card faceback, is always not draggable
      result = '$cardValue*';
    } else if (isDraggable) {
      // card facevale & draggable
      result = '$cardValue\u2193';
    }
    return result;
  }
}
