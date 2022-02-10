import 'package:miindfully/models/base.dart';
import 'package:miindfully/models/category.dart';

class CategoryBase {
  final Base base;
  final List<Category> categories;
  CategoryBase(this.base, this.categories);
  factory CategoryBase.fromMap(Map<String, dynamic> json) {
    return CategoryBase(
        Base.fromJSON(json),
        json.containsKey("response") &&
                json['response'] != null &&
                json['response'] != {}
            ? List<Map<String, dynamic>>.from(json['response']['data'])
                .map<Category>((e) => Category.fromMap(e))
                .toList()
            : <Category>[]);
  }
}
