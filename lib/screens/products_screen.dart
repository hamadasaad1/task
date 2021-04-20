import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/model/products_model.dart';
import 'package:task/provider/products_provider.dart';
import 'package:task/screens/details_screen.dart';
import 'package:task/widget/main_drawer.dart';
import 'package:task/widget/text_filed.dart';

class ProductsScreen extends StatelessWidget {
  static String routeName = "products_screen";

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    provider.allProducts();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart,
              size: 30,
              //  color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _buildContent(context),
    );
  }

  Widget srTextFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        icon: Icons.search,
        hint: "Search",
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (_, pragma, __) {
        Widget content;

        if (pragma.errorMessage.isEmpty && pragma.getProductsModel != null) {
          content = _buildList(context, pragma.getProductsModel.data.products);
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

  Widget _buildList(BuildContext context, List<Products> model) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(model.length, (index) {
        return _buildItem1(context, model[index]);
      }),
    );
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     return _buildItem(context, model[index]);
    //   },
    //   itemCount: model.length,
    // );
  }

  Widget _buildItem(BuildContext context, Products products) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Stack(
          children: [
            //this to make image with circular
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              child: Image.network(
                products.photo,
                height: MediaQuery.of(context).size.height / 2.1,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                //width: MediaQuery.of(context).size.width / 3,
                color: Colors.black45,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      products.productName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      //softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      "Price " + products.price + "💲",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildItem1(BuildContext context, Products products) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              DetailsScreen(id: products.id.toString(),title: products.productName,)),
        );
      },

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              child: Image.network(
                products.photo,
                height: MediaQuery.of(context).size.height / 2.1,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Text(
                products.price + "💲",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                  //width: MediaQuery.of(context).size.width / 3,
                  color: Colors.black45,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Center(
                    child: Text(
                      products.productName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
