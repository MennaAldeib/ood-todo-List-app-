
// category_service.dart
import 'package:hive/hive.dart';
import 'hivecategory.dart';

class CategoryService {
  static const String _boxName = 'categoryBox';

  // open category box
  Future<Box<Category>> _openBox() async {
    return await Hive.openBox<Category>(_boxName);
  }

  // create new category (Create)
  Future<void> createCategory(Category category) async {
    final box = await _openBox();
    await box.put(category.categoryID, category);
  }

  // read all categories (Read) operation
  Future<List<Category>> getCategories() async {
    final box = await _openBox();
    return box.values.toList();
  }

  //  update category (Update)
  Future<void> updateCategory(String categoryID, Category updatedCategory) async {
    final box = await _openBox();
    await box.put(categoryID, updatedCategory);
  }

  // delete category (Delete)
  Future<void> deleteCategory(String categoryID) async {
    final box = await _openBox();
    await box.delete(categoryID);
  }
}



