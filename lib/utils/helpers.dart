
import 'package:flutter_provider_mvvm/utils/helpers/image_helper.dart';
import 'package:flutter_provider_mvvm/utils/helpers/snackbar_helper.dart';
import 'package:flutter_provider_mvvm/utils/helpers/url_helper.dart';

class Helpers {
  const Helpers._();

  static const Helpers instance = Helpers._();

  static ImageHelper get images => ImageHelper.instance;
  static SnackbarHelper get snackbars => SnackbarHelper.instance;
  static UrlHelper get url => UrlHelper.instance;
}
