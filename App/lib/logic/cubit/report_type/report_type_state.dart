part of 'report_type_cubit.dart';

abstract class ReportTypeState extends Equatable {
  const ReportTypeState();

  @override
  List<Object> get props => [];
}

class ReportTypeFetchInProgress extends ReportTypeState {}

class ReportTypeFetchSuccess extends ReportTypeState {
  final List<ReportTypeEntity> reportTypes;

  ReportTypeFetchSuccess(this.reportTypes);

  @override
  List<Object> get props => [reportTypes];
}
