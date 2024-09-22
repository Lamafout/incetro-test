import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:incetro_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:incetro_test/features/auth/data/sources/auth_local_source.dart';
import 'package:incetro_test/features/auth/data/sources/auth_remote_source.dart';
import 'package:incetro_test/features/auth/domain/usecases/auth_usecases.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/card_details/data/repositories/card_details_repository_impl.dart';
import 'package:incetro_test/features/card_details/data/sources/card_details_local_source.dart';
import 'package:incetro_test/features/card_details/data/sources/card_details_remote_source.dart';
import 'package:incetro_test/features/card_details/domain/usecases/card_details_usecase.dart';
import 'package:incetro_test/features/card_details/presentation/bloc/card_details_bloc.dart';
import 'package:incetro_test/features/like/data/repositories/like_repository_impl.dart';
import 'package:incetro_test/features/like/data/sources/like_local_source.dart';
import 'package:incetro_test/features/like/data/sources/like_remote_source.dart';
import 'package:incetro_test/features/like/domain/usecases/like_usecase.dart';
import 'package:incetro_test/features/like/presentation/bloc/like_bloc.dart';
import 'package:incetro_test/features/send_email/data/repositories/send_email_repository_impl.dart';
import 'package:incetro_test/features/send_email/data/sources/send_email_local_source.dart';
import 'package:incetro_test/features/send_email/data/sources/send_email_remote_source.dart';
import 'package:incetro_test/features/send_email/domain/usecases/send_email_usecases.dart';
import 'package:incetro_test/features/send_email/presentation/bloc/send_email_bloc.dart';
import 'package:incetro_test/features/verification/data/repositories/verification_repository_impl.dart';
import 'package:incetro_test/features/verification/data/sources/verification_local_source.dart';
import 'package:incetro_test/features/verification/data/sources/verification_remote_source.dart';
import 'package:incetro_test/features/verification/domain/usecases/verification_usecase.dart';
import 'package:incetro_test/features/verification/presentation/bloc/verification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.instance;

void setupDi() async {
  // SHARED PREFERENCES
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(sharedPreferences);

  // AUTH
  di.registerLazySingleton<LocalSourceAuth>(() => LocalSourceAuth(sharedPreferences));
  di.registerLazySingleton<RemoteSourceAuth>(() => RemoteSourceAuth());
  di.registerLazySingleton<AuthRepositoryImpl>(()=>AuthRepositoryImpl(localSource: di<LocalSourceAuth>(), remoteSource: di<RemoteSourceAuth>()));
  di.registerLazySingleton<AuthUsecases>(() => AuthUsecases(di<AuthRepositoryImpl>()));
  di.registerLazySingleton<AuthBloc>(() => AuthBloc());

  // EMAIL SEND
  di.registerLazySingleton<SendEmailLocalSource>(() => SendEmailLocalSource(sharedPreferences));
  di.registerLazySingleton<SendEmailRemoteSource>(() => SendEmailRemoteSource());
  di.registerLazySingleton<SendEmailRepositoryImpl>(() => SendEmailRepositoryImpl(sendEmailLocalSource: di<SendEmailLocalSource>(), sendEmailRemoteSource: di<SendEmailRemoteSource>()));
  di.registerLazySingleton<SendEmailUsecases>(()=>SendEmailUsecases(di<SendEmailRepositoryImpl>()));
  di.registerLazySingleton<SendEmailBloc>(() => SendEmailBloc());

  // VERIFICATION CODE SEND
  di.registerLazySingleton<VerificationLocalSource>(() => VerificationLocalSource(sharedPreferences));
  di.registerLazySingleton<VerificationRemoteSource>(() => VerificationRemoteSource());
  di.registerLazySingleton<VerificationRepositoryImpl>(() => VerificationRepositoryImpl(verificationLocalSource: di<VerificationLocalSource>(), verificationRemoteSource: di<VerificationRemoteSource>()));
  di.registerLazySingleton<VerificationUsecase>(() => VerificationUsecase(di<VerificationRepositoryImpl>()));
  di.registerLazySingleton<VerificationBloc>(() => VerificationBloc());

  // CARD DETAILS
  di.registerLazySingleton<CardDetailsLocalSource>(() => CardDetailsLocalSource(sharedPreferences));
  di.registerLazySingleton<CardDetailsRemoteSource>(() => CardDetailsRemoteSource());
  di.registerLazySingleton<CardDetailsRepositoryImpl>(() => CardDetailsRepositoryImpl(cardDetailsLocalSource: di<CardDetailsLocalSource>(), cardDetailsRemoteSource: di<CardDetailsRemoteSource>()));
  di.registerLazySingleton<CardDetailsUsecase>(() => CardDetailsUsecase(cardDetailsRepository: di<CardDetailsRepositoryImpl>()));
  di.registerLazySingleton<CardDetailsBloc>(() => CardDetailsBloc());

  // LIKE BUTTON
  di.registerLazySingleton<LikeLocalSource>(() => LikeLocalSource(sharedPreferences));
  di.registerLazySingleton<LikeRemoteSource>(() => LikeRemoteSource());
  di.registerLazySingleton<LikeRepositoryImpl>(() => LikeRepositoryImpl(likeLocalSource: di<LikeLocalSource>(), likeRemoteSource: di<LikeRemoteSource>()));
  di.registerLazySingleton<LikeUsecase>(() => LikeUsecase(di<LikeRepositoryImpl>()));
  di.registerLazySingleton<LikeBloc>(() => LikeBloc());
  di.registerSingleton<ValueNotifier<int>>(ValueNotifier<int>(0));
}