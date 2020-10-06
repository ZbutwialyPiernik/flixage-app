class PageResponse<T> {
  final List<T> items;
  final int total;

  PageResponse({this.items, this.total});

  factory PageResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    final items = json['items'] as List<dynamic>;

    return PageResponse<T>(
        total: json['total'] as int,
        items: List<T>.from(items.map((item) => fromJson(item))));
  }
}
