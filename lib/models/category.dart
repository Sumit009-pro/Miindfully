class Category {
  final String categoryID, category, imageURL;
  Category(this.category, this.imageURL, this.categoryID);
  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(json['name'], json['image'], json['_id']);
  }
}
