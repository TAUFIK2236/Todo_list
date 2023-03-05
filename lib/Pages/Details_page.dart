import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class Details extends StatefulWidget {
  const Details(
      {Key? key,
        required this.titleD,
        required this.descripD,
        required this.createdAtD,
        required this.updatedAtD,
      })
      : super(key: key);
  final String titleD;
  final String descripD;
  final String createdAtD;
  final String updatedAtD;


  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              widget.titleD,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 2.h,
            ),

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    width: 90.w,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(widget.descripD,  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp),),
                ],
              ),
            ),

            SizedBox(
              height: 1.h,),
            Column(
              children: [
                Text("Create Time : ${widget.createdAtD}"),
                Text("Updated Time : ${widget.updatedAtD}"),
              ],
            ),

            SizedBox(
              height: 1.h,),
            InkWell(
              onTap:(){
                Navigator.pop(context);
              },
              child: Container(
                height: 5.h,
                width: 10.h,
                color: Colors.black,
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,),


          ],
        ),
      ),
    );
  }
}