import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/data/models/account_model.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  late User user;
  dynamic result;
  dynamic registerResult;

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoadingState());

    result = await User.loginUser(email, password);

    if (result is Map) {
      user = User.fromJson(result);
      emit(LoginSuccessfullyState());
    } else if (result == "error") {
      emit(LoginErrorState());
    } else {
      emit(LoginDataErrorState());
    }
  }

  Future<void> registerUser(User user) async {
    emit(RegisterLoadingState());

    registerResult = await User.registerUser(user);
    print(registerResult.toString());

    if (registerResult == "Account Created Successfully") {
      emit(RegisterSuccessfullyState());
    } else if (registerResult == "error") {
      emit(RegisterErrorState());
    } else {
      emit(RegisterDataErrorState());
    }
  }
}
