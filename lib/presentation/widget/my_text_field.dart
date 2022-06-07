import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/MyTextFieldCubit/my_text_field_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/style_values.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

import '../../business_logic/MyTextFieldCubit/my_text_field_states.dart';

class MyTextField extends StatelessWidget {
  final isPasswordField;
  final isPhoneField;
  final labelText;
  final labelTextColor;
  bool obscureText;
  TextInputType textType;
  final borderColor;
  final maxLength;
  final suffixIcon;
  final borderRadius;
  final validatorText;
  final TextEditingController textController;

  MyTextField({
    Key? key,
    this.labelText,
    this.isPhoneField = false,
    this.labelTextColor,
    this.textType = TextInputType.text,
    this.maxLength,
    this.suffixIcon,
    this.isPasswordField = false, //default,
    this.obscureText = false,
    required this.borderColor,
    required this.validatorText,
    required this.textController,
    this.borderRadius = StyleValues.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextFieldCubit(),
      child: BlocConsumer<TextFieldCubit, TextFieldStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TextFieldCubit textFieldCubit = TextFieldCubit.get(context);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: AppColor.textFieldColor,
            ),
            child: TextFormField(
              controller: textController,
              obscureText: isPasswordField
                  ? !textFieldCubit.obscureText
                  : textFieldCubit.obscureText, //If Password hide it
              maxLength: maxLength,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validatorText;
                }
                return null;
              },
              inputFormatters: isPhoneField
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              keyboardType: isPhoneField ? TextInputType.number : textType,
              decoration: InputDecoration(
                counterText: "",
                labelText: labelText,
                suffixIcon: isPasswordField
                    ? GestureDetector(
                        child: Icon(textFieldCubit.suffixIcon),
                        onTap: () {
                          textFieldCubit.changeSuffixIcon();
                        },
                      )
                    : null,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(StyleValues.borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(StyleValues.borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(StyleValues.borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(StyleValues.borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
