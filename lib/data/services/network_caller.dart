import 'dart:convert';
import 'dart:developer';

import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url,
      {bool skipAuthCheck = false, String? token}) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      log(url);
      log(token.toString());
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'token': (token ?? AuthController.token).toString(),
          'content-type': 'application/json'
        },
      );
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['msg'] == 'success') {
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse,
          );
        } else {
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodedResponse,
            errorMessage: decodedResponse['data'] ?? 'Something went wrong',
          );
        }
      } else if (response.statusCode == 401 && !skipAuthCheck) {
        await AuthController.clearAuthData();
        AuthController.goToLogin();
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        responseData: '',
        errorMessage: 'No internet connection',
      );
    }
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      log(url);
      String encodedBody = json.encode(body);
      log('passed token = ${token.toString()}');
      log('saved token = ${AuthController.token}');
      log(encodedBody);
      final Response response = await post(
        Uri.parse(url),
        body: encodedBody,
        headers: {
          'token': (token ?? AuthController.token).toString(),
          'content-type': 'application/json'
        },
      );
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['msg'] == 'success') {
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse,
          );
        } else {
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodedResponse,
            errorMessage: decodedResponse['data'] ?? 'Something went wrong',
          );
        }
      } else if (response.statusCode == 401) {
        await AuthController.clearAuthData();
        AuthController.goToLogin();
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        responseData: '',
        errorMessage: 'No internet connection',
      );
    }
  }
}
