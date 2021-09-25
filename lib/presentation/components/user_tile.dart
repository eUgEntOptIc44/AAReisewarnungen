import 'package:flutter/material.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/presentation/screens/user_details_page.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile({required this.user});

  /*
  String userTitle() {
    String title = "";
    if (user.title == "Male") {
      title = "Mr.";
    } else if (user.title == "Female") {
      title = "Ms.";
    }
    return title;
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: user.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.flagUrl),
              ),
            ),
            title: Text('${user.title}'),
            subtitle: Text('${user.lastChanges}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsPage(user: user)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
