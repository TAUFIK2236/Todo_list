import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/HomePage.dart';
import 'package:todo_app/api/apiService.dart';
import 'package:todo_app/Pages/ModelClasses/LoginModel.dart' as getLoginFeed;

final IdApiService = IdApiCall();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _LoginUserName = TextEditingController();
  TextEditingController _LoginPassword = TextEditingController();
  @override
  void dispose() {
    _LoginUserName.dispose();
    _LoginPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Name",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _LoginUserName,
              //l  obscureText: true,
              decoration: InputDecoration(
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
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _LoginPassword,
              // obscureText: true,
              decoration: InputDecoration(
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
              onPressed: () {
                //  GetLogInData(_LoginUserName.text, _LoginPassword.text);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(
                          userName: _LoginUserName.text,
                          password: _LoginPassword.text,
                        )));
                // getHttp(_LoginUserName.text,_LoginPassword.text,);
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.indigo,
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have any ID yet?",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
