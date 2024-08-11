import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageSate();
  }
}

class _DashboardPageSate extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return const Text("message");
  }
}
