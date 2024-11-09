import 'package:flutter/material.dart';

import 'package:kantin_app/pages/admin_food_page.dart';
import 'package:kantin_app/pages/cart_page.dart';
import 'package:kantin_app/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://akrzqrmfgsvgqgpczwiw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFrcnpxcm1mZ3N2Z3FncGN6d2l3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0Njc5MTgsImV4cCI6MjA0NjA0MzkxOH0.RpKztdynh9WsvygHthzYGEkmY3jdywEuoO0jULaSC-8',
  );

  runApp(const MainApp());
}

final SupabaseClient supabase = Supabase.instance.client;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const AdminFoodPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
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
              label: 'Chart',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
