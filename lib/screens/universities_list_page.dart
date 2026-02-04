import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyba_technic_test/screens/university_detail_page.dart';

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
        title: const Text('Tyba Universities'),
        actions: [
          IconButton(
            icon: Icon(
              state.layout == LayoutType.list
                  ? Icons.grid_view
                  : Icons.view_list,
            ),
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
        child: Text(state.errorMessage!),
      );
    }

    if (state.universities.isEmpty) {
      return const Center(
        child: Text('No universities found'),
      );
    }

    return state.layout == LayoutType.list
        ? _buildList(state)
        : _buildGrid(state);
  }

  Widget _buildList(UniversitiesState state) {
    return ListView.builder(
      itemCount: state.universities.length,
      itemBuilder: (context, index) {
        final university = state.universities[index];

        return ListTile(
          title: Text(university.name),
          subtitle: Text(university.country),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UniversityDetailPage(
                  university: university,
                  index: index,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGrid(UniversitiesState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.universities.length,
      itemBuilder: (context, index) {
        final university = state.universities[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UniversityDetailPage(
                  university: university,
                  index: index,
                ),
              ),
            );
          },
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  university.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
