import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'models/cart.dart';
import 'utils/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final cart = Cart();

  @override
  void dispose() {
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: HomeScreen(cart: cart),
    );
  }
}
