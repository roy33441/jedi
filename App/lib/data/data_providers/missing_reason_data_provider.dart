import 'package:dio/dio.dart';

import '../../core/constants/rest_routes.dart';
import '../models/missing_reason.dart';
import 'remote_data_provider.dart';

class MissingReasonDataProvider extends RemoteDataProvider {
  MissingReasonDataProvider({required Dio client}) : super(client: client);

  Future<List<MissingReason>> readMissingCatagories() async {
    final response = await client.get<List>(RestRoutes.missingReason);
    return List<MissingReason>.from(response.data!
        .map((missingReasonJson) => MissingReason.fromJson(missingReasonJson)));
  }
}
