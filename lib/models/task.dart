class Task {
  int id;
  String name;
  String description;

  Task({
    this.id = -1,
    required this.name,
    required this.description,
  });

  Task copyWith({int? id, String? name, String? description}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
