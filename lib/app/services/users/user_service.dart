abstract interface class UserService {
  Future<void> register(String email, String password);
}