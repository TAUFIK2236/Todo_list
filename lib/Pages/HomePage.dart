import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/Details_page.dart';
import 'package:todo_app/Pages/login_in_page.dart';
import 'package:todo_app/Pages/Todo_create_page.dart';
import 'package:todo_app/api/apiService.dart';
import 'package:todo_app/Pages/ModelClasses/Get_Todo_List.dart' as getodo;

final apiService = IdApiCall();

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  late List<getodo.Todo> todos;
  Future getIdData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString('LogInToken');

    setState(() {
      isLoading = true;
    });
    try {
      var responseList = await apiService.httpGet(
        'https://todoe-production.up.railway.app/todo',
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $Token'},
      );
      todos = getodo.todoFromJson(jsonEncode(responseList));
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

  getIdtoDelete(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('LogInToken');
    await apiService.httpDelete(
      'https://todoe-production.up.railway.app/todo/$id',
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
  }

  @override
  void initState() {
    getIdData();
    super.initState();
  }

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('LogInToken');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
            // ListTile(
            //   title: const Text('Item 2'),
            //   onTap: () {
            //     // Update the state of the app.
            //     // ...
            //   },
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Center(child: Text("Todo List ")),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: todos.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(.5.h, 1.h, .5.h, 0.5.h),
                          child: Card(
                            elevation: 4.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 0.7.h,
                                ),
                                Text(
                                  "${todos[index].title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                const Divider(
                                  thickness: 5,
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    note_create(
                                                      index: index,
                                                      todos: todos,
                                                    )));
                                        getIdData();
                                      },
                                      child: const Text(
                                        "Update",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        getIdtoDelete(
                                            todos[index].id.toString());
                                        setState(() {
                                          getIdData();
                                        });
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: .3.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      "Done Status :",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                    Checkbox(
                                        value: todos[index].isDone,
                                        onChanged: (newBool) async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? Token =
                                              prefs.getString('LogInToken');
                                          await apiService.httpUpdate(
                                            'https://todoe-production.up.railway.app/todo/${todos[index].id}',
                                            {
                                              "title": "${todos[index].title}",
                                              "description":
                                                  "${todos[index].description}",
                                              "isDone": newBool,
                                            },
                                            {
                                              'Content-Type':
                                                  'application/json',
                                              'Authorization': 'Bearer $Token'
                                            },
                                          );

                                          getIdData();

                                          //  isChecked = newBool;
                                        })
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Details(
                                                  titleD: todos[index]
                                                      .title
                                                      .toString(),
                                                  descripD: todos[index]
                                                      .description
                                                      .toString(),
                                                  createdAtD: todos[index]
                                                      .createdAt
                                                      .toString(),
                                                  updatedAtD: todos[index]
                                                      .updatedAt
                                                      .toString(),
                                                )));
                                  },
                                  child: Container(
                                    height: 4.h,
                                    width: 100.w,
                                    color: Colors.grey,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 1.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Details & More...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // MaterialButton(onPressed: (){},child:,,),
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const note_create(
                    index: null,
                    todos: null,
                  )));
          getIdData();
        },
        label: const Text("Note"),
        tooltip: "Create a new Note!!",
        icon: const Icon(Icons.add),
      ),
    );
  }
}
