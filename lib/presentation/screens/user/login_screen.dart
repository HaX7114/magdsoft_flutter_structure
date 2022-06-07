import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/local_keys.dart';
import 'package:magdsoft_flutter_structure/constants/paths.dart';
import 'package:magdsoft_flutter_structure/constants/style_values.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/main.dart';
import 'package:magdsoft_flutter_structure/presentation/router/navigation.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/my_text_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/raw_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  static const String loginRoute = "/login";
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        if (state is LoginSuccessfullyState) {
          navigateToWithData(
              context, UserProfile(user: GlobalCubit.get(context).user));
        }
        if (state is LoginDataErrorState) {
          showToast(
            GlobalCubit.get(context).result,
            context,
            AppColor.redForToast,
          );
        }
        if (state is LoginErrorState) {
          showToast(
            "Please check internet connection !",
            context,
            AppColor.redForToast,
          );
        }
      },
      builder: (context, state) {
        GlobalCubit gc = GlobalCubit.get(context);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 21, top: 50, end: 21),
                          child: RawButton(
                            buttonText: LocaleKeys.lang,
                            onPressed: () {
                              if (delegate.currentLocale ==
                                  const Locale('en')) {
                                delegate.changeLocale(const Locale('ar'));
                                CacheHelper.saveDataSharedPreference(
                                    key: 'language', value: 'ar');
                              } else {
                                delegate.changeLocale(const Locale('en'));
                                CacheHelper.saveDataSharedPreference(
                                    key: 'language', value: 'en');
                              }
                            },
                            buttonColor: AppColor.white,
                            textColor: AppColor.blue,
                          ),
                        ),
                      ],
                    ),
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
                                  height: StyleValues.space * 5,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.email,
                                  validatorText: "Email can not be empty!",
                                  textController: emailController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space * 2,
                                ),
                                MyTextField(
                                  borderColor: Colors.grey,
                                  labelText: LocaleKeys.pass,
                                  isPasswordField: true,
                                  validatorText: "Password can not be empty!",
                                  textController: passController,
                                ),
                                const SizedBox(
                                  height: StyleValues.space * 10,
                                ),
                                ConditionalBuilder(
                                  condition: state is LoginLoadingState,
                                  builder: (_) =>
                                      const CircularProgressIndicator(
                                    backgroundColor: AppColor.blue,
                                    strokeWidth: 5.0,
                                  ),
                                  fallback: (_) => Row(
                                    children: [
                                      Expanded(
                                        child: RawButton(
                                          buttonText: LocaleKeys.reg,
                                          height: 8.h,
                                          onPressed: () {
                                            navigateTo(context,
                                                RegisterScreen.registerRoute);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: StyleValues.space * 3,
                                      ),
                                      Expanded(
                                        child: RawButton(
                                          buttonText: LocaleKeys.log,
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              await gc.loginUser(
                                                emailController.text,
                                                passController.text,
                                              );
                                            }
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
