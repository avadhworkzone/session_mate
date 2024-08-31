<<<<<<< Updated upstream
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_string.dart';

class RegularExpressionUtils {
  static String alphabetPattern = "[a-zA-Z]";
  static String text = "^[a-zA-Z ]*\$";
  static String alphabetSpacePattern = "[a-zA-Z ]";
  static String emailPattern = r"[a-zA-Z0-9$_@.-]";
  static String digitsPattern = r"[0-9]";
  static String address = r"^[a-zA-Z0-9\s,-]+$";
  static String passwordPattern = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String therapyCenterCode = r"[a-zA-Z0-9]";

  /// capitalCase is used for one capital character is requiter in string
  var capitalCase = RegExp(r'[A-Z]');

  /// smallCase is used for one small character is requiter in string
  var smallCase = RegExp(r'[a-z]');

  /// atLeastOneNumber is used for one number is requiter in string
  var atLeastOneNumber = RegExp(r'[0-9]');

  /// specialCharacters is used for one special characters is requiter in string
  var specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static var isValidEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator =
      RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,12}');

  /// minimum password validation
  static var passwordMinLength = 7;

  var whiteSpace = new RegExp("\\s+");
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText.tr,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class TextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text,
      selection: newValue.selection,
    );
  }
}

/// VALIDATION METHOD
class ValidationMethod {
  /// EMAIL VALIDATION METHOD
  static String? validateEmail(value) {
    bool regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+'
            r'(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
            r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.'
            r'[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
    if (value == null) {
      return AppStrings.emailIsRequired;
    } else if (regex == false) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  static String? validateName(value) {
    bool regex =
        RegExp(RegularExpressionUtils.alphabetSpacePattern).hasMatch(value);
    if (value == null) {
      return AppStrings.isRequired.tr;
    } else if (!regex) {
      return AppStrings.isRequired.tr;
    }
    return null;
  }

  static String? validateDate(value) {
    if (value == null || value.isEmpty) {
      return AppStrings.selectDate;
    }
    return null;
  }
  //
  // static String? validatePhone(value) {
  //   if (value == null || value.isEmpty) {
  //     return AppStrings.isRequired.tr;
  //   }
  //   return null;
  // }

  // static String? validateOtp(value) {
  //   if (value.isEmpty || value == null) {
  //     return AppStrings.pleaseEnterOtp.tr;
  //   }
  //   if (value.length < 4) {
  //     return AppStrings.pleaseEnterValidOtp.tr;
  //   }
  //   return null;
  // }

  static String? validateAddress(value) {
    bool regex = RegExp(RegularExpressionUtils.address).hasMatch(value);
    if (value == null) {
      return AppStrings.isRequired.tr;
    } else if (!regex) {
      return AppStrings.isRequired.tr;
    }
    return null;
  }
}
=======
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_string.dart';

class RegularExpressionUtils {
  static String alphabetPattern = "[a-zA-Z]";
  static String text = "^[a-zA-Z ]*\$";
  static String mapScreenField = r".*";
  static String alphabetSpacePattern = "[a-zA-Z ]";
  static String emailPattern = r"[a-zA-Z0-9$_@.-]";
  static String digitsPattern = r"[0-9]";
  static String address = r"^[a-zA-Z0-9\s,-]+$";
  static String passwordPattern = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String therapyCenterCode = r"[a-zA-Z0-9]";

  /// capitalCase is used for one capital character is requiter in string
  var capitalCase = RegExp(r'[A-Z]');

  /// smallCase is used for one small character is requiter in string
  var smallCase = RegExp(r'[a-z]');

  /// atLeastOneNumber is used for one number is requiter in string
  var atLeastOneNumber = RegExp(r'[0-9]');

  /// specialCharacters is used for one special characters is requiter in string
  var specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static var isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,12}');

  /// minimum password validation
  static var passwordMinLength = 7;

  var whiteSpace = new RegExp("\\s+");
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText.tr,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class TextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text,
      selection: newValue.selection,
    );
  }
}

/// VALIDATION METHOD
class ValidationMethod {
  /// EMAIL VALIDATION METHOD
  static String? validateEmail(value) {
    bool regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+'
            r'(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
            r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.'
            r'[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
    if (value == null) {
      return AppStrings.emailIsRequired;
    } else if (regex == false) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  static String? validateName(value) {
    bool regex = RegExp(RegularExpressionUtils.alphabetSpacePattern).hasMatch(value);
    if (value == null) {
      return AppStrings.isRequired.tr;
    } else if (!regex) {
      return AppStrings.isRequired.tr;
    }
    return null;
  }

  static String? validateDate(value) {
    if (value == null || value.isEmpty) {
      return AppStrings.selectDate;
    }
    return null;
  }
  //
  // static String? validatePhone(value) {
  //   if (value == null || value.isEmpty) {
  //     return AppStrings.isRequired.tr;
  //   }
  //   return null;
  // }

  // static String? validateOtp(value) {
  //   if (value.isEmpty || value == null) {
  //     return AppStrings.pleaseEnterOtp.tr;
  //   }
  //   if (value.length < 4) {
  //     return AppStrings.pleaseEnterValidOtp.tr;
  //   }
  //   return null;
  // }

  static String? validateAddress(value) {
    bool regex = RegExp(RegularExpressionUtils.address).hasMatch(value);
    if (value == null) {
      return AppStrings.isRequired.tr;
    } else if (!regex) {
      return AppStrings.isRequired.tr;
    }
    return null;
  }

  static String? defaultValidation(value) {
    if (value == null || value.toString().isEmpty) {
      return AppStrings.isRequired.tr;
    } else {
      return null;
    }
  }
}
>>>>>>> Stashed changes
