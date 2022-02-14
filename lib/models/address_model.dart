class Address {
  Info? info;
  Options? options;
  List<Results>? results;

  Address({this.info, this.options, this.results});

  Address.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {}
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? statuscode;
  Copyright? copyright;
  List<String>? messages;

  Info({this.statuscode, this.copyright, this.messages});

  Info.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    copyright = json['copyright'] != null
        ? new Copyright.fromJson(json['copyright'])
        : null;
    if (json['messages'] != null) {
      messages = <String>[];
      json['messages'].forEach((v) {});
    }
  }
}

class Copyright {
  String? text;
  String? imageUrl;
  String? imageAltText;

  Copyright({this.text, this.imageUrl, this.imageAltText});

  Copyright.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    imageUrl = json['imageUrl'];
    imageAltText = json['imageAltText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['imageUrl'] = this.imageUrl;
    data['imageAltText'] = this.imageAltText;
    return data;
  }
}

class Options {
  int? maxResults;
  bool? thumbMaps;
  bool? ignoreLatLngInput;

  Options({this.maxResults, this.thumbMaps, this.ignoreLatLngInput});

  Options.fromJson(Map<String, dynamic> json) {
    maxResults = json['maxResults'];
    thumbMaps = json['thumbMaps'];
    ignoreLatLngInput = json['ignoreLatLngInput'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxResults'] = this.maxResults;
    data['thumbMaps'] = this.thumbMaps;
    data['ignoreLatLngInput'] = this.ignoreLatLngInput;
    return data;
  }
}

class Results {
  ProvidedLocation? providedLocation;
  List<Locations>? locations;

  Results({this.providedLocation, this.locations});

  Results.fromJson(Map<String, dynamic> json) {
    providedLocation = json['providedLocation'] != null
        ? new ProvidedLocation.fromJson(json['providedLocation'])
        : null;
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providedLocation != null) {
      data['providedLocation'] = this.providedLocation!.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvidedLocation {
  String? location;

  ProvidedLocation({this.location});

  ProvidedLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    return data;
  }
}

class Locations {
  String? street;
  String? adminArea6;
  String? adminArea6Type;
  String? adminArea5;
  String? adminArea5Type;
  String? adminArea4;
  String? adminArea4Type;
  String? adminArea3;
  String? adminArea3Type;
  String? adminArea1;
  String? adminArea1Type;
  String? postalCode;
  String? geocodeQualityCode;
  String? geocodeQuality;
  bool? dragPoint;
  String? sideOfStreet;
  String? linkId;
  String? unknownInput;
  String? type;
  LatLng? latLng;
  LatLng? displayLatLng;
  String? mapUrl;

  Locations(
      {this.street,
      this.adminArea6,
      this.adminArea6Type,
      this.adminArea5,
      this.adminArea5Type,
      this.adminArea4,
      this.adminArea4Type,
      this.adminArea3,
      this.adminArea3Type,
      this.adminArea1,
      this.adminArea1Type,
      this.postalCode,
      this.geocodeQualityCode,
      this.geocodeQuality,
      this.dragPoint,
      this.sideOfStreet,
      this.linkId,
      this.unknownInput,
      this.type,
      this.latLng,
      this.displayLatLng,
      this.mapUrl});

  Locations.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    adminArea6 = json['adminArea6'];
    adminArea6Type = json['adminArea6Type'];
    adminArea5 = json['adminArea5'];
    adminArea5Type = json['adminArea5Type'];
    adminArea4 = json['adminArea4'];
    adminArea4Type = json['adminArea4Type'];
    adminArea3 = json['adminArea3'];
    adminArea3Type = json['adminArea3Type'];
    adminArea1 = json['adminArea1'];
    adminArea1Type = json['adminArea1Type'];
    postalCode = json['postalCode'];
    geocodeQualityCode = json['geocodeQualityCode'];
    geocodeQuality = json['geocodeQuality'];
    dragPoint = json['dragPoint'];
    sideOfStreet = json['sideOfStreet'];
    linkId = json['linkId'];
    unknownInput = json['unknownInput'];
    type = json['type'];
    latLng =
        json['latLng'] != null ? new LatLng.fromJson(json['latLng']) : null;
    displayLatLng = json['displayLatLng'] != null
        ? new LatLng.fromJson(json['displayLatLng'])
        : null;
    mapUrl = json['mapUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['adminArea6'] = this.adminArea6;
    data['adminArea6Type'] = this.adminArea6Type;
    data['adminArea5'] = this.adminArea5;
    data['adminArea5Type'] = this.adminArea5Type;
    data['adminArea4'] = this.adminArea4;
    data['adminArea4Type'] = this.adminArea4Type;
    data['adminArea3'] = this.adminArea3;
    data['adminArea3Type'] = this.adminArea3Type;
    data['adminArea1'] = this.adminArea1;
    data['adminArea1Type'] = this.adminArea1Type;
    data['postalCode'] = this.postalCode;
    data['geocodeQualityCode'] = this.geocodeQualityCode;
    data['geocodeQuality'] = this.geocodeQuality;
    data['dragPoint'] = this.dragPoint;
    data['sideOfStreet'] = this.sideOfStreet;
    data['linkId'] = this.linkId;
    data['unknownInput'] = this.unknownInput;
    data['type'] = this.type;
    if (this.latLng != null) {
      data['latLng'] = this.latLng!.toJson();
    }
    if (this.displayLatLng != null) {
      data['displayLatLng'] = this.displayLatLng!.toJson();
    }
    data['mapUrl'] = this.mapUrl;
    return data;
  }
}

class LatLng {
  double? lat;
  double? lng;

  LatLng({this.lat, this.lng});

  LatLng.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
