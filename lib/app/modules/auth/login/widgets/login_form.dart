part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        CuidapetTextformFild(lable: 'Login'),
        const SizedBox(height: 20),
        CuidapetTextformFild(
          lable: 'Senha',
          obscureText: true,
        ),
        const SizedBox(height: 20),
        CuidapetDefaultButton(lable: 'Entrar', onPressed: () {
          Loader.show();

          Future.delayed(Duration(seconds: 2), () => Loader.hide());

        },)
      ]),
    );
  }
}
