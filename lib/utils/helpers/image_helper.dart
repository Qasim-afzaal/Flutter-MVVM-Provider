import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/utils/helpers/helper_interface.dart';

class ImageHelper implements Helper {
  const ImageHelper._();
  static const ImageHelper instance = ImageHelper._();

  String randomMockImageString() {
    Random random = Random();
    int randomNumber = random.nextInt(16 - 1) + 1;
    return 'assets/images/mock_listings/listing-$randomNumber.png';
  }

  
}
