import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart' show DioError;
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/HomePage.dart';
import 'package:todo_app/Pages/Sign_up_page.dart';
import 'package:todo_app/api/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Pages/ModelClasses/LoginModel.dart' as getloginfeed;

final apiService = IdApiCall();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController _loginUserName = TextEditingController();
  final TextEditingController _loginPassword = TextEditingController();
  @override
  void dispose() {
    _loginUserName.dispose();
    _loginPassword.dispose();
    super.dispose();
  }

  getloginfeed.LoginUser? userCradential;
  String? userToken;

  addToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('LogInToken', userCradential!.jwTtoken!);
  }

  isAlreadyLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('LogInToken');
    if (token != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  getLogInData(String name, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      var responseLog = await apiService.httpPost(
        'https://todoe-production.up.railway.app/user/login',
        {"username": name, "password": password},
        {'Content-Type': 'application/json'},
      );
      final info = getloginfeed.loginUserFromJson(jsonEncode(responseLog));
      userCradential = info;

      await addToken();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      DioError error = e as DioError;
      showAlertDialog(
        context,
        error.response?.data["message"],
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isAlreadyLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _loginUserName,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Text(
                    "Password",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _loginPassword,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Center(
                      child: MaterialButton(
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      getLogInData(_loginUserName.text, _loginPassword.text);
                    },
                    color: Colors.indigo,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have any ID yet?",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const Sign_up_page()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

showAlertDialog(
  BuildContext context,
  String message,
) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("AlertDialog"),
    content: Text(message),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
