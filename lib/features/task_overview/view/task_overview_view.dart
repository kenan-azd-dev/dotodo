import 'package:dotodo/blocs/task/task_bloc.dart';
import 'package:dotodo/features/add_task/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

import '../../widgets/sub_header.dart';

import '../../../data/model/models.dart';

class TaskOverviewView extends StatelessWidget {
  const TaskOverviewView({
    super.key,
    required Task task,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TasksOverviewBloc>().add(
                CompleteTaskEvent(
                  taskId: _task.id,
                  isCompleted: _task.isCompleted,
                ),
              );
        },
        child: Icon(Icons.check_rounded),
        backgroundColor: _task.isCompleted ? Colors.green : null,
      ),
      appBar: AppBar(
        title: Text(_task.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddTaskPage(
                    isEdit: true,
                    task: _task,

                  );
                },
              ));
            },
            icon: Icon(Icons.edit_rounded),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(kScreenMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey, width: 2.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(kSmallScreenMargin),
          child: Table(
            border: TableBorder.symmetric(
              inside: BorderSide(color: Colors.grey, width: 2.0),
              outside: BorderSide.none,
            ),
            children: [
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('Title:'),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader(_task.title),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('Category:'),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('data'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('Due Date:'),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader(
                      _task.dateTime == null
                          ? 'You haven\'t specified a date'
                          : DateFormat().add_yMMMMd().format(_task.dateTime!),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('Due Time:'),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader(
                      _task.timeOfDay == null
                          ? 'You haven\'t specified a time'
                          : DateFormat().add_jm().format(_task.timeOfDay!),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader('Description:'),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: SubHeader(
                      _task.description.isEmpty
                          ? 'You haven\'t specified a description'
                          : _task.description,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
