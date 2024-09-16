import 'package:flutter/material.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/card_details/presentation/bloc/card_details_bloc.dart';

abstract class OrganisationsElementWidget extends StatelessWidget {
  onTap(){
    di<CardDetailsBloc>().add(SendId(0));
  }
  const OrganisationsElementWidget({super.key});
}