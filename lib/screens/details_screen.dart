import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/model/details_model.dart';
import 'package:task/provider/details_provider.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "details_screen";
  final String id;

  DetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailsProductsProvider>(context, listen: false);
    provider.allProductDetails(id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: _buildContent(context)
      ),

    );
  }

  Widget _buildBody(Product product) {
    return Column(

        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              product.photo,
              fit: BoxFit.fill,
            ),
          ),



        ],
      );
  }
  Widget _buildContent(BuildContext context) {
    return Consumer<DetailsProductsProvider>(
      builder: (_, pragma, __) {
        Widget content;

        if (pragma.errorMessage.isEmpty && pragma.getProductsModel != null) {
          content = _buildBody( pragma.getProductsModel.data.product);
        } else if (pragma.isLoading) {
          content = CircularProgressIndicator();
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
