import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyba_technic_test/screens/university_detail_page.dart';

import '../providers/universities_state.dart';

Widget buildList(
    UniversitiesState state, WidgetRef ref, Function() onLoadMore) {
  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: state.universities.length + (state.hasMoreData ? 1 : 0),
    itemBuilder: (context, index) {
      // Detectar cuando llegamos al final
      if (index == state.universities.length) {
        // Trigger para cargar más
        if (!state.isLoadingMore) {
          Future.microtask(() => onLoadMore());
        }

        // Mostrar loading indicator
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final university = state.universities[index];

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        shadowColor: Colors.amber,
        color: const Color.fromARGB(255, 174, 229, 255),
        child: ListTile(
          title: Text(
            university.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 3, 61, 108),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 3, 61, 108),
          ),
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
        ),
      );
    },
  );
}
