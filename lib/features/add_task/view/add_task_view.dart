import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_event.dart';
import '../../../blocs/task/task_bloc.dart';

import '../../../data/model/models.dart';

import '../../../utils/constants.dart';

import '../../widgets/text_field_with_popup.dart';
import '../../widgets/sub_header.dart';
import '../widgets/date_text_form_field.dart';
import '../widgets/description_text_form_field.dart';
import '../widgets/time_text_form_field.dart';
import '../widgets/title_text_form_field.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({
    super.key,
    Category? category,
    Task? task,
    bool isEdit = false,
  })  : _category = category,
        _isEdit = isEdit,
        _task = task;

  final Category? _category;
  final bool _isEdit;
  final Task? _task;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _categoriesController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime? _date;
  DateTime? _timeOfDay;

  @override
  void initState() {
    super.initState();
    // if we are editing the task, then initilize the text form field
    // with the corresponding values
    if (widget._isEdit) {
      String? categoryName;
      for (var category
          in context.read<CategoriesOverviewBloc>().state.categories) {
        if (category.id == widget._task!.categoryId) {
          categoryName = category.name;
        }
      }
      _categoriesController.text = categoryName!;
      _taskController.text = widget._task!.title;
      _descriptionController.text = widget._task!.description;
      if (widget._task!.dateTime != null) {
        _date = widget._task!.dateTime;
        _dateController.text =
            DateFormat().add_yMMMMd().format(widget._task!.dateTime!);
      }
      if (widget._task!.timeOfDay != null) {
        _timeOfDay = widget._task!.timeOfDay;
        _timeController.text =
            DateFormat().add_jm().format(widget._task!.timeOfDay!);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
    _categoriesController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
  }

  _onSaved() {
    // if the form is not valid then don't save and quit.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String? catId;

    // if we are adding a task from the TasksByCategoryView
    // then it already exist, let's assign it to catId and continue
    if (widget._category != null) {
      catId = widget._category!.id;
    }
    // but if the previous condition is not satisfied,
    else {
      // then loop through the categories,
      for (var category
          in context.read<CategoriesOverviewBloc>().state.categories) {
        // if you find that the name of the category you entered between the categories
        // (that means you're adding the task from the HomeView,
        // because when you add it from TasksByCategoryView,
        // the TextField for the category is not visible,
        // so you can't enter any info in it),
        // then assign the id of the category you found to the catId
        if (category.name == _categoriesController.text) {
          catId = category.id;
          break;
        }
      }
      // if the catId is still null
      // (which means that you are adding the task from the HomeView,
      // but the category of the task doesn't exist,
      // and that's why you didn't find it in the previous tries),
      // then make a new category
      //
      // this is more convenient to the user,
      // because this will add the category automatically
      // rather than having to add it manually first to be able
      // to put the new task in that new category.
      if (catId == null) {
        catId = Uuid().v1();
        final newCategory =
            Category(id: catId, name: _categoriesController.text);
        context
            .read<CategoriesOverviewBloc>()
            .add(SaveCategoryEvent(category: newCategory));
      }
    }

    final newTask = Task(
      id: Uuid().v1(),
      categoryId: catId,
      title: _taskController.text.trim(),
      description: _descriptionController.text.trim(),
      dateTime: _date,
      timeOfDay: _timeOfDay,
    );
    context.read<TasksOverviewBloc>().add(SaveTaskEvent(task: newTask));
    Navigator.of(context).pop();
  }

  _onEdit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final newTask = Task(
      id: widget._task!.id,
      categoryId: widget._task!.categoryId,
      title: _taskController.text.trim(),
      description: _descriptionController.text.trim(),
      dateTime: _date,
      timeOfDay: _timeOfDay,
    );
    context.read<TasksOverviewBloc>().add(UpdateTaskEvent(task: newTask));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget._isEdit
            ? Text('Edit Task')
            : widget._category != null
                ? Text('Add a task to ${widget._category!.name}')
                : Text('Add a task'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: kScreenMargin,
          right: kScreenMargin,
          left: kScreenMargin,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TitleTextFormField(taskController: _taskController),
              if (widget._category == null)
                Container(
                  margin: EdgeInsets.only(bottom: kScreenMargin),
                  child: TextFieldWithPopup(
                    textEditingController: _categoriesController,
                    hintText: 'Category\'s name',
                    tooltip: 'Categories examples',
                    onSelected: (value) {
                      setState(() {
                        _categoriesController.text = value;
                      });
                    },
                  ),
                ),
              DateTextFormField(
                dateController: _dateController,
                date: _date,
                timeOfDay: _timeOfDay,
                onTap: () async {
                  final _pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2100),
                  );
                  if (_pickedDate != null) {
                    setState(() {
                      _date = _pickedDate;
                      _dateController.text =
                          DateFormat().add_yMMMMd().format(_date!);
                    });
                  }
                },
              ),
              TimeTextFormField(
                date: _date,
                timeController: _timeController,
                onTap: () async {
                  final _time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (_date != null && _time != null) {
                    setState(() {
                      _timeOfDay = DateTime(
                        _date!.year,
                        _date!.month,
                        _date!.day,
                        _time.hour,
                        _time.minute,
                      );
                      _timeController.text =
                          DateFormat().add_jm().format(_timeOfDay!);
                    });
                  }
                },
              ),
              DescriptionTextFormField(
                  descriptionController: _descriptionController),
              !widget._isEdit
                  ? SaveButton(
                      onPressed: () {
                        _onSaved();
                      },
                    )
                  : SaveButton(
                      onPressed: () {
                        _onEdit();
                      },
                      title: 'Edit',
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    String title = 'Save',
    required void Function()? onPressed,
  })  : _onPressed = onPressed,
        _title = title;
  final String _title;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: kSmallScreenMargin),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSmallBorderRadius)),
        ),
      ),
      onPressed: _onPressed,
      child: SubHeader(_title),
    );
  }
}
