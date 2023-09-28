import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/modules/core/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../models/user_model.dart';

class AuthHomePage extends StatefulWidget {

  final AuthStore _authStore;

  const AuthHomePage({super.key, required AuthStore authStore}) : _authStore = authStore;

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {

  @override
  void initState() {
    super.initState();

    reaction<UserModel?>((_) =>widget._authStore.userLogged, (userLogger) {
      if(userLogger != null && userLogger.email.isNotEmpty) {
        Modular.to.navigate('/home/');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    }); 

    WidgetsBinding.instance.addPostFrameCallback((_) { 
      widget._authStore.loadUserLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 150.w,
          height: 200.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
