// abstract class Failure {}

// // General failures
// class ServerFailure extends Failure {
//   final String error;

//   ServerFailure({required this.error});
// }

// class CacheFailure extends Failure {}

// class ConnectionFailure extends Failure {}

// String mapFailureToMessage(Failure failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       return ;
//     case CacheFailure:
//       return cacheFailureMessage;
//     case ConnectionFailure:
//       return connectionFailureMessage;
//     default:
//       return 'Unexpected error';
//   }
// }
