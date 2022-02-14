class PlaceAddress {
  Pagination? pagination;
  Request? request;
  List<Results>? results;

  PlaceAddress({this.pagination, this.request, this.results});

  PlaceAddress.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  String? nextUrl;
  int? currentPage;

  Pagination({this.nextUrl, this.currentPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    nextUrl = json['nextUrl'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextUrl'] = this.nextUrl;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Request {
  String? sort;
  int? pageSize;
  int? page;
  bool? feedback;
  String? key;
  String? q;
  List<double>? location;

  Request(
      {this.sort,
      this.pageSize,
      this.page,
      this.feedback,
      this.key,
      this.q,
      this.location});

  Request.fromJson(Map<String, dynamic> json) {
    sort = json['sort'];
    pageSize = json['pageSize'];
    page = json['page'];
    feedback = json['feedback'];
    key = json['key'];
    q = json['q'];
    location = json['location'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort'] = this.sort;
    data['pageSize'] = this.pageSize;
    data['page'] = this.page;
    data['feedback'] = this.feedback;
    data['key'] = this.key;
    data['q'] = this.q;
    data['location'] = this.location;
    return data;
  }
}

class Results {
  String? id;
  String? displayString;
  String? name;
  String? slug;
  String? language;
  Place? place;

  Results(
      {this.id,
      this.displayString,
      this.name,
      this.slug,
      this.language,
      this.place});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayString = json['displayString'];
    name = json['name'];
    slug = json['slug'];
    language = json['language'];
    place = json['place'] != null ? new Place.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayString'] = this.displayString;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['language'] = this.language;
    if (this.place != null) {
      data['place'] = this.place!.toJson();
    }
    return data;
  }
}

class Place {
  String? type;
  Geometry? geometry;
  Properties? properties;

  Place({this.type, this.geometry, this.properties});

  Place.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    return data;
  }
}

class Geometry {
  List<double>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  Geometry.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['type'] = this.type;
    return data;
  }
}

class Properties {
  String? city;
  String? stateCode;
  String? postalCode;
  String? countryCode;
  String? street;
  String? type;

  Properties(
      {this.city,
      this.stateCode,
      this.postalCode,
      this.countryCode,
      this.street,
      this.type});

  Properties.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    stateCode = json['stateCode'];
    postalCode = json['postalCode'];
    countryCode = json['countryCode'];
    street = json['street'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['stateCode'] = this.stateCode;
    data['postalCode'] = this.postalCode;
    data['countryCode'] = this.countryCode;
    data['street'] = this.street;
    data['type'] = this.type;
    return data;
  }
}
