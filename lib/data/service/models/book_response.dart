class BookResponse {
  Feed _feed;

  Feed get feed => _feed;

  BookResponse.fromJson(Map<String, dynamic> json) {
    _feed = json['feed'] != null ? new Feed.fromJson(json['feed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._feed != null) {
      data['feed'] = this._feed.toJson();
    }
    return data;
  }
}

class Feed {
  List<Entry> _entry;

  List<Entry> get entry => _entry;

  Feed.fromJson(Map<String, dynamic> json) {
    if (json['entry'] != null) {
      _entry = new List<Entry>();
      json['entry'].forEach((v) {
        _entry.add(new Entry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._entry != null) {
      data['entry'] = this._entry.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entry {
  GsxName _gsxId;
  GsxName _gsxName;
  GsxName _gsxAuthor;
  GsxName _gsxThumburl;
  GsxName _gsxImageurl;
  GsxName _gsxDescription;

  GsxName get gsxId => _gsxId;
  GsxName get gsxName => _gsxName;
  GsxName get gsxAuthor => _gsxAuthor;
  GsxName get gsxThumburl => _gsxThumburl;
  GsxName get gsxImageurl => _gsxImageurl;
  GsxName get gsxDescription => _gsxDescription;

  Entry.fromJson(Map<String, dynamic> json) {
    _gsxId = json['gsx\$id'] != null
        ? new GsxName.fromJson(json['gsx\$id'])
        : null;
    _gsxName = json['gsx\$name'] != null
        ? new GsxName.fromJson(json['gsx\$name'])
        : null;
    _gsxAuthor = json['gsx\$author'] != null
        ? new GsxName.fromJson(json['gsx\$author'])
        : null;
    _gsxThumburl = json['gsx\$thumburl'] != null
        ? new GsxName.fromJson(json['gsx\$thumburl'])
        : null;
    _gsxImageurl = json['gsx\$imageurl'] != null
        ? new GsxName.fromJson(json['gsx\$imageurl'])
        : null;
    _gsxDescription = json['gsx\$description'] != null
        ? new GsxName.fromJson(json['gsx\$description'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._gsxName != null) {
      data['gsx\$name'] = this._gsxName.toJson();
    }
    if (this._gsxId != null) {
      data['gsx\$id'] = this._gsxId.toJson();
    }
    if (this._gsxAuthor != null) {
      data['gsx\$author'] = this._gsxAuthor.toJson();
    }
    if (this._gsxThumburl != null) {
      data['gsx\$thumburl'] = this._gsxThumburl.toJson();
    }
    if (this._gsxImageurl != null) {
      data['gsx\$imageurl'] = this._gsxImageurl.toJson();
    }
    if (this._gsxDescription != null) {
      data['gsx\$description'] = this._gsxDescription.toJson();
    }
    return data;
  }
}

class GsxName {
  String _text;

  String get text => _text;

  GsxName.fromJson(Map<String, dynamic> json) {
    _text = json['\$t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$t'] = this._text;
    return data;
  }
}
