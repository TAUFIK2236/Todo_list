import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/login_in_page.dart';
import 'package:todo_app/api/apiService.dart';
import 'package:todo_app/Pages/ModelClasses/Get_Todo_List.dart' as GetTodo;

final idApiService = IdApiCall();

class note_create extends StatefulWidget {
  const note_create(
      {Key? key, required this.todos, required this.index})
      : super(key: key);


  final  List<GetTodo.Todo>? todos;
  final int? index;

  @override
  State<note_create> createState() => _note_createState();
}

class _note_createState extends State<note_create> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool isEdit = false;
  bool isLoading = false;


  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }





  postTodo(String title, String description,) async {
    setState(() {
      isLoading =true;});
   try{

     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? token = prefs.getString('LogInToken');

     await idApiService.httpPost(
     'https://todoe-production.up.railway.app/todo',
     {
       "title": title,
       "description": description,
       "isDone": false,
     },
     {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
   );
   Navigator.pop(context);
   }catch(e){

     DioError error = e as DioError;
     showAlertDialog(context,error.response?.data["message"],);
   }
    setState(() {
      isLoading = false;
    });

  }

  updateTodo(String? id, String title, String description) async {


    setState(() {
      isLoading =true;
    });
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('LogInToken');
      await idApiService.httpUpdate(
        'https://todoe-production.up.railway.app/todo/$id',
        {
          "title": title,
          "description": description,
          "isDone": false,
        },
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},

      );
      Navigator.pop(context);
    }catch(e){
      DioError error = e as DioError;
      showAlertDialog(context,error.response?.data["message"],);
    }

    setState(() {
      isLoading = false;
    });


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
        title: const Text("Todo Note"),
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
                    helperStyle: const TextStyle(color: Colors.grey),
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
                    helperStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              MaterialButton(
                onPressed: () {
                  if (widget.todos != null) {
                    updateTodo(
                      widget.todos![widget.index!].id,
                      titleController.text,
                      descriptionController.text,

                    );
                  } else {
                    postTodo(titleController.text, descriptionController.text,);
                  }
                },
                color: Colors.blue,
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
