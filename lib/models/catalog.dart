class CatalogModel {


  // static final catModel = CatalogModel._internal();

  // CatalogModel._internal();

  // factory CatalogModel() => CatalogModel();

  static List<Item> items = [];

  //get Item by ID
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  //get Item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.color,
      required this.image});

  factory Item.fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    return Item(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        price: map["price"],
        color: map["color"],
        image: map["image"]);
    //throw UnimplementedError();
  }

  

  toMap() => {
        "id": id,
        "name": name,
        "desc": id,
        "price": price,
        "color": color,
        "image": image
      };
}
