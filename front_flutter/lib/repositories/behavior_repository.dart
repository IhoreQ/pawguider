import '../models/dog/behavior.dart';

abstract class BehaviorRepository {
  // TODO dodać funkcję pobierającą zachowania z bazy

  static List<Behavior> getAllBehaviors() {
    const List<String> behaviorsNames = [
      'Friendly',
      'Aggressive',
      'Social',
      'Shy/fearful',
      'Energetic',
      'Calm',
      'Loyal',
      'Obedient',
      'Disobedient',
      'Independent',
      'Dominant',
      'Curious',
      'Confident',
      'Caring',
    ];

    List<Behavior> behaviorsList = [];

    for (int i = 0; i < behaviorsNames.length; i++) {
      behaviorsList.add(Behavior(i + 1, behaviorsNames[i]));
    }

    return behaviorsList;

  }
}