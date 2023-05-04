import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mogul/home.dart';

import 'handlers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderHandler>(
        create: (_)=> ProviderHandler(),
        child:  MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        )
    );
  }
}