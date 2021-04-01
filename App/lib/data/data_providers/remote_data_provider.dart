import 'package:dio/dio.dart';

abstract class RemoteDataProvider {
  final Dio client;

  RemoteDataProvider({required this.client});
}
