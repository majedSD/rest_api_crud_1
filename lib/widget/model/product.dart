class Product {
  final String id;
  final String ProductName;
  final String ProductCode;
  final String Image;
  final String UnitPrice;
  final String Quantity;
  final String TotalPrice;

  Product(
      this.id,
      this.ProductName,
      this.ProductCode,
      this.Image,
      this.UnitPrice,
      this.Quantity,
      this.TotalPrice);
  factory Product.fromJson(Map<String,dynamic>jsonResponse){
    return Product(
      jsonResponse['_id']??'',
      jsonResponse['ProductName']??'',
      jsonResponse['ProductCode']??'',
      jsonResponse['Img']??'',
      jsonResponse['UnitPrice']??'',
      jsonResponse['Qty']??'',
      jsonResponse['TotalPrice']??'',
    );
  }
  Map<String,dynamic>toJson(){
    return{
      "ProductName":ProductName,
      "ProductCode":ProductCode,
      "Img":Image,
      "UnitPrice":UnitPrice,
      "Qty":Quantity,
       "TotalPrice":TotalPrice,
  };
}
}
