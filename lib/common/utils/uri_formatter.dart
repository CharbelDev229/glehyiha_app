import '../constants/strings.dart';

class UriFormatter {
  String endpoint;
  Map<String, dynamic> extras;
  DataControls? controls;
  final String baseUrl;

  UriFormatter(this.endpoint,
      {this.extras = const {},
      this.controls,
      this.baseUrl = AppStrings.apiBaseUrl});

  Uri format() {
    String base = baseUrl + endpoint;

    String extraString = '';

    Map<String, dynamic> map = {};

    if (controls != null) {
      map.addAll(controls!.toMap());
    }

    if (extras.isNotEmpty) {
      map.addAll(extras);
    }

    int i = 0;

    for (var entry in map.entries) {
      i++;

      if (entry.value != null && entry.value != 'null') {
        if (i == 1 || extraString.isEmpty) {
          extraString += '?';
        }
        extraString += '${entry.key}=${entry.value}';

        if (i < map.length) {
          extraString += '&';
        }
      }
    }

    Uri url = Uri.parse(base + extraString);

    return url;
  }
}

class DataControls {
  final int? page;
  final int? pageSize;
  final String? sortBy;
  final String? order;

  DataControls({this.page, this.pageSize, this.sortBy, this.order});

  Map<String, dynamic> toMap() => {
        'page': page,
        'pageSize': pageSize,
        'sortBy': sortBy,
        'order': order,
      };
}
