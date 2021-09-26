class User {
  int id = 0;
  int lastModified = 0;
  int effective = 0;
  String flagUrl = "";
  String title = "";
  bool warning = false;
  bool partialWarning = false;
  bool situationWarning = false;
  bool situationPartWarning = false;
  String lastChanges = "";
  String content = "";

  User(this.id, this.lastModified, this.effective, this.flagUrl, this.title, this.warning, this.partialWarning, this.situationWarning, this.situationPartWarning, this.lastChanges, this.content);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastModified = json['lastModified'];
    effective = json['effective'];
    flagUrl = json['flagUrl'];
    title = json['title'];
    warning = json['warning'];
    partialWarning = json['partialWarning'];
    situationWarning = json['situationWarning'];
    situationPartWarning = json['situationPartWarning'];
    lastChanges = json['lastChanges'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastModified'] = this.lastModified;
    data['effective'] = this.effective;
    data['flagUrl'] = this.flagUrl;
    data['title'] = this.title;
    data['warning'] = this.warning;
    data['partialWarning'] = this.partialWarning;
    data['situationWarning'] = this.situationWarning;
    data['situationPartWarning'] = this.situationPartWarning;
    data['lastChanges'] = this.lastChanges;
    data['content'] = this.content;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastModified'] = this.lastModified;
    data['effective'] = this.effective;
    data['flagUrl'] = this.flagUrl;
    data['title'] = this.title;

    /*bool warning
    bool partialWarning
    bool situationWarning
    bool situationPartWarning */
    if (this.warning == true) {
      data['warning'] = 1;
    } else {
      data['warning'] = 0;
    }
    if (this.partialWarning == true) {
      data['partialWarning'] = 1;
    } else {
      data['partialWarning'] = 0;
    }
    if (this.situationWarning == true) {
      data['situationWarning'] = 1;
    } else {
      data['situationWarning'] = 0;
    }
    if (this.situationPartWarning == true) {
      data['situationPartWarning'] = 1;
    } else {
      data['situationPartWarning'] = 0;
    }

    data['lastChanges'] = this.lastChanges;
    data['content'] = this.content;
    return data;
  }

  User.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    lastModified = json['lastModified'];
    effective = json['effective'];
    flagUrl = json['flagUrl'];
    title = json['title'];

    /*bool warning
    bool partialWarning
    bool situationWarning
    bool situationPartWarning */
    if (json['warning'] == 1) {
      this.warning = true;
    } else {
      this.warning = false;
    }
    if (json['partialWarning'] == 1) {
      this.partialWarning = true;
    } else {
      this.partialWarning = false;
    }
    if (json['situationWarning'] == 1) {
      this.situationWarning = true;
    } else {
      this.situationWarning = false;
    }
    if (json['situationPartWarning'] == 1) {
      this.situationPartWarning = true;
    } else {
      this.situationPartWarning = false;
    }

    lastChanges = json['lastChanges'];
    content = json['content'];
  }
}
