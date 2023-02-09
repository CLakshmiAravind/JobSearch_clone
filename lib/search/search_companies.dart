import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class SearchCompanies extends StatefulWidget {
  const SearchCompanies({super.key});

  @override
  State<SearchCompanies> createState() => _SearchCompaniesState();
}

class _SearchCompaniesState extends State<SearchCompanies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange.shade300, Colors.purple.shade300],
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 0.9])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade300, Colors.purple.shade300],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 0.9],
              ),
            ),
            child: Text("search"),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavBar(indexNum: 1,),
      ),
    );
  }
}
