class Healthcare {
/* "251022": {
      "lastModified": 1554106996,
      "name": "Expositionsprophylaxe - Verhütung von Infektionskrankheiten durch Schutz vor Insektenstichen",
      "url": "https://www.auswaertiges-amt.de/blob/251022/943b4cd16cd1693bcdd2728ef29b85a7/expositionsprophylaxeinsektenstiche-data.pdf"
    }, */

  int id = 0;
  int lastModified = 0;
  String name = "";
  String url = "";

  Healthcare(this.id, this.lastModified, this.name, this.url);

  Healthcare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastModified = json['lastModified'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastModified'] = this.lastModified;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
