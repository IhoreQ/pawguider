abstract class Validator {

  static bool _isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isDogNameValid(String? name) {
    if (_isNullOrEmpty(name)) {
      return false;
    }
    final nameRegExp = RegExp(r'^[A-Za-z]*$');
    return nameRegExp.hasMatch(name!) && name.length > 2 && name.length < 13;
  }

  static bool isAgeValid(String? age) {
    if (_isNullOrEmpty(age)) {
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
    final emailRegExp = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(email!);
  }

  static bool isPasswordValid(String? password) {
    final passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    return passwordRegExp.hasMatch(password!);
  }

  static bool arePasswordsEqual(String? password, String? newPassword) {
    return password == newPassword;
  }

  static bool isPhoneNumberValid(String? phoneNumber) {
    if (_isNullOrEmpty(phoneNumber)) {
      return true;
    }
    final phoneNumberRegExp = RegExp(r"^[+]*[(]?[0-9]{1,4}[)]?[-\s./0-9]*$");
    return phoneNumberRegExp.hasMatch(phoneNumber!);
  }
}