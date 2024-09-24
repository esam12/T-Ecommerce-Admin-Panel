import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/login/widgets/login_header.dart';

class LoginDesktopTablet extends StatelessWidget {
  const LoginDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(
      child: Column(
        children: [
          // Header
          TLoginHeader(),
          // Form
          LoginForm()
        ],
      ),
    );
  }
}
