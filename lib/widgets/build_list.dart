import 'package:flutter/material.dart';
import 'package:tyba_technic_test/screens/university_detail_page.dart';

import '../providers/universities_state.dart';

Widget buildList(UniversitiesState state) {
  return ListView.builder(
    itemCount: state.universities.length,
    itemBuilder: (context, index) {
      final university = state.universities[index];

      return ListTile(
        hoverColor: const Color.fromARGB(255, 174, 229, 255),
        iconColor: const Color.fromARGB(255, 3, 61, 108),
        textColor: const Color.fromARGB(255, 2, 41, 73),
        splashColor: const Color.fromARGB(255, 182, 230, 252),
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
