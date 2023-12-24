import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'user_info.dart';

class UserInfoController extends GetxController with StateMixin<UserInfo> {
  @override
  void onInit() {
    super.onInit();
    // Amplify.Auth.getCurrentUser().then((authUser) {
    //   final email = authUser.signInDetails.toJson()['username'];

    //   change(authUser, status: RxStatus.success());
    // }).catchError((err) {
    //   change(null, status: RxStatus.error(err.toString()));
    // });

    Amplify.Auth.fetchUserAttributes().then((attributes) {
      late String email, photoUrl;
      for (final attribute in attributes) {
        if (attribute.userAttributeKey == AuthUserAttributeKey.email) {
          email = attribute.value;
        } else if (attribute.userAttributeKey == AuthUserAttributeKey.picture) {
          photoUrl = attribute.value;
        }
      }
      change(UserInfo(email: email, photoUrl: photoUrl),
          status: RxStatus.success());
    }).catchError((err) {
      change(null, status: RxStatus.error(err.toString()));
    });

    // attachImage();
  }

  void attachImage() {
    Amplify.Auth.updateUserAttribute(
            userAttributeKey: AuthUserAttributeKey.picture,
            value: 'https://avatars.githubusercontent.com/u/1006964?v=4')
        .then((value) {
      print(value);
    }).catchError((err) {
      print(err);
    });
  }
}
