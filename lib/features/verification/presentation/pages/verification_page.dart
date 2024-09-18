import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/features/verification/presentation/pages/pin_code_input.dart';

class VerificationPage extends StatefulWidget {
  final String email; 
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  @override 
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {focusNode.requestFocus();});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
        decoration: const BoxDecoration(
          color: Color(0xFFf2f2f7)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){Navigator.pop(context);}, 
                  icon: Icon(
                    Icons.arrow_back
                  ),
                ),
                Text(
                  'Confirmation Email',
                  style: Platform.isIOS
                  ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
                  : Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 20, width: 30,)
              ],
            ),
            Column(
              children: [
                Text(
                  'Enter your code from the email',
                  style: Platform.isIOS
                  ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                  : Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 20,),
                Text(
                  'We\'ve sent an email with the code to your inbox',
                  style: Platform.isIOS
                  ? CupertinoTheme.of(context).textTheme.textStyle
                  : Theme.of(context).textTheme.titleSmall
                ),
                Text(
                  widget.email,
                  style: Platform.isIOS
                  ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)
                ),
              ],
            ),
                PinCodeInput(controller:  _textEditingController, focusNode: focusNode,),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
          ],
        ),
      )
    );
  }
}