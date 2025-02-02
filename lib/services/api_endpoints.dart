class ApiEndpoints {
  ApiEndpoints._();

  //-----------------------Auth-------------------------------

  static const login = "/auth/login";
  static const sendOtp = "/auth/sendotp";
  static const refreshToken = "/auth/refreshtoken";
  static const verifyOtp = "/auth/verifyotp";

  //-----------------------User-------------------------------
  static const userExist = "/user/exists";
}
