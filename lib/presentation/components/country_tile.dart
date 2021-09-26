import 'package:flutter/material.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/presentation/screens/country_details_page.dart';

class CountryTile extends StatelessWidget {
  final Country country;

  CountryTile({required this.country});

  /*
  String countryTitle() {
    String title = "";
    if (country.title == "Male") {
      title = "Mr.";
    } else if (country.title == "Female") {
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
              tag: country.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(country.flagUrl),
              ),
            ),
            title: Text('${country.title}'),
            subtitle: Text('${country.lastChanges}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetailsPage(country: country)));
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
