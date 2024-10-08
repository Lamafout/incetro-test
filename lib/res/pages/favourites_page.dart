import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/auth/presentation/pages/organisation_card_widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});
  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    di<AuthBloc>().add(SuccessfulVerificationEvent());
    di<AuthBloc>().add(EntryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<AuthBloc>(),
      builder: (context, state) {
        switch (state) {
          case AuthenticatedState():
            return Column(
              children: state.organisations.data.where((elem) => elem.isFavorite == true).isEmpty
              ? [
                  Text(
                    'This is where your favorite restoraunts will be',
                    style: Platform.isIOS
                    ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                    : Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 40),
                  const Icon(
                    CupertinoIcons.heart,
                    color: Colors.grey,
                    size: 50,
                  ),
                  const SizedBox(height: 40),
                ]
              : state.organisations.data.where((elem) => elem.isFavorite == true)
                .map((org) => OrganizationCardWidget(organizationsElement: org)).toList(),
            );
          case UnauthenticatedState():
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'This is where your favorite restoraunts will be',
                    style: Platform.isIOS
                    ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                    : Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 40),
                  const Icon(
                    CupertinoIcons.heart,
                    color: Colors.grey,
                    size: 50,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          case FailureState():
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => di<AuthBloc>().add(EntryEvent()),
                  child: Text('${state.message}. Tap to reload'),
                ),
              ],
            );
          default: return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            );
        }
      }
    );
  }
}