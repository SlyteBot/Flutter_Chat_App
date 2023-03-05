import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';

class ForgotYourPasswordPage extends StatefulWidget {
  const ForgotYourPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotYourPasswordPage> createState() => _ForgotYourPasswordPageState();
}

class _ForgotYourPasswordPageState extends State<ForgotYourPasswordPage> {
  String email = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(55.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Please enter your email!",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: textFormDecoration.copyWith(
                      labelText: "Email:",
                      prefix: const Icon(Icons.email),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)
                          ? null
                          : "Please enter a valid email!";
                    },
                    onSaved: (newValue) {
                      setState(() {
                        email = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Material(
                    child: MaterialButton(
                      onPressed: () {
                        resetPasswordFunction();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        "Send Link!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPasswordFunction() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      AuthService authService = AuthService();
      await authService.forgotPasswordEmail(email).then((value) {
        if (value == true) {
          showSnackbar(context, Colors.green, "Reset password link sent!");
        } else {
          showSnackbar(context, Colors.red, value);
        }
      });
    }
  }
}
