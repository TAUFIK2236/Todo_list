import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/api/apiService.dart';
import 'dart:convert';
import 'package:todo_app/Pages/ModelClasses/Get_Todo_List.dart' as GetTodo;

final IdApiService = IdApiCall();

class Note_create extends StatefulWidget {
  const Note_create(
      {Key? key, required this.token, required this.todos, required this.index})
      : super(key: key);
  final String? token;
  final  List<GetTodo.Todo>? todos;
  final int? index;

  @override
  State<Note_create> createState() => _Note_createState();
}

class _Note_createState extends State<Note_create> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool isEdit = false;
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }




  PostTodo(String title, String description, String token) async {
    await IdApiService.httpPost(
      'https://todoe-production.up.railway.app/todo',
      {
        "title": "${title}",
        "description": "${description}",
        "isDone": false,
      },
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
  }

  UpdateTodo(String? Id, String title, String description, String token) async {
    await IdApiService.httpUpdate(
      'https://todoe-production.up.railway.app/todo/$Id',
      {
        "title": "${title}",
        "description": "${description}",
        "isDone": false,
      },
      {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
  }
  @override
  void initState() {
    if (widget.todos != null){
      isEdit = true;
      final title = widget.todos![widget.index!].title.toString();
      final description = widget.todos![widget.index!].description.toString();
      titleController.text = title  ;
      descriptionController.text = description ;


    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextFormField(
                controller: titleController,
                minLines: 1,
                style: TextStyle(fontSize: 15.sp),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    // hintText: "Title",
                    helperStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Description ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextFormField(
                controller: descriptionController,
                minLines: 4,
                maxLines: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Description will be here...",
                    helperStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              MaterialButton(
                onPressed: () {
                  if (widget.todos != null) {
                    UpdateTodo(
                      widget.todos![widget.index!].id,
                      titleController.text,
                      descriptionController.text,
                      widget.token!,
                    );
                  } else {
                    PostTodo(titleController.text, descriptionController.text, widget.token!);
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
