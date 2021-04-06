import 'package:dio/dio.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/data/data_providers/remote_data_provider.dart';
import 'package:jedi/data/models/missing_reason.dart';

class MissingReasonDataProvider extends RemoteDataProvider {
  MissingReasonDataProvider({required Dio client}) : super(client: client);

  Future<List<MissingReason>> readMissingCatagories() async {
    final response = await client.get<List>(RestRoutes.missingReason);
    return List<MissingReason>.from(response.data!
        .map((missingReasonJson) => MissingReason.fromJson(missingReasonJson)));
  }
}
