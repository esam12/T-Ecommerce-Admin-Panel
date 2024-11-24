import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:t_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

import 'utils/constants/colors.dart';
=======
import 'package:t_ecommerce_admin_panel/bindings/general_binding.dart';
import 'package:t_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
>>>>>>> master
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
<<<<<<< HEAD

      getPages: TAppRoutes.pages,
      initialRoute: TRoutes.firstScreen,
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => Scaffold(
              body: Center(
                  child: Text(
                      'Page Not Found')))), //GetPage(name: '/page-not-found', page: () => PageNotFound(),)),
      //home: const FirstScreen(),
      // home: const Scaffold(
      //   backgroundColor: TColors.primary,
      //   body: Center(
      //     child: CircularProgressIndicator(color: Colors.white),
      //   ),
      // ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Simple Navigation: Default Flutter Navigator VS Getx Navigation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SecondScreen()));
                },
                child: Text('Default Navigation'),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const SecondScreen());
                },
                child: Text('Getx Navigation'),
              ),
            ),

            // Named Navigation
            SizedBox(height: 50),
            Divider(),
            Text(
              'Named Navigation: Flutter Navigator VS Getx Named Navigation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/second-screen');
                },
                child: Text('Default Named Navigation'),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen');
                },
                child: Text('Getx Named Navigation'),
              ),
            ),

            // PASS DATA
            SizedBox(height: 50),
            Divider(),
            Text(
              'Pass Data Between screens - GetX',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen', arguments: 'Hello World');
                },
                child: Text('Getx Pass Data'),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen?device=phone&id=123&name=John');
                },
                child: Text('Pass Data in URL'),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen?device=phone&id=123&name=John',
                      arguments: 'Hello World');
                },
                child: Text('Pass Data in URL with arguments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              Get.arguments.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text('Device: ${Get.parameters['device']}'),
            Text('ID: ${Get.parameters['id']}'),
            Text('Name: ${Get.parameters['name']}'),
          ],
        ),
      ),
=======
      initialBinding: GeneralBinding(),

      getPages: TAppRoutes.pages,
      initialRoute: TRoutes.dashboard,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      ), //GetPage(name: '/page-not-found', page: () => PageNotFound(),)),
>>>>>>> master
    );
  }
}
