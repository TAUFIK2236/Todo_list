import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/Details_page.dart';
import 'package:todo_app/Pages/Todo_create_page.dart';
import 'package:todo_app/api/apiService.dart';
import 'package:todo_app/Pages/ModelClasses/Get_Todo_List.dart' as GetTodo;
import 'package:todo_app/Pages/ModelClasses/LoginModel.dart' as getLoginFeed;

final IdApiService = IdApiCall();

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.userName,
    required this.password,
  }) : super(key: key);

  final String userName;
  final String password;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  getLoginFeed.LoginUser? UserCradential;

  GetLogInData(String name, String password) async {
    var responseLog = await IdApiService.httpPost(
      'https://todoe-production.up.railway.app/user/login',
      {"username": "$name", "password": "$password"},
      {'Content-Type': 'application/json'},
    );
    final info = getLoginFeed.loginUserFromJson(jsonEncode(responseLog));
    UserCradential = info;
    print(UserCradential?.jwTtoken);
    isLoading = false;
    GetIdData(UserCradential!.jwTtoken!);
    setState(() {});
  }

  late List<GetTodo.Todo> Todos;
  Future GetIdData(String token) async {
    var responseList = await IdApiService.httpGet(
      'https://todoe-production.up.railway.app/todo',
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
    Todos = GetTodo.todoFromJson(jsonEncode(responseList));

  }

  GetIdtoDelete(String Id) {
    var responseDel = IdApiService.httpDelete(
      'https://todoe-production.up.railway.app/todo/$Id',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${UserCradential?.jwTtoken}'
      },
    );
  }

  @override
  void initState() {
    GetLogInData(widget.userName, widget.password);
    super.initState();
  }

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("${UserCradential!.username}'s Todo List ")),
      ),
      body: UserCradential == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: Todos.length,
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
                                  "${Todos[index].title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                Divider(
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
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => Note_create(
                                              index: index,
                                              todos:Todos,
                                              token: UserCradential?.jwTtoken,
                                            )));
                                        },
                                      child: Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        GetIdtoDelete(
                                            Todos[index].id.toString());
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
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
                                        value: Todos[index].isDone,
                                        onChanged: (newBool) {
                                          setState(() {
                                            isChecked = newBool;
                                          });
                                        })
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                                titleD:Todos[index].title.toString(),
                                                descripD: Todos[index].description.toString(),
                                                createdAtD: Todos[index].createdAt.toString(),
                                                updatedAtD: Todos[index].updatedAt.toString(),
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
                                          Icon(
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Note_create(
                     index: null,
                     todos:null,
                    token: UserCradential?.jwTtoken,
                  )));
        },
        label: Text("Note"),
        tooltip: "Create a new Note!!",
        icon: Icon(Icons.add),
      ),
    );
  }
}


