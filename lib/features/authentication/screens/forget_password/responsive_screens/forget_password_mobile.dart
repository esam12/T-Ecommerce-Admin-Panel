import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/forget_password/widgets/header_and_form.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              HeaderAndForm(),
            ],
          ),
        ),
      ),
    );
  }
}
