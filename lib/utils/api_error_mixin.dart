import 'package:amster_app/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_exception.dart';

mixin ApiErrorMixin on GetxController {
  RxBool isErrorState = false.obs;
  ApiException? apiException;
  Function()? onRetry;

  setErrorState(Object? error, {Function()? onRetry}) {
    if (error is ApiException) {
      isErrorState(true);
      apiException = error;
      this.onRetry = onRetry;
    }
  }

  clearErrorState() {
    isErrorState(false);
    apiException = null;
  }

  Widget getErrorView() {
    return ErrorView(
      apiException!,
      onRetry: onRetry,
    );
  }
}
