import 'package:flutter/material.dart';
import 'package:frontend/features/common/app_title.dart';
import 'package:frontend/features/common/register_login_button.dart';
import 'package:frontend/features/login_page.dart';
import 'package:frontend/features/register_page/ui/widgets/mobile_no_input.dart';
import 'package:frontend/features/common/page_text.dart';

class MobileNoInputPage extends StatefulWidget {
  const MobileNoInputPage({super.key});

  @override
  State<StatefulWidget> createState() => _MobileNoInputPage();
}

class _MobileNoInputPage extends State<MobileNoInputPage> {
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneFocused = _phoneFocusNode.hasFocus;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 150),
            buildAppTitle(),
            const SizedBox(height: 100),
            buildPageText(context),
            const SizedBox(height: 50),
            buildMobileNoInput(context, _phoneFocusNode, isPhoneFocused, null),
            const SizedBox(height: 20),
            buildRegisterLoginButton(context, "Send OTP")
          ],
        ),
      ),
    );
  }
}
