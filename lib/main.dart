import 'package:flutter/material.dart';
import 'package:text_field_validation/validation_bloc.dart';

main() => runApp(MaterialApp(
      home: FormScreen(),
    ));

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: validation.email,
          builder: (_, snapShot) => TextField(
              onChanged: (val) => validation.inMail.add(val),
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: snapShot.hasError?snapShot.error.toString():null
              ),
              keyboardType: TextInputType.emailAddress,
            ),
        ),
      ),
    );
  }
}
