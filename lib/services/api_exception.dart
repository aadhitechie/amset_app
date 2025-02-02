import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiException implements Exception {
  final String? title;
  final String message;
  final IconData icon;
  const ApiException(this.message,
      {this.title = 'Error', this.icon = Icons.error});

  static const ApiException default_ =
      ApiException('Something went wrong, Please try again.');

  static const NetworkException network = NetworkException();

  static const ApiException serverError =
      ApiException('Server Error', title: null, icon: Icons.public);

  static ApiException handle(e) {
    if (e is DioException) {
      if (e.response == null) {
        return network;
      }
      if (e.message?.startsWith('SocketException') ?? false) {
        return network;
      }
      if (e.response?.statusCode != null &&
          e.response!.statusCode! >= 500 &&
          e.response!.statusCode! < 600) {
        return serverError;
      }
      if ((e.response?.data is Map && e.response!.data['message'] != null)) {
        return ApiException(e.response!.data['message']);
      }
      log(e.response!.data!.toString());
    }
    return default_;
  }

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  const NetworkException()
      : super('check your internet connection and try again.',
            title: 'Network error !', icon: Icons.signal_wifi_4_bar_sharp);
}
