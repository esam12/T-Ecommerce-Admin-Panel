import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/headers/header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(scaffoldKey: _scaffoldKey),
      body: body ?? const SizedBox.shrink(),
    );
  }
}
