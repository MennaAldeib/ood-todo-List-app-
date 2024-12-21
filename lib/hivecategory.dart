
import 'package:hive/hive.dart';

part 'hivecategory.g.dart' ;

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  String categoryID;

  @HiveField(1)
  String type;

  Category({
    required this.categoryID,
    required this.type,
  });
}
