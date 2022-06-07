import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/constants/local_keys.dart';
import 'package:magdsoft_flutter_structure/constants/style_values.dart';
import 'package:magdsoft_flutter_structure/data/models/account_model.dart';
import 'package:magdsoft_flutter_structure/presentation/router/navigation.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/my_text.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/raw_button.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatelessWidget {
  final User user;
  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Text(LocaleKeys.userData),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: StyleValues.verticalPadding),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "${LocaleKeys.name} : ${user.name}"),
                    MyText(text: "${LocaleKeys.email} : ${user.email}"),
                    MyText(text: "${LocaleKeys.phone} : ${user.phone}"),
                  ],
                ),
              ),
              const Spacer(),
              RawButton(
                buttonText: LocaleKeys.logout,
                height: 8.h,
                width: 40.w,
                buttonColor: AppColor.red,
                onPressed: () {
                  navigateTo(context, LoginScreen.loginRoute);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
