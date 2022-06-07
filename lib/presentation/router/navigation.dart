import 'package:flutter/material.dart';

void navigateTo(context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

navigateToWithData(context, page) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}
