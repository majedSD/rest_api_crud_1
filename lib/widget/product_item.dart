import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_crud_1/screens/add_new_product_screen.dart';
import 'model/product.dart';

class ProductItem extends StatefulWidget {
   ProductItem({
    Key? key,
    required this.product,
    required this.GetRequest(String id),
  }) : super(key: key);

  final Product product;
  final Function(String id) GetRequest;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Text("Edit"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddNewProductScreen(product: widget.product),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 2),
                  ListTile(
                    leading: const Text("Delete"),
                    trailing: Icon(Icons.delete),
                    onTap: () {
                      Navigator.pop(context);
                      widget.GetRequest(widget.product.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      leading: SizedBox(
        width: 50, // Adjust the width according to your needs
        height: 50,
        child: Image.network(
          widget.product.Image,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(widget.product.ProductName),
      subtitle: Text(widget.product.ProductCode),
      trailing: Text("Total Price ${widget.product.TotalPrice}"),
      textColor: Colors.black,
    );
  }
}
