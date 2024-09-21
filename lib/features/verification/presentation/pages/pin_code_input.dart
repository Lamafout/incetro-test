import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/verification/presentation/bloc/verification_bloc.dart';

class PinCodeInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const PinCodeInput({super.key, required this.controller, required this.focusNode});
  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  final int pinLength = 6;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        if (widget.controller.text.length == pinLength) {
          _validatePin(widget.controller.text);
        }
      });
    });
  }

  void _validatePin(String pin) {
    di<VerificationBloc>().add(SendCodeEvent(pin));
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Widget _buildPinBox(int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white
        ),
        child: Text(
          widget.controller.text.length > index ? widget.controller.text[index] : '',
          style: Platform.isIOS
          ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
          : Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      BlocListener(
        bloc: di<VerificationBloc>(),
        listener: (context, state) {
          switch (state) {
            case CorrectDataState():
              Navigator.pop(context);
              Navigator.pop(context);
              di<AuthBloc>().add((SuccessfulVerificationEvent()));
              di<AuthBloc>().add(EntryEvent());
            case WrongDataState():
              widget.controller.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong code')));
            case FailureWhileCheckingCodeState():
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No connection')));
            default:
              (){};
          }
        },
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pinLength, (index) {
                        return _buildPinBox(index);
                      }),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  maxLength: pinLength,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.transparent, fontSize: 30),
                  cursorColor: Colors.transparent,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}