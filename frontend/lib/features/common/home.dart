import 'package:flutter/material.dart';
import 'package:frontend/features/common/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageSate();
  }
}

class _HomePageSate extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNav(),
    );
  }
}
