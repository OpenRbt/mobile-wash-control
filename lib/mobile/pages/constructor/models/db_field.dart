class DbField {
  final String name;
  final String type;
  final bool optional;
  final bool unique;

  DbField({
    required this.name,
    required this.type,
    required this.optional,
    required this.unique,
  });
}
