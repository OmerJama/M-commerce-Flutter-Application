import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/category_model.dart';

void main() {
  test(
    "Adding a category name to the model",
    () {
      const name = "Shirts";
      const imageUrl = "http://exampleimageurl.com";

      final category = Category(name: name, imageUrl: imageUrl);

      expect(category.name, name);
      expect(category.imageUrl, imageUrl);
    },
  );
}
