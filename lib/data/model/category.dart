import 'package:equatable/equatable.dart';

/// Represents the `Category` of a `Task`
///
/// Every `Category` requires:
/// 1. id (`int`)
/// 2. name (`String`)
///
/// [Category]s are immutable and can be copied using [copyWith].
/// Also they could be converted from and to `Map` using
/// [Category.fromMap] and [toMap] respectively.
class Category extends Equatable {
  const Category({required this.id, required this.name});

  /// Converts from `map` to `Category`
  // Using constructor instead of static function because it's better practice.
  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        name = map['name'] as String;

  /// The unique identifier of the `category`
  ///
  /// Cannot be null.
  final String id;

  /// The name of the `category`
  ///
  /// Cannot be empty.
  final String name;

  /// Returns a copy of this `category` with the given values updated.
  Category copyWith({
    required String name,
  }) {
    return Category(id: id, name: name);
  }

  /// Converts from `Category` to `map`
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
