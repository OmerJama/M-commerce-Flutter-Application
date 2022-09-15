
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/product_model.dart';


void main() {
  
test('Product description matches the defined text', () {
    const description = "This is a test description";
    final product = Product(
        name: "Product",
        description: description,
        price: 12.99,
        imageUrl: "imageUrl",
        category: "category",
        largeStock: 0,
        mediumStock: 0,
        searchArray: ['test'],
        sizes: 'S,M,L',
        smallStock: 0,
        stock: 0,
        xLargeStock: 0,
        optionalId: '1'
        );
      expect(product.description, description);
  });

  test('Product category matches the defined text', () {
    const category = "This is a category";
    final product = Product(
        name: "Product",
        description: "description",
        price: 12.99,
        imageUrl: "imageUrl",
        category: category,
        largeStock: 0,
        mediumStock: 0,
        searchArray: ['test'],
        sizes: 'S,M,L',
        smallStock: 0,
        stock: 0,
        xLargeStock: 0,
        optionalId: '1'
        );
      expect(product.category, category);
  });

  test('Product price matches the defined text', () {
    const price = 12.99;
    final product = Product(
        name: "Product",
        description: "description",
        price: price,
        imageUrl: "imageUrl",
        category: "category",
        largeStock: 0,
        mediumStock: 0,
        searchArray: ['test'],
        sizes: 'S,M,L',
        smallStock: 0,
        stock: 0,
        xLargeStock: 0,
        optionalId: '1'
        );
      expect(product.price, price);
  });

  

}
