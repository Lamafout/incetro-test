import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations_element.dart';
import 'package:incetro_test/features/auth/presentation/pages/organisaions_element_widget.dart';
import 'package:incetro_test/features/card_details/presentation/bloc/card_details_bloc.dart';

class OrganisationCardWidget extends OrganisationsElementWidget {
  final OrganisationsElement organisationsElement;

  @override
  onTap() {
    di<CardDetailsBloc>().add(SendId(organisationsElement.id));
  }

  const OrganisationCardWidget({super.key, required this.organisationsElement});

  @override
  Widget build(BuildContext context) {
    // TODO поиграться с InkWell для получения эффекта волны
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 10,
              color: Colors.black26
            ),
          ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.white,
              
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints boxConstrains){
                final cardWith = boxConstrains.maxWidth;
                final cardHeight = boxConstrains.maxHeight;
                return Column(
                  children: [
                    SizedBox(
                      width: cardWith,
                      height: cardHeight * 0.65,
                      child: CachedNetworkImage(
                        imageUrl: organisationsElement.photo ?? '',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  organisationsElement.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: Platform.isIOS
                                    ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
                                    : Theme.of(context).textTheme.titleLarge
                                ),
                              ),
                              //TODO сделать обработку нажатия
                              IconButton(
                                onPressed: (){},
                                iconSize: 30,
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                ),
                              )
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star, 
                                    size: 18,
                                  ),
                                  Text(
                                    organisationsElement.rate.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),  
                                  ),
                                  const SizedBox(width: 5,),
                                  //TODO добавить средний чек
                                  Text(
                                    '€1000',
                                    style: Platform.isIOS
                                      ? CupertinoTheme.of(context).textTheme.textStyle
                                      : Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              Text(
                                organisationsElement.cuisins?.join(', ') ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Platform.isIOS
                                  ? CupertinoTheme.of(context).textTheme.textStyle
                                  : Theme.of(context).textTheme.titleMedium,
                              ),
                            ]
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      )
    );
  }
}