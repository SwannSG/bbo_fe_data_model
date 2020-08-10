import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mediator.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('PageTwo build()');
    print('mediator.modelOne.hashCode: ${mediator.modelOne.hashCode}');
    // print(mediator.modelOne.people);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 100,
          height: 600,
          color: Colors.black,
          child: WidgetD(),
        ),
      ),
    );
  }
}

class WidgetD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Back'),
      color: Colors.yellow,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
