import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';
import '../cubit/todo_cubit.dart';
import '../models/todo_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoTitleController = TextEditingController();
    // late bool isEmpty = false;
    return Scaffold(
      backgroundColor: cusBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cusBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/TaskMateIcon.ico"),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "TaskMate",
              style: TextStyle(color: Colors.blue.shade600, fontSize: 25),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              // onChanged: context.read<TodoCubit>().filterTodo,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: cusBlack,
                  size: 20,
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25,
                ),
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: cusGrey),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Today's Task",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoCubit, List<TodoModel>>(
              builder: (context, todos) {
                return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final TodoModel todo = todos[index];
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            IconButton(
                              color: cusBlue,
                              // iconSize: 18,
                              icon: todo.isDone
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.check_box_outline_blank),
                              onPressed: () {
                                context
                                    .read<TodoCubit>()
                                    .completeTodo(todo.createdAt);
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  todo.title
                                  // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                                  // "Lorem Ipsum is simply ",
                                  // textAlign: TextAlign.justify,
                                  ,
                                  style: TextStyle(
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: cusRed,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                iconSize: 18,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read<TodoCubit>()
                                      .removeTodo(todo.createdAt);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoTitleController,
                    decoration: const InputDecoration(
                      hintText: "Add a new task",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cusBlue,
                    minimumSize: const Size(55, 55),
                    elevation: 10,
                  ),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    context
                        .read<TodoCubit>()
                        .addTodo(todoTitleController.text.trim());
                    todoTitleController.clear();
                  },
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
