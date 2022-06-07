part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

//Login states

class LoginLoadingState extends GlobalState {}

class LoginSuccessfullyState extends GlobalState {}

class LoginDataErrorState extends GlobalState {}

class LoginErrorState extends GlobalState {}

//Register states

class RegisterLoadingState extends GlobalState {}

class RegisterSuccessfullyState extends GlobalState {}

class RegisterDataErrorState extends GlobalState {}

class RegisterErrorState extends GlobalState {}
