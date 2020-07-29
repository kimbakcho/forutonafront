class PageWrap<T> {
  final List<T> content;
  final PageableWarp pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final SortWrap sort;
  final int numberOfElements;
  final bool first;
  final bool empty;

  PageWrap(
      { this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.numberOfElements,
        this.first,
        this.empty});

  factory PageWrap.fromJson(Map<String, dynamic> json, Function fromJson) {
    final items = json['content'].cast<Map<String, dynamic>>();
    return PageWrap<T>(
        pageable: json["pageable"] == null ? null : PageableWarp.fromJson(json["pageable"]),
        totalElements: json["totalElements"] == null ? null : json["totalElements"],
        totalPages: json["totalPages"] == null ? null : json["totalPages"],
        last: json["last"] == null ? null : json["last"],
        size: json["size"] == null ? null : json["size"],
        number: json["number"] == null ? null : json["number"],
        sort: json["sort"] == null ? null : SortWrap.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"] == null ? null : json["numberOfElements"],
        first: json["first"] == null ? null : json["first"],
        empty: json["empty"] == null ? null : json["empty"],
        content: new List<T>.from(
            items.map((itemsJson) => fromJson(itemsJson))));
  }
  Map<String, dynamic> toJson() => {
    "content": content == null ? null : List<dynamic>.from(content.map((x) => x)),
    "pageable": pageable == null ? null : pageable.toJson(),
    "totalElements": totalElements == null ? null : totalElements,
    "totalPages": totalPages == null ? null : totalPages,
    "last": last == null ? null : last,
    "size": size == null ? null : size,
    "number": number == null ? null : number,
    "sort": sort == null ? null : sort.toJson(),
    "numberOfElements": numberOfElements == null ? null : numberOfElements,
    "first": first == null ? null : first,
    "empty": empty == null ? null : empty,
  };

}

class PageableWarp {
  PageableWarp({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });

  final SortWrap sort;
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool unpaged;

  PageableWarp copyWith({
    SortWrap sort,
    int offset,
    int pageNumber,
    int pageSize,
    bool paged,
    bool unpaged,
  }) =>
      PageableWarp(
        sort: sort ?? this.sort,
        offset: offset ?? this.offset,
        pageNumber: pageNumber ?? this.pageNumber,
        pageSize: pageSize ?? this.pageSize,
        paged: paged ?? this.paged,
        unpaged: unpaged ?? this.unpaged,
      );

  factory PageableWarp.fromJson(Map<String, dynamic> json) => PageableWarp(
    sort: json["sort"] == null ? null : SortWrap.fromJson(json["sort"]),
    offset: json["offset"] == null ? null : json["offset"],
    pageNumber: json["pageNumber"] == null ? null : json["pageNumber"],
    pageSize: json["pageSize"] == null ? null : json["pageSize"],
    paged: json["paged"] == null ? null : json["paged"],
    unpaged: json["unpaged"] == null ? null : json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort == null ? null : sort.toJson(),
    "offset": offset == null ? null : offset,
    "pageNumber": pageNumber == null ? null : pageNumber,
    "pageSize": pageSize == null ? null : pageSize,
    "paged": paged == null ? null : paged,
    "unpaged": unpaged == null ? null : unpaged,
  };
}

class SortWrap {
  SortWrap({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  final bool sorted;
  final bool unsorted;
  final bool empty;

  SortWrap copyWith({
    bool sorted,
    bool unsorted,
    bool empty,
  }) =>
      SortWrap(
        sorted: sorted ?? this.sorted,
        unsorted: unsorted ?? this.unsorted,
        empty: empty ?? this.empty,
      );

  factory SortWrap.fromJson(Map<String, dynamic> json) => SortWrap(
    sorted: json["sorted"] == null ? null : json["sorted"],
    unsorted: json["unsorted"] == null ? null : json["unsorted"],
    empty: json["empty"] == null ? null : json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "sorted": sorted == null ? null : sorted,
    "unsorted": unsorted == null ? null : unsorted,
    "empty": empty == null ? null : empty,
  };
}