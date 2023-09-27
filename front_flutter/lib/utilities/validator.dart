abstract class Validator {

  static bool _basicValidation(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isDogNameValid(String? name) {
    if (_basicValidation(name)) {
      return false;
    }
    final nameRegExp = RegExp(r'^[A-Za-z]*$');
    return nameRegExp.hasMatch(name!) && name.length > 2 && name.length < 13;
  }

  static bool isAgeValid(String? age) {
    if (_basicValidation(age)) {
      return false;
    }
    int value = int.parse(age!);
    return value > 0 && value < 25;
  }

  static bool isNameValid(String? name) {
    final nameRegExp = RegExp(r"^[A-Za-z ,.'-]+$");
    return nameRegExp.hasMatch(name!) && name.length > 2;
  }

  static bool isEmailValid(String? email) {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(email!);
  }

  static bool isPasswordValid(String? password) {
    final passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    return passwordRegExp.hasMatch(password!);
  }
}