class ApiEndpoints {
  ApiEndpoints._();


  static const carousel = "/carousel";

  
  //-----------------------Auth-------------------------------

  static const login = "/user/login";
  static const register = "/user/register";
  static const sendOtp = "/user/sendotp";
  static const refreshToken = "/auth/refreshtoken";
  static const verifyOtp = "/auth/verifyotp";
  static const editProfile = "/user/profile";

  //-----------------------User-------------------------------
  static const userExist = "/user/exists";
  static const getProfile = "/user/profile";

  //-----------------------Course-------------------------------
  static const getAllCourses = "user/course";
  static const getAllJobs = "/job";
  
}
