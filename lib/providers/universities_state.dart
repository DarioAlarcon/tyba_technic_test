import '../models/university.dart';

enum LayoutType { list, grid }

class UniversitiesState {
  final List<University> universities;
  final bool isLoading;
  final LayoutType layout;
  final String? errorMessage;

  const UniversitiesState({
    required this.universities,
    required this.isLoading,
    required this.layout,
    this.errorMessage,
  });

  factory UniversitiesState.initial() {
    return const UniversitiesState(
      universities: [],
      isLoading: false,
      layout: LayoutType.list,
      errorMessage: null,
    );
  }

  UniversitiesState copyWith({
    List<University>? universities,
    bool? isLoading,
    LayoutType? layout,
    String? errorMessage,
  }) {
    return UniversitiesState(
      universities: universities ?? this.universities,
      isLoading: isLoading ?? this.isLoading,
      layout: layout ?? this.layout,
      errorMessage: errorMessage,
    );
  }
}
