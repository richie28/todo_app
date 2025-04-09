import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/controllers/todo_controller.dart';


class HomeScreenView extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());
  final TextEditingController taskController = TextEditingController();

  final Color primaryColor = const Color(0xFF6C63FF);
  final Color bgColor = const Color(0xFFF8F9FD);
  final Color cardColor = Colors.white;
  final Color doneColor = Colors.green;

  HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Tasks",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: "Add a task",
                      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.2.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5.w,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),

                ),
                SizedBox(width: 10.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    if (taskController.text
                        .trim()
                        .isNotEmpty) {
                      controller.addTodo(taskController.text.trim());
                      Fluttertoast.showToast(
                        msg: "Task added!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                      taskController.clear();
                      FocusScope.of(context).unfocus();
                    }else{
                      Fluttertoast.showToast(
                        msg: "Task can not be empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                    }
                  },
                  child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.todos.isEmpty) {
                return Center(
                  child: Text(
                    "No tasks yet 😌",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return Obx(() {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todos[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isDone ? Colors.grey : Colors.black87,
                          ),
                        ),
                        leading: Checkbox(
                          value: todo.isDone,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            controller.toggleTodoStatus(index);
                            Fluttertoast.showToast(
                              msg:  value! ? 'Task Completed 🎉' : 'Marked Incomplete',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              fontSize: 16.sp,
                            );

                          },
                        ),
                      ),

                    );
                  },
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}
