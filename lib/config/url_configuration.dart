import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlConfiguration {
  UrlConfiguration._();

  static final instance = UrlConfiguration._();

  static String baseURL = dotenv.env['BASE_URL'] ?? "";
  static String userPort = dotenv.env['USER_PORT'] ?? "3005/api/";
  static String listingPort = dotenv.env['LISTING_PORT'] ?? "3007/api/";
  static String organizePort = dotenv.env['ORGANIZE_PORT'] ?? "3008/api/";
  static String scrappingPort = dotenv.env['SCRAPPPING_PORT'] ?? "3009/api/";
  static String stripApi = dotenv.env['STRIP_PORT'] ?? "5001/";
}
