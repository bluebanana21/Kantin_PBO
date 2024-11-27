import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:kantin_app/pages/admin_food_page.dart';
import 'package:kantin_app/pages/cart_page.dart';
import 'package:kantin_app/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://akrzqrmfgsvgqgpczwiw.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFrcnpxcm1mZ3N2Z3FncGN6d2l3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0Njc5MTgsImV4cCI6MjA0NjA0MzkxOH0.RpKztdynh9WsvygHthzYGEkmY3jdywEuoO0jULaSC-8';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MainApp());
}

final SupabaseClient supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    initializations();
  }

  void initializations() async {
    print("pausing...");
    await Future.delayed(const Duration(seconds: 3));
    print("unpausing...");
    FlutterNativeSplash.remove();
  }

  void _onItemPressed(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const CartPage();
        break;
      case 2:
        page = const AdminFoodPage();
        break;
      default:
        page = const HomePage();
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Admin',
          ),
        ],
        onTap: _onItemPressed,
      ),
    );
  }
}
