import 'package:flutter/material.dart';
import 'package:session_mate/commonWidget/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: CustomText('Setting Screen'))],
      ),
    );
  }
}
