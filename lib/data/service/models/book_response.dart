class BookResponse {
  BookFeed _feed;

  BookFeed get feed => _feed;

  BookResponse.fromJson(Map<String, dynamic> json) {
    _feed = json['feed'] != null ? new BookFeed.fromJson(json['feed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._feed != null) {
      data['feed'] = this._feed.toJson();
    }
    return data;
  }
}

class BookFeed {
  List<BookEntry> _entry;

  List<BookEntry> get entry => _entry;

  BookFeed.fromJson(Map<String, dynamic> json) {
    if (json['entry'] != null) {
      _entry = new List<BookEntry>();
      json['entry'].forEach((v) {
        _entry.add(new BookEntry.fromJson(v));
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

class BookEntry {
  BookGsxName _gsxId;
  BookGsxName _gsxName;
  BookGsxName _gsxAuthor;
  BookGsxName _gsxThumburl;
  BookGsxName _gsxImageurl;
  BookGsxName _gsxDescription;
  BookGsxName _gsxCategoryId;
  BookGsxName _gsxCategoryName;
  BookGsxName _gsxImageRatio;
  BookGsxName _gsxReleaseTime;
  BookGsxName _gsxLanguage;
  BookGsxName _gsxPageCount;
  BookGsxName _gsxUpdateDate;

  BookGsxName get gsxId => _gsxId;
  BookGsxName get gsxName => _gsxName;
  BookGsxName get gsxAuthor => _gsxAuthor;
  BookGsxName get gsxThumburl => _gsxThumburl;
  BookGsxName get gsxImageurl => _gsxImageurl;
  BookGsxName get gsxDescription => _gsxDescription;
  BookGsxName get gsxCategoryId => _gsxCategoryId;
  BookGsxName get gsxCategoryName=> _gsxCategoryName;
  BookGsxName get gsxImageRatio=> _gsxImageRatio;
  BookGsxName get gsxReleaseTime=> _gsxReleaseTime;
  BookGsxName get gsxLanguage=> _gsxLanguage;
  BookGsxName get gsxPageCount=> _gsxPageCount;
  BookGsxName get gsxUpdateDate=> _gsxUpdateDate;

  BookEntry.fromJson(Map<String, dynamic> json) {
    _gsxPageCount = json['gsx\$pagecount'] != null
        ? new BookGsxName.fromJson(json['gsx\$pagecount'])
        : null;
    _gsxUpdateDate = json['gsx\$updatedate'] != null
        ? new BookGsxName.fromJson(json['gsx\$updatedate'])
        : null;
    _gsxLanguage = json['gsx\$language'] != null
        ? new BookGsxName.fromJson(json['gsx\$language'])
        : null;
    _gsxImageRatio = json['gsx\$imageratio'] != null
        ? new BookGsxName.fromJson(json['gsx\$imageratio'])
        : null;
    _gsxReleaseTime = json['gsx\$releasetime'] != null
        ? new BookGsxName.fromJson(json['gsx\$releasetime'])
        : null;
    _gsxCategoryId = json['gsx\$categoryid'] != null
        ? new BookGsxName.fromJson(json['gsx\$categoryid'])
        : null;
    _gsxCategoryName = json['gsx\$categoryid'] != null
        ? new BookGsxName.fromJson(json['gsx\$categoryname'])
        : null;
    _gsxId = json['gsx\$id'] != null
        ? new BookGsxName.fromJson(json['gsx\$id'])
        : null;
    _gsxName = json['gsx\$name'] != null
        ? new BookGsxName.fromJson(json['gsx\$name'])
        : null;
    _gsxAuthor = json['gsx\$author'] != null
        ? new BookGsxName.fromJson(json['gsx\$author'])
        : null;
    _gsxThumburl = json['gsx\$thumburl'] != null
        ? new BookGsxName.fromJson(json['gsx\$thumburl'])
        : null;
    _gsxImageurl = json['gsx\$imageurl'] != null
        ? new BookGsxName.fromJson(json['gsx\$imageurl'])
        : null;
    _gsxDescription = json['gsx\$description'] != null
        ? new BookGsxName.fromJson(json['gsx\$description'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._gsxLanguage != null) {
      data['gsx\$language'] = this._gsxLanguage.toJson();
    }
    if (this._gsxUpdateDate != null) {
      data['gsx\$updatedate'] = this._gsxUpdateDate.toJson();
    }
    if (this._gsxPageCount != null) {
      data['gsx\$pagecount'] = this._gsxPageCount.toJson();
    }
    if (this._gsxImageRatio != null) {
      data['gsx\$imageratio'] = this._gsxImageRatio.toJson();
    }
    if (this._gsxReleaseTime != null) {
      data['gsx\$releasetime'] = this._gsxReleaseTime.toJson();
    }
    if (this._gsxName != null) {
      data['gsx\$name'] = this._gsxName.toJson();
    }
    if (this._gsxCategoryId != null) {
      data['gsx\$categoryid'] = this._gsxCategoryId.toJson();
    }
    if (this._gsxCategoryName != null) {
      data['gsx\$categoryname'] = this._gsxCategoryName.toJson();
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

class BookGsxName {
  String _text;

  String get text => _text;

  BookGsxName.fromJson(Map<String, dynamic> json) {
    _text = json['\$t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$t'] = this._text;
    return data;
  }
}
