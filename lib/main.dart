import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/country_provider.dart';
import 'Screens/country_list_screen.dart';

void main() {
  runApp(MyApp());
}

/// The main point of the application.
///
/// This widget initializes the [MaterialApp] and sets up the application theme.
/// It also provides the [ChangeNotifierProvider] for managing state with [CountryProvider].
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: MaterialApp(
        title: 'Country Explorer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CountryListScreen(),
      ),
    );
  }
}
