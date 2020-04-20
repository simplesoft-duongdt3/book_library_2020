class CategoryResponse {
  CategoryFeed _feed;

  CategoryFeed get feed => _feed;

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    _feed = json['feed'] != null ? new CategoryFeed.fromJson(json['feed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._feed != null) {
      data['feed'] = this._feed.toJson();
    }
    return data;
  }
}

class CategoryFeed {
  List<CategoryEntry> _entry;

  List<CategoryEntry> get entry => _entry;

  CategoryFeed.fromJson(Map<String, dynamic> json) {
    if (json['entry'] != null) {
      _entry = new List<CategoryEntry>();
      json['entry'].forEach((v) {
        _entry.add(new CategoryEntry.fromJson(v));
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

class CategoryEntry {
  CategoryGsxId _gsxId;
  CategoryGsxId _gsxName;


  CategoryGsxId get gsxId => _gsxId;
  CategoryGsxId get gsxName => _gsxName;

  CategoryEntry.fromJson(Map<String, dynamic> json) {
    _gsxId = json['gsx\$id'] != null ? new CategoryGsxId.fromJson(json['gsx\$id']) : null;
    _gsxName =
    json['gsx\$name'] != null ? new CategoryGsxId.fromJson(json['gsx\$name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._gsxId != null) {
      data['gsx\$id'] = this._gsxId.toJson();
    }
    if (this._gsxName != null) {
      data['gsx\$name'] = this._gsxName.toJson();
    }
    return data;
  }
}

class CategoryGsxId {
  String _text;


  String get text => _text;

  CategoryGsxId.fromJson(Map<String, dynamic> json) {
    _text = json['\$t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$t'] = this._text;
    return data;
  }
}
