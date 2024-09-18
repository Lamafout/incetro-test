import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/features/auth/presentation/pages/organisaions_element_widget.dart';
import 'package:incetro_test/features/send_email/presentation/pages/auth_page.dart';

class AuthCardWidget extends OrganisationsElementWidget {
  onClick(BuildContext context) {
    showModalBottomSheet(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(20), topRight: Radius.circular(20))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const AuthPage();
      }
    );
  }
  const AuthCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/auth_pic.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Log in to get more',
                      style: Platform.isIOS
                      ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(color: Colors.white, fontSize: 24)
                      : Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontSize: 24),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Platform.isIOS
                      ? CupertinoButton(
                        color: const Color(0xFF38ace7),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          'Log in',
                          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w400)
                        ),
                        onPressed: (){},
                      )
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38ace7),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {onClick(context);},
                        child: Text(
                          'Log in',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}