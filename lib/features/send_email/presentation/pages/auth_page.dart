import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/send_email/presentation/pages/enter_email_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {_focusNode.requestFocus();});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight;
                final maxWidth = constraints.maxWidth;
                return SizedBox(
                  height: maxHeight,
                  width: maxWidth,
                  child: Image.asset(
                  'assets/images/auth_pic.jpg',
                  fit: BoxFit.fitHeight,
                                ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Cyprus',
                      style: Platform.isIOS 
                      ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(color: Colors.white, fontSize: 24)
                      : Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.percent,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            'Get discounts at the best places',
                            style: Platform.isIOS
                              ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Colors.white)
                              : Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,)
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            'Share your reviews',
                            style: Platform.isIOS
                              ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Colors.white)
                              : Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,)
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            'Keep important things in your favorites',
                            style: Platform.isIOS
                              ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Colors.white)
                              : Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,)
                          )
                        ],
                      )
                    ]
                  ),
                ),
                EnterEmailForm(focusNode: _focusNode, textController: _textController),
                GestureDetector(
                  onTap: () async {
                    try{
                      if (await canLaunchUrl(Uri.parse(privacyPolicyUrl))){
                        await launchUrl(
                          Uri.parse(privacyPolicyUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      } else{
                        throw 'Could not launch $privacyPolicyUrl';
                      }
                    }
                    catch (e){
                      print(e);
                    }
                  },
                  child: Text(
                    'By continuing, you are agreeing to this privacy policy.',
                    style: Platform.isIOS
                    ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Colors.white70)
                    : Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white70),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
              ),
            ),
          ], 
        ),
      ),
    );
  }
}