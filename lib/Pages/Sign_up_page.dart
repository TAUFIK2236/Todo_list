import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // void initState() {
  //   getHttp();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Insert Your Name",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              //obscureText: true,
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
              height: 1.h,
            ),
            Text(
              "Insert User Name",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              //obscureText: true,
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
              height: 1.h,
            ),
            Text(
              "Insert a Password",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              //obscureText: true,
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
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}