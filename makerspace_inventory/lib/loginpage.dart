import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'shared/myconfig.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _emailforgotEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  late double screenHeight, screenWidth, formwidth, paddinglarge;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      formwidth = screenWidth;
      paddinglarge = 20;
    } else {
      formwidth = 500.00;
      paddinglarge = 100;
    }
    return Scaffold(
      body: Center(
        child: Container(
            width: formwidth,
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: paddinglarge,
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      "assets/images/mcmc.png",
                      scale: 2.5,
                    )),
                loginForm(context)
              ],
            )),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    return Card(
        elevation: 8,
        margin: const EdgeInsets.all(8),
        child: Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                    style: const TextStyle(),
                    controller: _emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val!.isEmpty || !val.contains("@") || !val.contains(".")
                            ? "Enter a valid email"
                            : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.email),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 1.0),
                      // )
                    )),
                TextFormField(
                    style: const TextStyle(),
                    controller: _passEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (val) =>
                        val!.isEmpty
                            ? "Enter password"
                            : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.password),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 1.0),
                      // ),
                    )),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      //checkColor: Colors.white,
                      //activeColor: Colors.red,
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                          //saveremovepref(value);
                        });
                      },
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: null,
                        child: Text('Remember Me'.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    ElevatedButton(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(5.0)),
                      // minWidth: screenWidth / 3,
                      // height: 50,
                      // elevation: 10,
                      onPressed: _loginUser,
                      // color: Theme.of(context).colorScheme.primary,
                      child: const Text("Login"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ]),
            )));
  }

  void _loginUser() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Login...",
          ),
          content: Row(mainAxisSize: MainAxisSize.min, children: [
            CircularProgressIndicator(),
          ]),
        );
      },
    );
    String email = _emailEditingController.text;
    String pass = _passEditingController.text;
    http.post(Uri.parse("${MyConfig.SERVER}/php/login_user.php"),
        body: {"email": email, "password": pass}).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        if (jsonResponse['status'] == "success") {
          // User user = User.fromJson(jsonResponse['data']);
          // if (user.type == "Doctor") {
          //   Navigator.of(context).pop();
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (content) => DocMainScreen(user: user)));
          // }
          // if (user.type == "Patient") {
          //   Navigator.of(context).pop();
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (content) => PatMainScreen(user: user)));
          // }
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Login failed")));
        }
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Failed")));
      }
    });
  }
}
