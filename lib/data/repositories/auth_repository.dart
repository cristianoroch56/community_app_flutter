import 'package:community_app/data/services/api_service.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final ApiService apiService = ApiService();

  Future<Response?> login(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/login/", jsonData: jsonData);
  }

  Future<Response?> register(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/registration/",
        jsonData: jsonData);
  }

  Future<Response?> verifyOtp(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/verify_activation_otp/",
        jsonData: jsonData);
  }

  Future<Response?> resendOtp(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/resend_activation_otp/",
        jsonData: jsonData);
  }

  Future<Response?> forgetPasswordOtp(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/forgetpasswordotp/",
        jsonData: jsonData);
  }

  Future<Response?> verifyForgetPasswordOtp(
      Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/verify_forgetpassword_otp/",
        jsonData: jsonData);
  }

  Future<Response?> resetPassword(Map<String, dynamic>? jsonData) async {
    return apiService.post("api/authentication/reset_password/",
        jsonData: jsonData);
  }
}
