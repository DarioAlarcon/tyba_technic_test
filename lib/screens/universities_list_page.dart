import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyba_technic_test/widgets/build_list.dart';
import 'package:tyba_technic_test/widgets/build_grid.dart';

import '../providers/universities_provider.dart';
import '../providers/universities_state.dart';

class UniversitiesListPage extends ConsumerStatefulWidget {
  const UniversitiesListPage({super.key});

  @override
  ConsumerState<UniversitiesListPage> createState() =>
      _UniversitiesListPageState();
}

class _UniversitiesListPageState extends ConsumerState<UniversitiesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(universitiesProvider.notifier).loadUniversities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(universitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tyba Universities',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF157DFF),
        shadowColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(
                state.layout == LayoutType.list
                    ? Icons.grid_view
                    : Icons.view_list,
                color: Colors.white),
            onPressed: () {
              ref.read(universitiesProvider.notifier).toggleLayout();
            },
          ),
        ],
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(UniversitiesState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(universitiesProvider.notifier).loadUniversities();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.universities.isEmpty) {
      return const Center(
        child: Text('No universities found'),
      );
    }

    // 👇 Aquí pasamos el callback para cargar más
    return state.layout == LayoutType.list
        ? buildList(
            state,
            ref,
            () => ref.read(universitiesProvider.notifier).loadMore(),
          )
        : buildGrid(
            state,
            ref,
            () => ref.read(universitiesProvider.notifier).loadMore(),
          );
  }
}
