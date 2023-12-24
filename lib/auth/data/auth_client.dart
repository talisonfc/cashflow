abstract class IAuthClient {
  void loginByEmail(String email, String password);

  void resetByEmail(String email);

  void register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  void logout(String token);
}

class AuthClient implements IAuthClient {
  void loginByEmail(String email, String password) {}

  void resetByEmail(String email) {}

  void register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {}

  void logout(String token) {}
}
