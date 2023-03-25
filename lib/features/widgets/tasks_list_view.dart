import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import '../task_overview/task_overview.dart';

import '../widgets/custom_dialog.dart';
import '../widgets/sub_header.dart';

import '../../blocs/task/task_bloc.dart';
import '../../data/model/models.dart';

import '../../utils/utils.dart';
import '../../utils/constants.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required items,
  }) : _items = items;

  final List<Task> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return TaskListTile(item: _items[index]);
        },
      ),
    );
  }
}

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required Task item,
  }) : _item = item;

  final Task _item;

  @override
  Widget build(BuildContext context) {
    return SwipeableTile.card(
      confirmSwipe: (_) async {
        bool confirm = false;
        await showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              iconData: Icons.delete_rounded,
              title: 'Confirm Deletion',
              content: SubHeader('Are you sure you want to delete this task?'),
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop();
              },
            );
          },
        );
        return confirm;
      },
      key: Key(_item.id),
      borderRadius: kSmallBorderRadius,
      backgroundBuilder: (context, direction, progress) {
        return Container(
          padding: EdgeInsets.only(right: kScreenMargin),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
          ),
          child: Icon(
            Icons.delete_rounded,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
        );
      },
      horizontalPadding: 20,
      verticalPadding: 10,
      shadow: BoxShadow(
        offset: Offset(0, 10),
        blurRadius: 10,
        blurStyle: BlurStyle.normal,
        color: Colors.black26,
      ),
      color: Colors.white,
      onSwiped: (_) {
        context
            .read<TasksOverviewBloc>()
            .add(DeleteTaskEvent(taskId: _item.id));
      },
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskOverviewPage(task: _item),
            ),
          ),
          child: Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _item.isCompleted ? Colors.green : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kSmallBorderRadius),
                      topLeft: Radius.circular(kSmallBorderRadius),
                    ),
                  ),
                  child: _item.dateTime != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_item.dateTime!.day}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${Utils.getMonthName(_item.dateTime!.month)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : null,
                  width: 40,
                ),
                Container(
                  margin: EdgeInsets.all(kScreenMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_item.title}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _item.dateTime == null
                            ? 'You haven\'t specified a date'
                            : DateFormat().add_yMMMMd().format(_item.dateTime!),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    value: _item.isCompleted,
                    onChanged: (value) {
                      context.read<TasksOverviewBloc>().add(CompleteTaskEvent(
                          taskId: _item.id, isCompleted: _item.isCompleted));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
