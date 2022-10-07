import 'package:flutter/foundation.dart';
import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';
import 'package:true_tips_mobile/core/models/requests/login_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/register_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/send_code_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/send_sms_api_request.dart';
import 'package:true_tips_mobile/core/models/responses/login_api_resp.dart';
import 'package:true_tips_mobile/core/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository authRepository;

  AuthProvider(this.authRepository);

  Future<void> login(String login, String password) async {
    var resp = await this
        .authRepository
        .login(LoginApiRequest(phone: login, password: password));
    await SharedPreferencesHelper.setToken(resp.token);
  }

  Future<String> sendPhoneAndGetCode(String phone) async {
    var resp =
        await this.authRepository.sendSms(SendSmsApiRequest(phone: phone));
    return resp.uid;
  }

  Future<String> sendCodeAndGetToken(String code, String uid) async {
    var resp = await this
        .authRepository
        .sendCode(SendCodeApiRequest(uid: uid, code: code));
    return resp.token;
  }

  Future<String> setPassword(String password) async {
    var resp = await this
        .authRepository
        .register(RegisterApiRequest(password: password));
    return resp.password;
  }
}
