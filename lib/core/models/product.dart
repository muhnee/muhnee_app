class Product {
  String testfield;

  Product({this.testfield});

  Product.fromMap(Map snapshot,String id) :
        testfield = snapshot['testfield'] ?? '';

  // toJson() {
  //   return {
  //     "price": price,
  //     "name": name,
  //     "img": img,
  //   };
  // }
}