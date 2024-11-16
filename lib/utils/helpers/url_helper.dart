
import 'package:flutter_provider_mvvm/config/url_configuration.dart';
import 'package:flutter_provider_mvvm/utils/helpers/helper_interface.dart';


class UrlHelper implements Helper {
  const UrlHelper._();
  static const UrlHelper instance = UrlHelper._();

  String apiUrl({String url = ''}) {
    final String baseUrl = UrlConfiguration.baseURL;
    return '$baseUrl$url';
  }
  

}
