import 'package:flutter_provider_mvvm/data/network/network_api_service.dart';

class AuthRepoSitory {
  Future<dynamic> register(dynamic jsonData) async {
    try {
      final response =
          await NetworkApiServices().postApiResponse("/signUp", jsonData, null);

      return response;
    } catch (e) {
      throw e;
    }
  }

    Future<dynamic> login(dynamic jsonData) async {
    try {
      final response =
          await NetworkApiServices().postApiResponse("/login", jsonData, null);

      return response;
    } catch (e) {
      throw e;
    }
  }
}
