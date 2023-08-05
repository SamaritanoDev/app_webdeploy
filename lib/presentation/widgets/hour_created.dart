import 'package:app_webdeploy/presentation/widgets/voucher_custom.dart';
import 'package:flutter/material.dart';

class HourDate extends StatefulWidget {
  final VoucherCustom voucherData;
  const HourDate({super.key, required this.voucherData});

  @override
  State<HourDate> createState() => _HourDateState();
}

class _HourDateState extends State<HourDate> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.voucherData.hourOperation;
    _selectedTime = TimeOfDay.fromDateTime(widget.voucherData.hourOperation);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.voucherData.hourOperation,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Hora de operación',
          suffixIcon: Icon(
            Icons.hourglass_empty,
            color: colors.primary,
          ),
        ),
        child: Text(
          _selectedTime.format(context),
          style: TextStyle(
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
