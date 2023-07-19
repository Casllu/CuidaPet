import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:cuidapet/app/core/ui/widgets/cuidapet_textform_fild.dart';
import 'package:cuidapet/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/icons/cuidapet_icons.dart';
import '../../../core/ui/widgets/cuidapet_default_button.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final testeEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 162.w,
                height: 130.h,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            const _LoginForm(),
            const SizedBox(height: 8),
            const _OrSeparetor(),
            const SizedBox(height: 20),
            const _LoginRegisterButtons(),
          ],
        ),
      ),
    ));
  }
}

class _OrSeparetor extends StatelessWidget {
  const _OrSeparetor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: context.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }
}
