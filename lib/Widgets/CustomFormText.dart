import 'package:flutter/material.dart';

class CustomFormText extends StatelessWidget {
  final TextEditingController contr;
  final String fieldname;
  CustomFormText(this.contr, String this.fieldname);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: (fieldname == 'First Name'),
        style: TextStyle(
          fontSize: 25,
        ),
        controller: contr,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter ' + fieldname;
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding:
                new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Color(0xFF00888A))),
            labelText: fieldname),
      ),
    );
  }
}
