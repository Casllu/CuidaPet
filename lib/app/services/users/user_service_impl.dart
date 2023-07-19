import 'package:cuidapet/app/core/exception/failure.dart';
import 'package:cuidapet/app/core/exception/user_exists_exception.dart';
import 'package:cuidapet/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/logger/app_logger.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
  })  : _userRepository = userRepository,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }

      await _userRepository.register(email, password);
      final userRegisterCredencial = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userRegisterCredencial.user?.sendEmailVerification();
    } on FirebaseException catch (e) {
      _log.error('Erro ao criar usuário no firebase');
      throw Failure(message: 'Erro ao criar usuário');
    }
  }
}
