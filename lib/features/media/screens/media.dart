import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/media/screens/media/responsive_screens/media_desktop.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: MediaDesktopScreen(),
    );
  }
}
