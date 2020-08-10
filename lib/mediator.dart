import 'model_one.dart';

final Mediator mediator = Mediator();

class Mediator {
  static Mediator _singleton;
  factory Mediator() {
    return (_singleton == null) ? Mediator._() : _singleton;
  }
  Mediator._() {
    print('Mediator._ constructor');
  }

  // add models to mediate here
  ModelOne modelOne;

  void addModelOne(ModelOne value) {
    modelOne = value;
  }

  void removeModelOne() {
    modelOne = null;
  }

  void getModelId(dynamic modelInstance) {
    print('Mediator.getModelId(): ${modelInstance.hashCode}');
  }
}
