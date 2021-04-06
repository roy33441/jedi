import 'package:jedi/data/data_providers/missing_reason_data_provider.dart';
import 'package:jedi/logic/entities/missing_reason.dart';

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
