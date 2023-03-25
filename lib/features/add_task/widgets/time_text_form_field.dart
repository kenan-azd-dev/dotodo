
import 'package:dotodo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class TimeTextFormField extends StatelessWidget {
  const TimeTextFormField({
    super.key,
    required DateTime? date,
    required TextEditingController timeController,
    required void Function()? onTap,
  })  : _date = date,
        _timeController = timeController,
        _onTap = onTap;

  final DateTime? _date;
  final TextEditingController _timeController;
  final void Function()? _onTap;
  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    return Container(
      margin: EdgeInsets.only(bottom: kScreenMargin),
      child: TextFormField(
        enabled: _date != null,
        controller: _timeController,
        onTap: _onTap,
        readOnly: true,
        decoration: InputDecoration(
          hintText: '${localization.dueTime} ${localization.descriptionHelper}',
          suffixIcon: InkWell(
            onTap: () {},
            child: Icon(Icons.access_time_rounded),
          ),
        ),
      ),
    );
  }
}