import 'package:true_tips_mobile/core/http/api_provider.dart';
import 'package:true_tips_mobile/core/models/requests/fill_profile_api_req.dart';
import 'package:true_tips_mobile/core/models/requests/login_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/register_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/send_code_api_request.dart';
import 'package:true_tips_mobile/core/models/requests/send_sms_api_request.dart';
import 'package:true_tips_mobile/core/models/responses/fill_profile_api_response.dart';
import 'package:true_tips_mobile/core/models/responses/login_api_resp.dart';
import 'package:true_tips_mobile/core/models/responses/set_password_api_response.dart';
import 'package:true_tips_mobile/core/models/responses/send_code_api_response.dart';
import 'package:true_tips_mobile/core/models/responses/send_sms_api_response.dart';
import 'package:true_tips_mobile/core/repositories/base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository(ApiClient httpClient) : super(httpClient);

  Future<LoginApiResponse> login(LoginApiRequest request) async =>
      LoginApiResponse.fromJson(
          await this.httpClient.post(url('api/tokens/password/'), request));

  Future<SendSmsApiResponse> sendSms(SendSmsApiRequest request) async =>
      SendSmsApiResponse.fromJson(
          await this.httpClient.post(url('api/sms/'), request));

  Future<SendCodeApiResponse> sendCode(SendCodeApiRequest request) async =>
      SendCodeApiResponse.fromJson(
          await this.httpClient.post(url('api/tokens/code/'), request));

  Future<SetPasswordApiResponse> register(RegisterApiRequest request) async =>
      SetPasswordApiResponse.fromJson(
          await this.httpClient.put(url('api/users/password/'), request));

  Future<FillProfileApiResponse> fillProfile(FillProfileApiReq request) async =>
      FillProfileApiResponse.fromJson(
          await this.httpClient.put(url('api/users/profile/'), request));
}
