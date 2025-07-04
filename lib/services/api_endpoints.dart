class ApiEndpoints {
  ApiEndpoints._();

  //-----------------------Auth-------------------------------

  static const login = "/user/login";
  static const register = "/user/register";
  static const sendOtp = "/user/sendotp";
  static const refreshToken = "/auth/refreshtoken";
  static const verifyOtp = "/auth/verifyotp";

  //-----------------------User-------------------------------
  static const userExist = "/user/exists";

  //-----------------------Course-------------------------------
  static const getAllCourses = "user/course";
  static const getAllJobs = "/job";
  
}
