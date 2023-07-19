part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CuidapetTextformFild(
              lable: 'Login',
              controller: _loginEC,
              validator: Validatorless.multiple([
                Validatorless.required('Login obrigatório'),
                Validatorless.email('Login deve se um e-mail válido')
              ]),
            ),
            const SizedBox(height: 20),
            CuidapetTextformFild(
              lable: 'Senha',
              obscureText: true,
              controller: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatória'),
                Validatorless.min(6, 'Senha precisa ter pelo menos 6 caracteres')
              ]),
            ),
            const SizedBox(height: 20),
            CuidapetTextformFild(
              lable: 'Confirmar Senha',
              obscureText: true,
              validator: Validatorless.multiple([
                Validatorless.required('Confirmar senha é obrigatória'),
                Validatorless.min(6, 'Confirmar senha precisa ter pelo menos 6 caracteres'),
                Validatorless.compare(_passwordEC, 'Senha e confirmar senha não são iguais')
              ]),
            ),
            const SizedBox(height: 20),
            CuidapetDefaultButton(onPressed: () {
              final formValid = _formKey.currentState?.validate() ?? false;
              final controller = Modular.get<RegisterController>();
              
              if(formValid) {
                controller.register(email: _loginEC.text, password: _passwordEC.text);
              }
            }, lable: 'Cadastrar')
          ],
        ),
      ),
    );
  }
}
