import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/send_email/presentation/bloc/send_email_bloc.dart';
import 'package:incetro_test/features/verification/presentation/pages/verification_page.dart';

class EnterEmailForm extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textController;

  const EnterEmailForm({super.key, required this.focusNode, required this.textController});

  @override
  State<EnterEmailForm> createState() => _EnterEmailFormState();
}

class _EnterEmailFormState extends State<EnterEmailForm> with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: animationController, 
        curve: Curves.elasticIn
      )
    );
  }

  shakeAndClearField() {
    animationController.forward(from: 0).then((_){
      widget.textController.clear();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(animation.value * (1 - 2 * (animationController.value % 2)), 0),
              child: child,
            );
          },

          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white
            ),
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                hintStyle: Platform.isIOS
                ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 16, color: Colors.grey)
                : Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16, color: Colors.grey)
              ),
              style: Platform.isIOS 
              ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 16,)
              : Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16,)
            ),
          ),
        ),
        const SizedBox(height: 10,),
        BlocListener(
          bloc: di<SendEmailBloc>(),
          listener: (context, state) {
            switch (state) {
              case CodeSendedState():
                showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: VerificationPage(email: widget.textController.text ?? ''),
                    );
                  },
                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(10, 0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              case CodeNotSendedState():
                shakeAndClearField();
              default:
                (){};
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Platform.isIOS
            ? CupertinoButton(
              color: const Color(0xFF38ace7),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'Log in',
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)
              ),
              onPressed: () {
                di<SendEmailBloc>().add(SendEmailEvent());
              },
            )
            : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF38ace7),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                di<SendEmailBloc>().add(SendEmailForGetCodeEvent(widget.textController.text));
              },
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontSize: 16),
              ),
            )
          ),
        ),
      ],
    );
  }
}