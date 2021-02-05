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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: validation.email,
              builder: (_, snapShot) => TextField(
                  onChanged: (val) => validation.sinkEmail.add(val),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: snapShot.hasError?snapShot.error.toString():null
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
            ),

            StreamBuilder(
              stream: validation.password,
              builder: (_, snapShot) => TextField(
                onChanged: (val) => validation.sinkPassword.add(val),
                decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: snapShot.hasError?snapShot.error.toString():null
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
