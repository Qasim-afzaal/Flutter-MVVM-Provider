import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/core/components/app_button.dart';
import 'package:flutter_provider_mvvm/core/components/app_text_field.dart';
import 'package:flutter_provider_mvvm/core/components/sb.dart';
import 'package:flutter_provider_mvvm/core/constants/app_strings.dart';
import 'package:flutter_provider_mvvm/core/extensions/build_context_extension.dart';
import 'package:flutter_provider_mvvm/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await authProvider.login(email, password,"");

      // if (!authProvider.isRegistered) {
      //   // Show an error message if login fails
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(authProvider.registerErrorMsg)),
      //   );
      // }
    }
  }

  void _sigUpScreen() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    auth.handleState(Status.Registered);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  AppStrings.welcomeBack,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium?.copyWith(
                    color: context.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SB.h(8),
                Text(
                  AppStrings.loginDescription,
                  textAlign: TextAlign.center,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SB.h(35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: _emailController,
                          title: AppStrings.email,
                          hintText: AppStrings.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: _passwordController,
                          title: AppStrings.password,
                          hintText: AppStrings.enterPassword,
                          textInputAction: TextInputAction.done,
                          isPasswordField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SB.h(15),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          if (auth.loggedInStatus == Status.Loading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppButton.primary(
                              title: AppStrings.login,
                              onPressed: _login,
                            ),
                          );
                        },
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          if (auth.loggedInStatus == Status.Failure) {
                            return Text(
                              auth.loginErrorMsg,
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          return Container(); // Return empty container if no error
                        },
                      ),
                    ],
                  ),
                ),
           ],
            ),
          ),
        ),
      ),
    );
  }
}
