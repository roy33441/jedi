import '../../logic/entities/missing_reason.dart';
import '../data_providers/missing_reason_data_provider.dart';

class MissingReasonRepository {
  final MissingReasonDataProvider remoteDataProvider;

  MissingReasonRepository({required this.remoteDataProvider});

  Future<List<MissingReasonEntity>> getMissingReasons() async {
    final rawReportTypes = await remoteDataProvider.readMissingCatagories();
    return List<MissingReasonEntity>.from(rawReportTypes.map(
        (missingReasonModel) =>
            MissingReasonEntity.fromModel(missingReasonModel)));
  }
}
