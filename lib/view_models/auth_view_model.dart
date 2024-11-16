import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/data/network/network_api_service.dart';
import 'package:flutter_provider_mvvm/model/user_Data_model.dart';
import 'package:flutter_provider_mvvm/repository/auth_repository.dart';
import 'package:flutter_provider_mvvm/utils/shared_preference/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedInHome,
  LoggedInAdmin,
  Registered,
  Authenticating,
  profileScreenloading,
  LoggedOut,
  Failure,
  Loading,
  Loaded,
  SplashPage
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.Authenticating;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  SharedPref _sharedPref = SharedPref();
  AuthRepoSitory _authRepo = AuthRepoSitory();

  String? _name;
  String? get name => _name;

  String? _authProbvider;
  String? get authProbvider => _authProbvider;

  String? _email;
  String? get email => _email;

  String _authTokken = "";
  String get authTokken => _authTokken;

  UserDataModel? _user;
  UserDataModel? get user => _user;

  late String _loginErrorMsg;
  String get loginErrorMsg => _loginErrorMsg;

  late String _registerErrorMsg;
  String get registerErrorMsg => _registerErrorMsg;

  handleState(Status state) {
    _loggedInStatus = state;
    notifyListeners();
  }

  Future<bool> register(String username, password, email) async {
    _registeredInStatus = Status.Loading;
    notifyListeners();

    Map<String, dynamic> jsonData = {
      "name": username,
      "password": password,
      "email": email,
      "auth_provider": _authProbvider ?? "",
      "profile_image_url": ""
    };

    try {
      final response = await _authRepo.register(jsonData);

      if (response['success'] != true) {
        _registeredInStatus = Status.Failure;
        _registerErrorMsg = response['message'];
        notifyListeners();
        return false;
      } else {
        _sharedPref.save("authUser", response);
        _registeredInStatus = Status.Registered;
        _loggedInStatus = Status.LoggedInHome;
        _authTokken = response["data"]["access_token"];
        _user = UserDataModel.fromJson(response);
        notifyListeners();
        return true;
      }
    } catch (e) {
      _registeredInStatus = Status.Failure;
      _registerErrorMsg = "An error occurred during registration: $e";
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password, String authProvider) async {
    _loggedInStatus = Status.Loading;
    notifyListeners();

    Map<String, dynamic> jsonData = {
      "email": email,
      "password": password,
      "auth_provider": _authProbvider ?? ""
    };
    _email = email;

    try {
      final response = await _authRepo.login(jsonData);

      if (response['success'] != true) {
        _loggedInStatus = Status.Failure;
        _loginErrorMsg = response['message'];
        notifyListeners();
        return false;
      } else {
        _sharedPref.save("authUser", response);
        _authTokken = response["data"]["access_token"];
        _user = UserDataModel.fromJson(response);

        _loggedInStatus = response["data"]["email"] == "tradelinkadmin@gmail.com"
            ? Status.LoggedInAdmin
            : Status.LoggedInHome;

        notifyListeners();
        return true;
      }
    } catch (e) {
      _loggedInStatus = Status.Failure;
      _loginErrorMsg = "An error occurred during login: $e";
      notifyListeners();
      return false;
    }
  }

  logout() {
    _sharedPref.remove("authUser");
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();
  }

  isUserLogedIn() async {
    final authUser = await _sharedPref.read("authUser");

    if (authUser == null) {
      _loggedInStatus = Status.NotLoggedIn;
    } else {
      final decodedAuthUser = jsonDecode(authUser);
      _loggedInStatus = decodedAuthUser["data"]["email"] == "tradelinkadmin@gmail.com"
          ? Status.LoggedInAdmin
          : Status.LoggedInHome;

      _user = UserDataModel.fromJson(decodedAuthUser);
      _authTokken = _user!.data.accessToken!;
    }
    notifyListeners();
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
