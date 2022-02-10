class Picture {
  final String name, path;
  Picture(this.name, this.path);
  factory Picture.fromMap(Map<String, dynamic> json) {
    return Picture(json['name'], json['image']);
  }
}
