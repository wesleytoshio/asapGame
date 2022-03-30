// import 'dart:io';

// import 'package:asap_game/domain/entities/user_entity.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';

// import '../../../domain/use_cases/get_current_user_usecase.dart';
// import '../../../domain/use_cases/is_sign_in_usecase.dart';
// import '../../../domain/use_cases/sign_out_usecase.dart';

// part 'auth_state.dart';

// @injectable
// class AuthCubit extends Cubit<AuthState> {
//   final GetCurrentUserUseCase getCurrentUserUseCase;
//   final IsSignInUseCase isSignInUseCase;
//   final SignOutUseCase signOutUseCase;
//   AuthCubit(
//       {required this.isSignInUseCase,
//       required this.signOutUseCase,
//       required this.getCurrentUserUseCase})
//       : super(AuthInitial());

//   Future<void> appStarted() async {
//     try {
//       final isSignIn = await isSignInUseCase.call();
//       if (isSignIn) {
//         print("isSignIn $isSignIn");
//         loggedIn();
//       } else {
//         print('else state UnAuthenticated');
//         emit(UnAuthenticated());
//       }
//     } on SocketException catch (_) {
//       print('appStarted error $_');
//       emit(UnAuthenticated());
//     }
//   }

//   Future<void> loggedIn() async {
//     try {
//       final userEntity = await getCurrentUserUseCase.call();
//       print("entrou ${userEntity.email}");
//       emit(Authenticated(user: userEntity));
//     } catch (_) {
//       print('loggedIn error $_');
//       emit(UnAuthenticated());
//     }
//   }

//   Future<void> loggedOut() async {
//     try {
//       await signOutUseCase.call();
//       emit(UnAuthenticated());
//     } on SocketException catch (_) {
//       emit(UnAuthenticated());
//     }
//   }
// }
