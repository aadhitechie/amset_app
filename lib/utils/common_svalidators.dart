import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



class CommonValidators {
  CommonValidators._();

  static dio.CancelToken? _cancelToken;

  static SValidatorStatus requiredValidator(String val) {
    if (val.isEmpty) {
      return (ValidateStatus.error, 'Required');
    }
    return null;
  }

  static Future<SValidatorStatus> signupEmailValidator(String val) async {
    if (val.isEmpty) {
      return (ValidateStatus.error, 'Required');
    }
    if (!val.isEmail) {
      return (ValidateStatus.error, 'Invalid email');
    }
    // var resp = await ApiServices()
    //     .postMethod(ApiEndpoints.userExist, data: {"email": val});

    // if (resp.data['value'] == true) {
    //   return (ValidateStatus.error, 'Email is already taken');
    // }

    return (ValidateStatus.valid, 'Valid email');
  }

  static Future<SValidatorStatus> emailValidator(String val) async {
    if (val.isEmpty) {
      return (ValidateStatus.error, 'Required');
    }
    if (!val.isEmail) {
      return (ValidateStatus.error, 'Invalid email');
    }

    return (ValidateStatus.valid, 'Valid email');
  }

  static SValidatorStatus passwordValidator(String val) {
    if (val.isEmpty) {
      return (ValidateStatus.error, 'Required');
    }
    if (val.contains(RegExp(r'[0-9]'))) {
      ValidateStatus.none;
    } else {
      return (ValidateStatus.error, 'Must contain 1 number');
    }

    if (val.contains(RegExp(r'[A-Z]'))) {
      ValidateStatus.none;
    } else {
      return (ValidateStatus.error, 'Must contain 1 capital letter');
    }
    if (val.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>_]'))) {
      ValidateStatus.none;
    } else {
      return (ValidateStatus.error, 'Must contain 1 special character');
    }

    if (val.length >= 8) {
      return (ValidateStatus.valid, 'Strong password');
    } else {
      return (ValidateStatus.error, 'Must contain 8 characters');
    }
  }

  static SValidatorStatus confirmPasswordValidator(
      String val, TextEditingController passwordController) {
    if (val.isEmpty) {
      return null;
    }
    if (val != passwordController.text) {
      return (ValidateStatus.error, "Passwords doesn't match");
    } else if (val == passwordController.text) {
      return (ValidateStatus.valid, "Passwords match");
    }
    return null;
  }

  static Future<SValidatorStatus> usernameValidator(String val) async {
    RegExp useNameRegex = RegExp(r'^[a-z0-9_]{3,}$');

    _cancelToken?.cancel();

    if (val.isEmpty) {
      return (ValidateStatus.error, 'Required');
    }

    if (val.isNotEmpty && val.length < 3) {
      return (ValidateStatus.error, 'Username must be at least 3 characters');
    }

    if (!useNameRegex.hasMatch(val)) {
      return (ValidateStatus.error, 'Invalid username');
    } else {
      _cancelToken = dio.CancelToken();

      try {
        final resp = await ApiServices().postMethod(ApiEndpoints.userExist,
            data: {"username": val}, cancelToken: _cancelToken);

        if (resp.data['value'] == true) {
          return (ValidateStatus.error, 'Unavailable');
        } else {
          return (ValidateStatus.valid, 'Username available');
        }
      } catch (e) {
        if (e is dio.DioException && dio.CancelToken.isCancel(e)) {
          return (ValidateStatus.none, '');
        } else {
          return (ValidateStatus.none, '');
        }
      }
    }
  }
}

//-----------------------InputFormatter -------------------------------
//------Use this to change uppercase value to lower case value-----
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
