import 'package:flutter/foundation.dart';

class ModelOne extends ChangeNotifier {
  static ModelOne _singleton;
  factory ModelOne() {
    print('ModelOne factory constructor');
    return (_singleton == null) ? ModelOne._() : _singleton;
  }
  ModelOne._() {
    print('ModelOne._ constructor');
  }

  List<Person> people = [];

  void addPerson(String firstname, String surname, int age) {
    print('addPerson');
    people.add(Person(firstname, surname, age));
  }

  int getSingletonHashCode() => _singleton.hashCode;
}

class Person {
  Person(this.firstname, this.surname, this.age);
  final String firstname;
  final String surname;
  final int age;
}
