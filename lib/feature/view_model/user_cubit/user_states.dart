
abstract class UserState  {
  const UserState();}

class UserInitial extends UserState {}
class UserLoadingLoginState extends UserState {}
class UserLoadingSignUpState extends UserState {}
class UserStoreLoadingState extends UserState {}
class UserSuccessLoginState extends UserState {}
class UserSuccessSignUpState extends UserState {}
class UserSignInWithGoogleState extends UserState {}
class UserValidatorCodeSuccessState extends UserState {}
class UserValidatorCodeErorrState extends UserState {}
class UserLoadingLogOutState extends UserState {}

class RememberMeSuccessState extends UserState {}
class PolicySuccessState extends UserState {}
class TogglePasswordVisibilityLogin extends UserState {}
class TogglePasswordVisibilitySignUp extends UserState {}
class ResetPassLoadState extends UserState {}
class ResetPassSuccessState extends UserState {}
class ResetPassErorrState extends UserState {
  final String? message;
  const ResetPassErorrState(this.message);
}
class PhoneAuthLoading extends UserState {}

class CodeSentState extends UserState {
  final String verificationId;
  CodeSentState(this.verificationId);
}

class PhoneAuthSuccess extends UserState {}

class PhoneAuthError extends UserState {
  final String error;
  PhoneAuthError(this.error);
}
class UserLogOUtState extends UserState {}
class UserPickImageState extends UserState {}
class UserLogOUtErorrState extends UserState {
  final String? message;
  const UserLogOUtErorrState(this.message);
}
// Authentication

class UserAuthLogInError extends UserState {
  final String? message;
  const UserAuthLogInError(this.message);
}class UserAuthSignUpError extends UserState {
  final String? message;
  const UserAuthSignUpError(this.message);
}








