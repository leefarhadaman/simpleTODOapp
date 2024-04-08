import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'common.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, String>> tasks = [];

  @override
  Widget build(BuildContext context) {
    Common common = Common(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffa6d0ef),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: Colors.black12,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: common.getMediaWidth() * 0.05,
                vertical: common.getMediaHeight() * 0.02,
              ),
              width: double.infinity,
              height: common.getMediaHeight() * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "nice",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "FARHAD ALI",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "primary",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "12 : 00 AM",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "nices",
                            ),
                          ),
                          Text(
                            "08 Apr 2024",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "nices",
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            _buildDisplayTODO(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addTask,
        label: Text(
          'Add new task',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "primary",
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildDisplayTODO() {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return _buildSlidableTask(tasks[index]);
        },
      ),
    );
  }

  Widget _buildSlidableTask(Map<String, String> task) {
    bool isCompleted = false; // assuming initially task is not completed

    return Slidable(
      key: Key(task['title']!),
      child: _buildTaskDisplayContainer(task),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            flex: 2,
            backgroundColor: Color(0xFFfc1100),
            borderRadius: BorderRadius.circular(10),
            foregroundColor: Colors.white,
            label: 'Delete',
            icon:  Icons.delete,
            onPressed: (BuildContext context) { setState(() {
              tasks.remove(task);
            }); },
          ),
        ],
      ),
    );
  }


  Widget _buildTaskDisplayContainer(Map<String, String> task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColor.pendingGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                task['title']!,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                task['description']!,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                "12:00 AM",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Project Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add({'title': title, 'description': description});
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
