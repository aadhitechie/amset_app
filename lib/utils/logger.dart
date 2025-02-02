import 'dart:developer' as dev;

import 'package:get/get.dart';

mixin LoggerMixin {
  String get tag;
  final RxString _subTag = ''.obs;
  log(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message,
        name: '$tag$_subTag', error: error, stackTrace: stackTrace);
  }

  setSubTag(String suTag) {
    _subTag.value = ':$suTag';
  }
}
