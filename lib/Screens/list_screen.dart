import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/models/search_result.dart';
import 'package:professor_review/screens/profile_screens/professor_profile_screen.dart';
import 'package:professor_review/screens/profile_screens/university_profile_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<SearchResult>(
            textStyle: TextStyle(
              color: Theme.of(context).primaryColorLight, 
              fontWeight: FontWeight.w600,
            ),
            hintText: "Search professors or universities",
            iconActiveColor: Colors.white,
            onSearch:
                DatabaseService.instance.fetchUniversitiesAndProfessorsByName,
            onItemFound: (SearchResult result, int index) {
              Function onTap;
              if (result.isUniversity) {
                onTap = () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider(
                            create: (_) => DatabaseService.instance
                                .university(result.reference),
                            child: UniversityProfileScreen())));
              } else {
                onTap = () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider(
                            create: (_) => DatabaseService.instance
                                .professor(result.reference),
                            child: ProfessorProfileScreen())));
              }
              return GestureDetector(
                onTap: onTap,
                child: ListTile(
                  title: Text(result.title,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800)),
                  subtitle: Text(result.additionalInformation,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
