import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/forgot_your_password_page.dart';
import 'package:flutter_project_chat_app/pages/register_page.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(55.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 45),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          decoration: textFormDecoration.copyWith(
                            labelText: "Email:",
                            prefix: const Icon(Icons.email),
                          ),
                          onSaved: (newValue) {
                            setState(() {
                              email = newValue!;
                            });
                          },
                          validator: (value) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : "Please enter a valid email!";
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textFormDecoration.copyWith(
                            labelText: "Password:",
                            prefix: const Icon(Icons.password),
                          ),
                          onSaved: (newValue) {
                            setState(() {
                              password = newValue!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Material(
                          child: MaterialButton(
                            onPressed: () {
                              loginFunction();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            color: Theme.of(context).primaryColor,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Forgot your password?",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotYourPasswordPage()));
                              },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Register here!",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage()));
                                    }),
                            ],
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

  loginFunction() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      await context.read<UserProvider>().signIn(email, password).then((value) {
        if (value == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (builder) => const HomePage()));
        } else {
          setState(() {
            _isLoading = false;
          });
          showSnackbar(context, Colors.red, value);
        }
      });
    }
  }
}
