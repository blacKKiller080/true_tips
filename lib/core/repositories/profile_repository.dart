import 'package:true_tips_mobile/core/helper/SystemHelper.dart';
import 'package:true_tips_mobile/core/http/api_provider.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/models/requests/fill_profile_api_req.dart';
import 'package:true_tips_mobile/core/models/requests/update_password_api_request.dart';
import 'package:true_tips_mobile/core/models/responses/fill_profile_api_response.dart';

import 'base_repository.dart';

class ProfileRepository extends BaseRepository {
  ApiClient httpClient;

  ProfileRepository(this.httpClient) : super(httpClient);

  Future<UserEntity> currentUser() async {
    return UserEntity.fromJson(
        await this.httpClient.get(url('api/users/profiles/')));
  }

  Future<UserEntity> updateProfile(UserEntity userEntity) async {
    return UserEntity.fromJson(
        await this.httpClient.put(url('api/users/profile/'), userEntity));
  }

  Future<dynamic> updatePassword(UpdatePasswordApiRequest request) async {
    return await this.httpClient.put(url('api/users/change_password/'), request);
  }
}
