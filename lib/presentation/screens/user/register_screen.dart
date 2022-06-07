import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/local_keys.dart';
import 'package:magdsoft_flutter_structure/constants/paths.dart';
import 'package:magdsoft_flutter_structure/constants/style_values.dart';
import 'package:magdsoft_flutter_structure/data/models/account_model.dart';
import 'package:magdsoft_flutter_structure/presentation/router/navigation.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/my_text_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/raw_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  static const String registerRoute = "/register";
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        if (state is RegisterSuccessfullyState) {
          showToast(
            GlobalCubit.get(context).registerResult,
            context,
            AppColor.greenForToast,
          );
          navigateTo(context, LoginScreen.loginRoute);
        }
        if (state is RegisterDataErrorState) {
          showToast(
            GlobalCubit.get(context).registerResult,
            context,
            AppColor.redForToast,
          );
        }
        if (state is RegisterErrorState) {
          showToast(
            "Please check internet connection !",
            context,
            AppColor.redForToast,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                  color: AppColor.blue,
                ),
                Column(
                  children: [
                    Center(
                        child:
                            Image.asset(Paths.flutterLogoImage, height: 25.h)),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(StyleValues.borderRadius * 3),
                            topRight:
                                Radius.circular(StyleValues.borderRadius * 3),
                          ),
                          color: AppColor.white,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(
                                StyleValues.paddingAll * 2),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: StyleValues.space * 4,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.name,
                                  validatorText: "Full Name can not be empty!",
                                  textController: fullNameController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.email,
                                  validatorText: "Email can not be empty!",
                                  textController: emailController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.phone,
                                  validatorText: "Phone can not be empty!",
                                  textController: phoneController,
                                  maxLength: 11,
                                  isPhoneField: true,
                                ),
                                const SizedBox(
                                  height: StyleValues.space,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.pass,
                                  isPasswordField: true,
                                  validatorText: "Password can not be empty!",
                                  textController: passController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.passConfirm,
                                  isPasswordField: true,
                                  validatorText:
                                      "Confirm Password can not be empty!",
                                  textController: confirmPassController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space * 4,
                                ),
                                ConditionalBuilder(
                                  condition: state is RegisterLoadingState,
                                  builder: (_) =>
                                      const CircularProgressIndicator(
                                          color: AppColor.blue, strokeWidth: 5),
                                  fallback: (_) => Row(
                                    children: [
                                      Expanded(
                                        child: RawButton(
                                          buttonText: LocaleKeys.reg,
                                          height: 8.h,
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (passController.text ==
                                                  confirmPassController.text) {
                                                await GlobalCubit.get(context)
                                                    .registerUser(
                                                  User(
                                                    name: fullNameController
                                                        .text
                                                        .trim(),
                                                    email: emailController.text
                                                        .trim(),
                                                    phone: phoneController.text,
                                                    password:
                                                        passController.text,
                                                  ),
                                                );
                                              } else {
                                                showToast(
                                                  "Passwords should be identical !",
                                                  context,
                                                  AppColor.redForToast,
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: StyleValues.space * 3,
                                      ),
                                      Expanded(
                                        child: RawButton(
                                          buttonText: LocaleKeys.log,
                                          onPressed: () {
                                            navigateTo(context,
                                                LoginScreen.loginRoute);
                                          },
                                          height: 8.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
