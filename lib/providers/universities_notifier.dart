import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/university_service.dart';
import '../models/university.dart';
import 'universities_state.dart';

class UniversitiesNotifier extends StateNotifier<UniversitiesState> {
  UniversitiesNotifier(this._service) : super(UniversitiesState.initial());

  final UniversityService _service;

  Future<void> loadUniversities() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final universities = await _service.fetchUniversities();

      state = state.copyWith(
        universities: universities,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load universities',
      );
    }
  }

  void toggleLayout() {
    state = state.copyWith(
      layout:
          state.layout == LayoutType.list ? LayoutType.grid : LayoutType.list,
    );
  }

  void updateUniversity(int index, University updated) {
    final list = [...state.universities];
    list[index] = updated;

    state = state.copyWith(universities: list);
  }
}
