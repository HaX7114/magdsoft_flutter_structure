import 'package:magdsoft_flutter_structure/constants/end_points.dart';
import 'package:magdsoft_flutter_structure/data/remote/dio_helper.dart';

class User {
  dynamic name;
  dynamic email;
  dynamic password;
  dynamic phone;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  User.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"] as String;
    email = json["email"] as String;
    phone = json["phone"] as String;
  }

  static dynamic loginUser(String email, String password) async {
    dynamic result;
    await DioHelper.postData(
      url: loginRequest,
      body: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      if (value.data["status"] == 404) {
        //Bad request
        result = value.data["message"];
      } else {
        //Successfully done
        result = value.data["account"][0];
      }
    }).catchError((e) {
      result = "error";
    });
    return result;
  }

  static dynamic registerUser(User user) async {
    dynamic result;
    await DioHelper.postData(
      url: registerRequest,
      body: {
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "password": user.password,
      },
    ).then((value) {
      if (value.data["status"] == 408) {
        //Bad request
        result = value.data["message"];
      } else {
        //Successfully done
        result = value.data["message"];
      }
    }).catchError((e) {
      result = "error";
    });
    return result;
  }
}
