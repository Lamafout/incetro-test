import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations_element.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/like/presentation/pages/heart_iconbutton.dart';
import 'package:incetro_test/features/auth/presentation/pages/organisaions_element_widget.dart';
import 'package:incetro_test/features/card_details/presentation/bloc/card_details_bloc.dart';
import 'package:incetro_test/features/card_details/presentation/pages/card_details_page.dart';
import 'package:incetro_test/features/send_email/presentation/pages/auth_page.dart';

class OrganizationCardWidget extends OrganisationsElementWidget {
  final OrganizationsElement organizationsElement;

  const OrganizationCardWidget({super.key, required this.organizationsElement});

  @override
  Widget build(BuildContext context) {
    // TODO поиграться с InkWell для получения эффекта волны
    return BlocBuilder(
      bloc: di<AuthBloc>(),
      builder: (context, state) {
        return Material(
          child: GestureDetector(
              onTap: () {
                if (state is AuthenticatedState){
                  di<CardDetailsBloc>().add(SendId(organizationsElement.id));
                  Platform.isIOS
                  ? Navigator.push(context, CupertinoPageRoute(builder: (context) => CardDetailsPage(id: organizationsElement.id,)))
                  : Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailsPage(id: organizationsElement.id,)));
                }
                else {
                  showModalBottomSheet(
                      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(20), topRight: Radius.circular(20))),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const AuthPage();
                      }
                    );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1, blurRadius: 10, color: Colors.black26),
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints boxConstrains) {
                        final cardWith = boxConstrains.maxWidth;
                        final cardHeight = boxConstrains.maxHeight;
                        return Column(
                          children: [
                            SizedBox(
                              width: cardWith,
                              height: cardHeight * 0.65,
                              child: CachedNetworkImage(
                                imageUrl: organizationsElement.photo ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: cardWith,
                              height: cardHeight * 0.35,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              organizationsElement.name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: Platform.isIOS
                                                  ? CupertinoTheme.of(context)
                                                      .textTheme
                                                      .navTitleTextStyle
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                        ),
                                        state is AuthenticatedState
                                        ? HeartIconButton(organization: organizationsElement,)
                                        : IconButton(
                                            icon: const Icon(
                                              CupertinoIcons.heart,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(20), topRight: Radius.circular(20))),
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return const AuthPage();
                                                }
                                              );
                                            },
                                          ),
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 18,
                                            ),
                                            Text(
                                              organizationsElement.rate == null ? 'Not rated' : organizationsElement.rate.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            //TODO добавить средний чек
                                            Text(
                                              '€1000',
                                              style: Platform.isIOS
                                                  ? CupertinoTheme.of(context)
                                                      .textTheme
                                                      .textStyle
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          organizationsElement.cuisins
                                                  ?.join(', ') ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style: Platform.isIOS
                                              ? CupertinoTheme.of(context)
                                                  .textTheme
                                                  .textStyle
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                        ),
                                      ])
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
