import '../../logic/entities/report_type.dart';
import '../data_providers/report_type_data_provider.dart';

class ReportTypeRepository {
  final ReportTypeRemoteDataProvider remoteDataProvider;

  ReportTypeRepository({required this.remoteDataProvider});

  Future<List<ReportTypeEntity>> getReportTypes() async {
    final rawReportTypes = await remoteDataProvider.readReportTypes();
    return List<ReportTypeEntity>.from(rawReportTypes
        .map((reportTypeModel) => ReportTypeEntity.fromModel(reportTypeModel)));
  }
}
