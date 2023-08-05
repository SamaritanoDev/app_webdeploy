import 'package:app_webdeploy/presentation/widgets/voucher_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatedDate extends StatefulWidget {
  final VoucherCustom voucherData;
  const CreatedDate({super.key, required this.voucherData});

  @override
  State<CreatedDate> createState() => _CreatedDateState();
}

class _CreatedDateState extends State<CreatedDate> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.voucherData.createdDate;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Fecha de operación',
          suffixIcon: Icon(
            Icons.date_range,
            color: colors.primary,
          ),
        ),
        child: Text(
          DateFormat('dd/MM/yyyy').format(_selectedDate),
          style: TextStyle(
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
