import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/config/globle.dart';
import 'package:flutter_provider_mvvm/utils/helpers/helper_interface.dart';


class SnackbarHelper implements Helper {
  const SnackbarHelper._();

  static const SnackbarHelper instance = SnackbarHelper._();

  void success({required title, message}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  void warning({required title, message}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }

  void error({required title, message}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
    );
  }

  void modern({required title, message}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.blueGrey,
      icon: Icons.info,
    );
  }

  void _showSnackBar({
    required String title,
    required String message,
    required IconData icon,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    Color closeIconColor = Colors.white,
  }) {
    SnackBar snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: iconColor),
                ],
              ),
              const SizedBox(width: 5),
              Column(
                children: [
                  Text(title, style: TextStyle(color: textColor)),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: closeIconColor,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 6),
      behavior: SnackBarBehavior.floating,
    );

    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
