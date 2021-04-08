import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/report_type_repository.dart';
import '../../entities/report_type.dart';

part 'report_type_state.dart';

class ReportTypeCubit extends Cubit<ReportTypeState> {
  final ReportTypeRepository reportTypeRepository;

  ReportTypeCubit({required this.reportTypeRepository})
      : super(ReportTypeFetchInProgress());

  Future<void> getReportTypes() async {
    final reportTypes = await reportTypeRepository.getReportTypes();
    emit(ReportTypeFetchSuccess(reportTypes));
  }
}
