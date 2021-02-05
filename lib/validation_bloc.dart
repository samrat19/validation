import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ValidationBloc {
  final _email = BehaviorSubject<String>.seeded('@');
  final _password = BehaviorSubject<String>.seeded('');

  Stream<String> get email => _email.stream.transform(validateEmail);

  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get password => _password.stream.transform(validatePassword);

  Sink<String> get sinkPassword => _password.sink;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  static bool isEmail(String email) {
    String value =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(value);

    return regExp.hasMatch(email);
  }

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length != 1) {
      isEmail(value)
          ? sink.add(value)
          : sink.addError('please provide a correct email');
    }
  });

  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length != 0) {
      value.length >= 8
          ? sink.add(value)
          : sink.addError('Password should be 8 characters long');
    }
  });

  dispose() {
    _email.close();
    _password.close();
  }
}

final validation = ValidationBloc();
