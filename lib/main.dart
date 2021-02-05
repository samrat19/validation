import 'package:flutter/material.dart';
import 'package:text_field_validation/validation_bloc.dart';

main() => runApp(MaterialApp(
      home: FormScreen(),
    ));

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 20.0,
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

            SizedBox(
              height: 40.0,
            ),

            StreamBuilder(
              stream: validation.submitValid,
              builder: (_, snapShot) => MaterialButton(
                onPressed: snapShot.data != true? (){} : (){
                  print('true');
                },
                child: Text('SUBMIT',style: TextStyle(
                  letterSpacing: 1.4,
                  fontSize: 16.0,
                  color: Colors.white,
                ),),
                color: snapShot.data != true?Colors.grey[200]:Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
