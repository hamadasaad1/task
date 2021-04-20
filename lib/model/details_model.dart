
import 'dart:convert';

ProductsDetailsModel productsDetailsModelFromJson(String str) => ProductsDetailsModel.fromJson(json.decode(str));

String productsDetailsModelToJson(ProductsDetailsModel data) => json.encode(data.toJson());

class ProductsDetailsModel {
  ProductsDetailsModel({
    this.status,
    this.code,
    this.data,
  });

  String status;
  int code;
  Data data;

  factory ProductsDetailsModel.fromJson(Map<String, dynamic> json) => ProductsDetailsModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.product,
  });

  List<Product> product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
