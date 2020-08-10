import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:test_provider/models/device_card_game_model/device_card_game_model.dart';
import 'package:test_provider/models/device_card_game_model/helpers/new_deal_player_side_data.dart';
import 'models/device_card_game_model/screen_side_model/south_screen_side_model.dart';
import 'models/device_card_game_model/screen_side_model/west_screen_side_model.dart';
import 'models/device_card_game_model/screen_side_model/north_screen_side_model.dart';
import 'models/device_card_game_model/screen_side_model/east_screen_side_model.dart';
import 'package:test_provider/constants.dart';

final getIt = GetIt.instance;

void getItRegistrationStuff() {
  DeviceCardGameModel d = DeviceCardGameModel();
  SouthScreenSideModel s = SouthScreenSideModel(cardGameModel: d);
  WestScreenSideModel w = WestScreenSideModel(cardGameModel: d);
  NorthScreenSideModel n = NorthScreenSideModel(cardGameModel: d);
  EastScreenSideModel e = EastScreenSideModel(cardGameModel: d);
  d.southScreenSideModel = s;
  d.westScreenSideModel = w;
  d.northScreenSideModel = n;
  d.eastScreenSideModel = e;

  d.setDeviceSide(Side.south);

  getIt.registerSingleton<DeviceCardGameModel>(d);

  cardsAsString.shuffle();

  d.newDeal(
    dealer: Side.south,
    southPlayerSideData: NewDealPlayerSideData(
        playerSide: Side.south,
        playerName: 'SOUTH NAME',
        cardsDealt: cardsAsString.sublist(0, 13)),
    westPlayerSideData: NewDealPlayerSideData(
      playerSide: Side.west,
      playerName: 'WEST NAME',
      cardsDealt: cardsAsString.sublist(13, 26),
    ),
    northPlayerSideData: NewDealPlayerSideData(
      playerSide: Side.north,
      playerName: 'NORTH NAME',
      cardsDealt: cardsAsString.sublist(26, 39),
    ),
    eastPlayerSideData: NewDealPlayerSideData(
      playerSide: Side.east,
      playerName: 'EAST NAME',
      cardsDealt: cardsAsString.sublist(39, 52),
    ),
  );
}

void main() {
  getItRegistrationStuff();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<SouthScreenSideModel>.value(
                value: getIt.get<DeviceCardGameModel>().southScreenSideModel),
            ChangeNotifierProvider<WestScreenSideModel>.value(
                value: getIt.get<DeviceCardGameModel>().westScreenSideModel),
            ChangeNotifierProvider<NorthScreenSideModel>.value(
                value: getIt.get<DeviceCardGameModel>().northScreenSideModel),
            ChangeNotifierProvider<EastScreenSideModel>.value(
                value: getIt.get<DeviceCardGameModel>().eastScreenSideModel),
          ],
          child: Scaffold(
            body: PageFive(),
            floatingActionButton: ChangeValueInModelWest(),
          ),
        ),
      ),
    );
  }
}

class ChangeValueInModelWest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        getIt.get<DeviceCardGameModel>().setTrumpsAfterBidding('H');
      },
      color: Colors.yellow,
      child: Text('Change Trumps'),
    );
  }
}

class ChangeValueInModelNorth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        context.read<SouthScreenSideModel>().playerName = 'The Northern Skaap';
      },
      color: Colors.yellow,
      child: Text('Change South Player Name'),
    );
  }
}

class PageFive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CAN WE TEST REACTIVE VARIABLES HERE ?
    print(context.select((SouthScreenSideModel data) {
      return data.cardsInHand;
    }));
    // print(context.watch<SouthScreenSideModel>().cardsInHand);
    // print(context.watch<WestScreenSideModel>().cardsInHand);
    // print(context.watch<NorthScreenSideModel>().cardsInHand);
    // print(context.watch<EastScreenSideModel>().cardsInHand);

    return Container(
        color: Colors.amber,
        child: Column(
          children: <Widget>[
            Text(context.watch<SouthScreenSideModel>().playerName),
            // Text(context.watch<NorthScreenSideModel>().playerName),
            ChangeValueInModelNorth(),
          ],
        ));
  }
}

/*
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelOne>(
          create: (_) {
            print('Mediator singleton id: ${mediator.hashCode}');
            ModelOne modelOne = ModelOne();
            modelOne.addPerson('Joe', 'Bloggs', 28);
            modelOne.addPerson('Alfred', 'Bozo', 38);
            print('ModelOne singleton id: ${modelOne.getSingletonHashCode()}');
            print('ModelOne: ${modelOne.people[0]}');
            mediator.addModelOne(modelOne);
            print('mediator.modelOne.hashCode: ${mediator.modelOne.hashCode}');
            return modelOne;
          },
          lazy: false,
        )
      ],
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 120,
            top: 10,
            child: WidgetA(),
          ),
          Positioned(
            left: 120,
            top: 230,
            child: WidgetB(),
          ),
          Positioned(
            left: 120,
            bottom: 30,
            child: WidgetC(),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: WidgetD(),
          ),
          Positioned(
            left: 5,
            bottom: 5,
            child: WidgetE(),
          ),
        ],
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Build WidgetA');
    print(mediator.modelOne.people);

    return Container(
      width: 100,
      height: 200,
      color: Colors.green,
      child: Text('WidgetA'),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Build WidgetB');
    return Container(
      width: 100,
      height: 200,
      color: Colors.blue,
      child: Text('WidgetB'),
    );
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Build WidgetB');
    return Container(
      width: 100,
      height: 200,
      color: Colors.pink,
      child: Text('WidgetC'),
    );
  }
}

class WidgetD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('D'),
      color: Colors.yellow,
      onPressed: () {},
    );
  }
}

class WidgetE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('E'),
      color: Colors.red,
      onPressed: () {
        // mediator.removeModelOne();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PageTwo();
        }));
      },
    );
  }
}
*/
