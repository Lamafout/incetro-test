import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';
import 'package:incetro_test/features/card_details/presentation/bloc/card_details_bloc.dart';

class CardDetailsPage extends StatelessWidget {
  CardDetailsPage({super.key, required this.id});
  late Organisation organisation;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS
            ? CupertinoIcons.back
            : Icons.arrow_back
          ),
          onPressed: () {
            di<CardDetailsBloc>().add(ExitFromPage());
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: BlocBuilder(
          bloc: di<CardDetailsBloc>(),
          builder: (context, state) {
            switch (state) {
              case GotOrganisationState():
                return Text(
                  state.organisation.name ?? 'Restaurant',
                  style: Platform.isIOS
                    ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
                    : Theme.of(context).textTheme.titleLarge,
                );
              default: 
                return Text(
                  'Restaurant',
                  style: Platform.isIOS
                    ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
                    : Theme.of(context).textTheme.titleLarge,
                );
            }
          }
        ),
      ),
      body: BlocBuilder(
        bloc: di<CardDetailsBloc>(),
        builder: (context, state) {
          switch (state) {
            case FailureWhileGettingCardDetailsState():
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      di<CardDetailsBloc>().add(SendId(id));
                    },
                    child: Text(state.errorMessage)),
              );
            case GotOrganisationState():
              organisation = state.organisation;
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.9),
                      scrollDirection: Axis.horizontal,
                      itemCount: organisation.photos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: SizedBox(
                              height: 300,
                              child: CachedNetworkImage(
                                imageUrl: organisation.photos[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                organisation.name ?? 'Restaurant',
                                softWrap: true,
                                style: Platform.isIOS
                                    ? CupertinoTheme.of(context)
                                        .textTheme
                                        .navTitleTextStyle
                                    : Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(CupertinoIcons.heart),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 18,
                                    color: organisation.rate == null ||
                                            organisation.rate as double <
                                                index + 1
                                        ? Colors.grey
                                        : Theme.of(context).iconTheme.color,
                                  );
                                }),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  organisation.rate == null
                                      ? 'Not rated'
                                      : organisation.rate.toString(),
                                  style: Platform.isIOS
                                      ? CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color)
                                      : Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                ),
                              ],
                            ),
                            Text(
                              '€1000',
                              style: Platform.isIOS
                                  ? CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                  : Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
