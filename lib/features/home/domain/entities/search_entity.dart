class SearchEntity {
  const SearchEntity({
    required this.value,
    required this.page,
    required this.perPage
  });

  final String value;
  final int page;
  final int perPage;
}
