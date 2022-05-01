import 'package:validators/validators.dart' as validator;

class TextFieldValidator {
  static String? emptyFieldValidator(String? value) {
    if (value == "" || value == null) {
      return 'This is required field';
    } else {
      return null;
    }
  }

  static String? emailFieldValidator(String? value) {
    if (value == "" || value == null) {
      return 'Email is required';
    } else if (validator.isEmail(value) == false) {
      return 'The email you entered is invalid';
    } else {
      return null;
    }
  }

  static String? passwordFieldValidator(String? value) {
    if (value == "" || value == null) {
      return 'Password is required';
    } else if (validator.isLength(value, 6) == false) {
      return 'Password length should be more than 6';
    } else {
      return null;
    }
  }
}
