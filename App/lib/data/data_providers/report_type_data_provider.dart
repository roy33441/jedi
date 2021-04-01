import 'package:dio/dio.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/data/data_providers/remote_data_provider.dart';
import 'package:jedi/data/models/report_type.dart';

class ReportTypeRemoteDataProvider extends RemoteDataProvider {
  ReportTypeRemoteDataProvider({required Dio client}) : super(client: client);

  Future<List<ReportType>> readReportTypes() async {
    final response = await client.get<List>(RestRoutes.reportTypes);
    return List<ReportType>.from(response.data!
        .map((reportTypeJson) => ReportType.fromJson(reportTypeJson)));
  }

}
