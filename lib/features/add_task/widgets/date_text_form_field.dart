import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class DateTextFormField extends StatelessWidget {
  const DateTextFormField({
    super.key,
    required TextEditingController dateController,
    required DateTime? date,
    required DateTime? timeOfDay,
    required void Function()? onTap,
  })  : _dateController = dateController,
        _date = date,
        _timeOfDay = timeOfDay,
        _onTap = onTap;

  final TextEditingController _dateController;
  final DateTime? _date;
  final DateTime? _timeOfDay;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kScreenMargin),
      child: TextFormField(
        onTap: _onTap,
        controller: _dateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Task\'s date (optional)',
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: () {},
            child: Icon(Icons.date_range_outlined),
          ),
        ),
        validator: (value) {
          if (_date == null && _timeOfDay != null) {
            return 'You have to specify a date when you pick a time.';
          }
          return null;
        },
      ),
    );
  }
}
