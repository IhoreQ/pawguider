abstract class Validator {

  static bool _basicValidation(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isAgeValid(String? age) {
    if (_basicValidation(age)) {
      return false;
    }
    int value = int.parse(age!);
    return value > 0 && value < 25;
  }
}