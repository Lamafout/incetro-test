import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/auth/presentation/pages/auth_card.dart';
import 'package:incetro_test/features/auth/presentation/pages/organisation_card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    di<AuthBloc>().add(EntryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<AuthBloc>(),
      builder: (context, state) {
        switch (state) {
          case InitialState():
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).iconTheme.color,
                )
              ],
            );
          case AuthenticatedState():
            return Column(
              children: state.organisations.data.map((organisation) => OrganisationCardWidget(organisationsElement: organisation)).toList(),
            );
          case UnauthenticatedState():
            return Column(
              children: [
                ...state.organisations.data.map((organisation) => OrganisationCardWidget(organisationsElement: organisation)),
                const AuthCardWidget(),
              ]
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
          default:
            return Container();
        }
      },
    );
  }
}