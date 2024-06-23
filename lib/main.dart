import 'package:flutter/material.dart';
import 'package:image_picker_test_0/providers/image_merging_provider.dart';
import 'package:image_picker_test_0/providers/positions_provider.dart';
import 'package:image_picker_test_0/providers/screens_provider.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';


void main() {


  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScreensProvider()),
        ChangeNotifierProvider(create: (_) => ImageMergingProvider()),
        ChangeNotifierProvider(create: (_) =>  PositionsProvider()),
      ],
      builder: (context, child) {

        return  MyApp();
      },

    )
  );
 // Provider2();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      HomePage(),
    );
  }
}

