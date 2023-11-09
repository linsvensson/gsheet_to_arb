/*
 * Copyright (c) 2020, Marek Gocał
 * All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */

class ArbDocument {
  String? locale;
  DateTime? lastModified;
  List<ArbResource> entries = <ArbResource>[];

  ArbDocument(this.locale, this.lastModified, this.entries);

  Map<String, Object> toJson({bool compact = false}) {
    final json = <String, Object>{};

    entries.forEach((ArbResource resource) {
      json[resource.key] = resource.value;
    });

    return json;
  }

  ArbDocument.fromJson(Map<String, dynamic> _json) {
    var entriesMap = <String, ArbResource>{};
    entries = <ArbResource>[];

    _json.forEach((key, value) {
      var entry = ArbResource(key, value);
      entries.add(entry);
      entriesMap[key] = entry;
    });
  }
}

class ArbResource {
  final String key;
  final String value;
  final Map<String, Object> attributes = {};
  final List<ArbResourcePlaceholder>? placeholders;
  final String? description;
  final String? context;

  ArbResource(String key, String value,
      {this.description = '', this.context = '', this.placeholders = const []})
      : key = key,
        value = value;
}

class ArbResourcePlaceholder {
  static String typeText = 'text';
  static String typeNum = 'num';

  final String name;
  final String? type;
  final String? description;
  final String? example;

  ArbResourcePlaceholder({
    required this.name,
    this.type,
    this.description,
    this.example,
  });
}

class ArbBundle {
  final List<ArbDocument> documents;

  ArbBundle(this.documents);
}

class ArbDocumentBuilder {
  String locale;
  DateTime lastModified;
  List<ArbResource> entries = [];

  ArbDocumentBuilder(this.locale, this.lastModified);

  ArbDocument build() {
    final bundle = ArbDocument(locale, lastModified, entries);
    return bundle;
  }

  ArbDocumentBuilder add(ArbResource entry) {
    entries.add(entry);
    return this;
  }
}
