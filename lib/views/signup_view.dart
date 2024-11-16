import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/core/components/app_button.dart';
import 'package:flutter_provider_mvvm/core/components/app_text_field.dart';
import 'package:flutter_provider_mvvm/core/components/sb.dart';
import 'package:flutter_provider_mvvm/core/extensions/build_context_extension.dart';
import 'package:flutter_provider_mvvm/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final username = _userNameController.text.trim();
      await authProvider.register(username, password, email);
      // Implement the sign-up logic here

      // For example, you can use:
      // await authProvider.signup(_userNameController.text.trim(), email, _passwordController.text.trim());
    }
  }

  getData() {
     final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print("this is data${authProvider.email}");
   
    if (authProvider.email != null && authProvider.email != "") {
      _emailController.text = authProvider.email!;
      setState(() {});
    }
    if (authProvider.name != null && authProvider.name != "") {
      _userNameController.text = authProvider.name!;
      setState(() {});
    }
  }

  _onLogin() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    auth.handleState(Status.LoggedOut);
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
                  AppStrings.welcome,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium?.copyWith(
                    color: context.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SB.h(8),
                Text(
                  AppStrings.signUpDescription,
                  textAlign: TextAlign.center,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SB.h(25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: _userNameController,
                          title: AppStrings.name,
                          hintText: AppStrings.enterName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: _emailController,
                          title: AppStrings.email,
                          hintText: AppStrings.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            // Check if the email is valid
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
                          if (auth.registeredInStatus == Status.Loading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppButton.primary(
                              title: AppStrings.signUp,
                              onPressed: _signup,
                            ),
                          );
                        },
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          if (auth.registeredInStatus == Status.Failure) {
                            return Text(
                              auth.registerErrorMsg,
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          return Container(); // Return empty container if no error
                        },
                      ),
                    ],
                  ),
                ),
                SB.h(context.height * 0.1),
             ],
            ),
          ),
        ),
      ),
    );
  }
}
