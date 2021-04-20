import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/model/details_model.dart';
import 'package:task/provider/details_provider.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "details_screen";
  final String id,title;

  DetailsScreen({this.id,this.title});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<DetailsProductsProvider>(context, listen: false);
    provider.allProductDetails(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(child: _buildContent(context)),
    );
  }

  Widget _buildBody(BuildContext context, ProductsDetailsModel product) {
    var products = product.data.product[0];

    return Stack(
      //crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height / 2.5,
          child: Image.network(
            products.photo,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
              "Price " + products.price + "💲",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: -5,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart,
              size: 50,
              color: Theme.of(context).primaryColor,
              //  color: Theme.of(context).primaryColorDark,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<DetailsProductsProvider>(
      builder: (_, pragma, __) {
        Widget content;

        if (pragma.errorMessage.isEmpty && pragma.getProductsModel != null) {
          content = _buildBody(context, pragma.getProductsModel);
        } else if (pragma.isLoading) {
          content = Center(child: CircularProgressIndicator());
        } else {
          content = Center(
            child: Text(pragma.errorMessage),
          );
        }
        /*else if(pragma.getProductsModel.length !=0){
          content = Center(
              child: Text(
                   "Not data for you !"));
        }*/

        return content;
      },
    );
  }
}
