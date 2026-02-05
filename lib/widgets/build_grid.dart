import 'package:flutter/material.dart';
import 'package:tyba_technic_test/screens/university_detail_page.dart';

import '../providers/universities_state.dart';

Widget buildGrid(UniversitiesState state) {
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
          shadowColor: Colors.amber,
          color: const Color.fromARGB(255, 174, 229, 255),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                university.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 3, 61, 108)),
              ),
            ),
          ),
        ),
      );
    },
  );
}
