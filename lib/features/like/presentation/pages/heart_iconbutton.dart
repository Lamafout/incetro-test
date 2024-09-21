import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations_element.dart';
import 'package:incetro_test/features/like/presentation/bloc/like_bloc.dart';

class HeartIconButton extends StatelessWidget {
  final OrganizationsElement organization;

  HeartIconButton({super.key, required this.organization});

  void _showSnackBar(BuildContext context, String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikeBloc, Map<String, LikeState>>(
      bloc: di<LikeBloc>(),
      listener: (context, state) {
        final currentState = state[organization.id.toString()];

        if (currentState is LikeFailureState) {
          _showSnackBar(
            context,
            'Network error',
            Icons.wifi_tethering_error_rounded_rounded,
          );
        } else if (currentState is LikeBadRequestState) {
          _showSnackBar(
            context,
            'Bad request error',
            Icons.warning_outlined,
          );
        } 
      },
      child: BlocBuilder<LikeBloc, Map<String, LikeState>>(
        bloc: di<LikeBloc>(),
        builder: (context, state) {
          final currentState = state[organization.id.toString()];

          bool isFilled = organization.isFavorite ?? false;

          if (currentState is LikedState) {
            isFilled = true;
          } else if (currentState is DisLikedState) {
            isFilled = false;
          }

          return IconButton(
            icon: Icon(
              isFilled ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              size: 30,
            ),
            onPressed: () {
              !isFilled
              ? di<ValueNotifier<int>>().value++
              : di<ValueNotifier<int>>().value--;
              di<LikeBloc>().add(TapOnLikeButton(organization.id));
            },
          );
        },
      ),
    );
  }
}


