import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final DateTime? initialDate;
  final FormFieldValidator<String>? validator;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerField({
    Key? key,
    required this.labelText,
    this.initialDate,
    this.validator,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null ? "${_selectedDate!.toLocal()}".split(' ')[0] : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = "${picked.toLocal()}".split(' ')[0];
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      validator: widget.validator,
      onTap: _pickDate,
    );
  }
}
