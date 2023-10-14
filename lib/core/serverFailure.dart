import 'package:dio/dio.dart';

abstract class Failures {
  final String errMessage;

  Failures(this.errMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection Timeout with server');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send Timeout with server');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Recieve Timeout with server');
      case DioErrorType.badCertificate:
        return ServerFailure('Bad certificate');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request to Server is cancelled');
      // case DioErrorType.connectionError:
      //   if (dioError.message!.contains('SocketException')) {
      //     return ServerFailure('No Internet Connection');
      //   }
      //   return ServerFailure(
      //       'Something Error happened with the connection, Please try later!');

      case DioErrorType.unknown:
        return ServerFailure('No Internet Connection, Swipe down to reload');
      default:
      return ServerFailure('Something Error happened!!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          'Error 404! Request Not Found, Please try again later!');
    } else if (statusCode == 500 || statusCode == 502) {
      return ServerFailure('Internal Server Error, Please try again later!');
    } else {
      return ServerFailure(
          'Oops!! There was an Error, Please try again later!');
    }
  }
}