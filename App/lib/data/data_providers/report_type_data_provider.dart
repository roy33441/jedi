import 'package:dio/dio.dart';

import '../../core/constants/rest_routes.dart';
import '../models/report_type.dart';
import 'remote_data_provider.dart';

class ReportTypeRemoteDataProvider extends RemoteDataProvider {
  ReportTypeRemoteDataProvider({required Dio client}) : super(client: client);

  Future<List<ReportType>> readReportTypes() async {
    final response = await client.get<List>(RestRoutes.reportTypes);
    return List<ReportType>.from(response.data!
        .map((reportTypeJson) => ReportType.fromJson(reportTypeJson)));
  }

}
