# AA Reisewarnungen

Inofficial app containing Travelwarnings issued by [Auswärtiges Amt](https://www.auswaertiges-amt.de/en) (German Federal Foreign Office) in German.

See here for the **API** docs: [travelwarning.api.bund.dev](https://travelwarning.api.bund.dev/)

Code based on this source: https://github.com/AkilaS8/Searching-ListView-Flutter/ plus sources named inline in code comments.

I created this app when learning the basics of dart and flutter.

**Notice**: this app is not meant to be used in commercial or productive environments of any kind. Don't take the information displayed in the app as a source of trust or evidence in a official investigation. The author does not provide you as a user with any guarantee or waranty. Use only at your own risk.

## Contributing

Feel to contribute to the development of this app by opening issues or merge requests.

Please see below for pointers.

## TODO

* add app icon -> help needed!
* add metadata e.g. using [fastlane](https://gitlab.com/-/snippets/1895688) structure
    * description
    * screenshots, feature graphic, ...
* further improve tablet layout -> attempts using Slivers failed due to huge unexpected gaps in layout
* add SQLite storage backend -> see [db_provider.dart](https://raw.githubusercontent.com/eUgEntOptIc44/AAReisewarnungen/main/lib/providers/db_provider.dart) -> help needed! -> high priority
* add [representatives](https://www.auswaertiges-amt.de/opendata/representativesInCountry) API endpoint as well
* cache items using SQLite db to
    * reduce API requests and 
    * start linking data -> representatives & travelwarnings
* make travelwarning content selectable -> waiting for upstream changes (as of October 2021)
* fix the dev docker image -> [.gitpod.Dockerfile](https://raw.githubusercontent.com/eUgEntOptIc44/AAReisewarnungen/main/.gitpod.Dockerfile)
* test iOS builds -> have no apple developer account myself :(
* ...
* future: when reaching productive state -> submission to F-Droid store

## Copyright

All displayed information within the app is under copyright of [Auswärtiges Amt](https://www.auswaertiges-amt.de/en) (German Federal Foreign Office).

The author nor the app itself is affiliated with the [Auswärtiges Amt](https://www.auswaertiges-amt.de/en) in any way.

Please also see [Open Data – Schnittstelle des Auswärtigen Amts](https://www.auswaertiges-amt.de/de/open-data-schnittstelle/736118) for the terms & conditions for the usage of their API.

