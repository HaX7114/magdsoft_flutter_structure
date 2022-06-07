import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/MyTextFieldCubit/my_text_field_states.dart';

class TextFieldCubit extends Cubit<TextFieldStates> {
  TextFieldCubit() : super(InitStateOfTextField());

  static TextFieldCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = CupertinoIcons.eye_slash;
  bool obscureText = false;
  Color underLineBorderColor = Colors.black;

  changeSuffixIcon() {
    if (obscureText) {
      obscureText = false;
      suffixIcon = CupertinoIcons.eye_slash;
      emit(SetSuffixIconToEye());
    } else {
      obscureText = true;
      suffixIcon = CupertinoIcons.eye;
      emit(SetSuffixIconToEyeSlash());
    }
  }
}
