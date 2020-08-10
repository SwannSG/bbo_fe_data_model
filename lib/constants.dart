import 'package:flutter/material.dart';

// FOR TESTING ONLY
int globalCounter = 1;

enum Side { north, south, west, east }

const Map<Side, String> sideToChar = {
  Side.north: 'N',
  Side.south: 'S',
  Side.west: 'W',
  Side.east: 'E'
};

List<String> cardsAsString = [
  '2S',
  '3S',
  '4S',
  '5S',
  '6S',
  '7S',
  '8S',
  '9S',
  'TS',
  'JS',
  'QS',
  'KS',
  'AS',
  '2H',
  '3H',
  '4H',
  '5H',
  '6H',
  '7H',
  '8H',
  '9H',
  'TH',
  'JH',
  'QH',
  'KH',
  'AH',
  '2D',
  '3D',
  '4D',
  '5D',
  '6D',
  '7D',
  '8D',
  '9D',
  'TD',
  'JD',
  'QD',
  'KD',
  'AD',
  '2C',
  '3C',
  '4C',
  '5C',
  '6C',
  '7C',
  '8C',
  '9C',
  'TC',
  'JC',
  'QC',
  'KC',
  'AC',
];

const List<String> cardsAsStringConstant = [
  '2S',
  '3S',
  '4S',
  '5S',
  '6S',
  '7S',
  '8S',
  '9S',
  'TS',
  'JS',
  'QS',
  'KS',
  'AS',
  '2H',
  '3H',
  '4H',
  '5H',
  '6H',
  '7H',
  '8H',
  '9H',
  'TH',
  'JH',
  'QH',
  'KH',
  'AH',
  '2D',
  '3D',
  '4D',
  '5D',
  '6D',
  '7D',
  '8D',
  '9D',
  'TD',
  'JD',
  'QD',
  'KD',
  'AD',
  '2C',
  '3C',
  '4C',
  '5C',
  '6C',
  '7C',
  '8C',
  '9C',
  'TC',
  'JC',
  'QC',
  'KC',
  'AC',
];

const Map<String, int> cardFacevalueToInt = {
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
};

const Map<String, String> suitCharToName = {
  'S': 'spade',
  'H': 'heart',
  'D': 'diamond',
  'C': 'club'
};

const Map<String, String> suitNameToChar = {
  'spade': 'S',
  'heart': 'H',
  'diamond': 'D',
  'club': 'C',
};

const SUIT_ICON = {'S': '\u2660', 'H': '\u2665', 'D': '\u25C6', 'C': '\u2663'};

const SUIT_ICON_COLOR = {
  'S': Colors.black,
  'H': Colors.red,
  'D': Colors.red,
  'C': Colors.black,
};
