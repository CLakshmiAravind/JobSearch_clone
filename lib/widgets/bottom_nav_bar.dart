import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobs_/jobs/jobs_screen.dart';
import 'package:jobs_/jobs/upload_job.dart';
import 'package:jobs_/search/profile.dart';
import 'package:jobs_/search/search_companies.dart';

class BottomNavBar extends StatelessWidget {
  int indexNum = 0;
  BottomNavBar({required this.indexNum});
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: indexNum,
      items: [
        Icon(Icons.list, color: Colors.black, size: 19),
        Icon(Icons.search, color: Colors.black, size: 19),
        Icon(Icons.add, color: Colors.black, size: 19),
        Icon(
          Icons.person,
          size: 19,
          color: Colors.black,
        )
      ],
      height: 50,
      color: Colors.purple.shade200,
      backgroundColor: Colors.orange.shade300,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => JobScreen()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SearchCompanies()));
        } else if (index == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UploadJob(),
              ));
        } else if (index == 3) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProfilePage()));
        }
      },
    );
  }
}
