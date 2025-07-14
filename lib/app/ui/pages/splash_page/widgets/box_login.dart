import 'package:flutter/material.dart';

import 'checkbotandforgot.dart';
import 'form_email.dart';
import 'form_password.dart';
import 'login_button.dart';

class BoxLogin extends StatelessWidget {
  const BoxLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormEmail(),
        const SizedBox(height: 10),
        const FormPassword(),
        const SizedBox(height: 10),
        const Checkbotandforgot(),
        const SizedBox(height: 20),
        const LoginButton(),
      ],
    );
  }
}
