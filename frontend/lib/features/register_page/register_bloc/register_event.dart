abstract class RegisterPageEvent {}

class RegisterPageInputChangedEvent extends RegisterPageEvent {
  String email;
  String password;
  String mobileNo;
  String role;
  RegisterPageInputChangedEvent(
      this.email, this.password, this.mobileNo, this.role);
}

class RegisterPageValidationEvent extends RegisterPageEvent {
  String emailErrorMsg;
  String passwordErrorMsg;
  String mobileNoErrorMsg;
  String roleErrorMsg;
  bool isValid;

  RegisterPageValidationEvent(this.emailErrorMsg, this.passwordErrorMsg,
      this.mobileNoErrorMsg, this.roleErrorMsg, this.isValid);
}

class PostDataEvent extends RegisterPageEvent {}
