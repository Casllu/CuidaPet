part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButtonWithIcon(
          onTap: () {
            Messages.info('info');
          },
          width: .42.sw,
          color: const Color(0xFF4267B3),
          icon: CuidapetIcons.facebook,
          lable: 'Facebook',
        ),
        RoundedButtonWithIcon(
          onTap: () {},
          width: .42.sw,
          color: const Color(0xFFE15031),
          icon: CuidapetIcons.google,
          lable: 'Google',
        ),
        RoundedButtonWithIcon(
          onTap: () {
            Navigator.pushNamed(context, '/auth/register');
          },
          width: .42.sw,
          color: context.primaryColorDark,
          icon: Icons.email,
          lable: 'Cadastre-se',
        ),
      ],
    );
  }
}