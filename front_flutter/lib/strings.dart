abstract class AppStrings {
  static const registerSuccessTitle = "Registered successfully";
  static const registerSuccessBody = "You can login to the application now.";
  static const dogsLimitTitle = "Limit reached";
  static const dogsLimitBody = "You can select only 3 dogs to walk with.";
  static const updated = "Updated";
  static const passwordChanged = "Your password has been changed.";
}

abstract class ErrorStrings {
  static const userAlreadyExists = "User with this email already exists";
  static const timeout = "Request timed out\nTry again later";
  static const defaultError = "An unexpected error has occurred\nPlease try again";
  static const checkInternetConnection = "Please check your internet connection or try again later";
  static const notAuthenticated = "User is not authenticated!\nPlease sign in again.";
  static const localisationNotAllowed = "Localisation is not allowed!\nPlease enable it for the app to work properly";
}