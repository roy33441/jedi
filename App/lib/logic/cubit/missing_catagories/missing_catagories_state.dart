part of 'missing_catagories_cubit.dart';

class MissingCatagoriesState extends Equatable {
  final String selectedValue;
  static const List<String> _catagories = [
    "התמקצעות",
    "התמקצעות",
    "התמקצעות",
    "התמקצעות",
    "התמקצעות",
  ];

  MissingCatagoriesState({
    this.selectedValue,
  });

  MissingCatagoriesState copyWith({
    String? selectedValue,
  }) {
    return MissingCatagoriesState(
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }

  @override
  List<Object?> get props => [selectedValue];
}
