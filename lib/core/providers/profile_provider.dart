import 'package:flutter/cupertino.dart';
import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';
import 'package:true_tips_mobile/core/models/requests/update_password_api_request.dart';
import 'package:true_tips_mobile/core/repositories/profile_repository.dart';

class ProfileProvider with ChangeNotifier {
  ProfileRepository profileRepository;

  ProfileProvider(this.profileRepository);

  Future<void> logout() async {
    return await SharedPreferencesHelper.removeAll();
  }

  Future<UserEntity> currentUser() async {
    return profileRepository.currentUser();
  }

  Future<UserEntity> updateProfile(UserEntity userEntity) async {
    return profileRepository.updateProfile(userEntity);
  }

  Future<dynamic> updatePassword(String oldPassword, String newPassword) async {
    return profileRepository.updatePassword(UpdatePasswordApiRequest(
        password: newPassword, oldPassword: oldPassword));
  }
}
