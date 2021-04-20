// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    this.status,
    this.code,
    this.productsCount,
    this.lastPage,
    this.data,
  });

  String status;
  int code;
  int productsCount;
  int lastPage;
  Data data;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    status: json["status"],
    code: json["code"],
    productsCount: json["products_count"],
    lastPage: json["last_page"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "products_count": productsCount,
    "last_page": lastPage,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.products,
  });

  List<Products> products;
  List<Products> productsResponseFromJson(String str) =>
      List<Products>.from(
          json.decode(str).map((x) => Products.fromJson(x)));
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<Products>.from(json["products"].map((x) => Products.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Products {
  Products({
    this.id,
    this.productName,
    this.mainImg,
    this.price,
    this.photo,
  });

  int id;
  String productName;
  String mainImg;
  String price;
  String photo;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    productName: json["product_name"],
    mainImg: json["main_img"],
    price: json["price"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "main_img": mainImg,
    "price": price,
    "photo": photo,
  };
}
