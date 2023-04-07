import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';
import 'package:flutter_project_chat_app/pages/home_page.dart';
import 'package:flutter_project_chat_app/services/auth_service.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = "";
  String password = "";
  String email = "";

  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor),
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
                          "Register",
                          style: TextStyle(fontSize: 45),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              userName = newValue!;
                            });
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: "Username:",
                            prefix: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (RegExp(r"^[a-zA-Z0-9]{3,12}$")
                                    .hasMatch(value!) ==
                                true) {
                              return null;
                            } else {
                              return "Username not valid!";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                          controller: passwordController,
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
                          validator: (value) {
                            if (passwordValid(value!) == true) {
                              return null;
                            } else {
                              return "Password is not valid!";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textFormDecoration.copyWith(
                            labelText: "Re-enter Password:",
                            prefix: const Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (passwordController.text == value) {
                              return null;
                            } else {
                              return "Password is not the same!";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Material(
                          child: MaterialButton(
                            onPressed: () {
                              registerFunction();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            color: Theme.of(context).primaryColor,
                            child: const Text(
                              "Register",
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

  void registerFunction() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
      });

      form.save();
      passwordController.text = "";

      await context
          .read<UserProvider>()
          .register(userName, email, password)
          .then((value) {
        if (value == null) {
          String uid = context.read<UserProvider>().getUID();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (builder) => HomePage(
                    uid: uid,
                  )));
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
