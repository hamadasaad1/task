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
      //backgroundColor: Theme.of(context).primaryColorLight,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(.5),
                            Theme.of(context).primaryColor,
                            //color.withOpacity(.2),
                          ])),
                  child: InkWell(
                    onTap: () {
                      if (_scaffoldKey.currentState.isDrawerOpen) {
                        _scaffoldKey.currentState.openEndDrawer();
                      } else {
                        _scaffoldKey.currentState.openDrawer();
                      }
                    },
                    child: Text(
                      "Menu",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Products",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                  color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          srTextFormField(),
          SizedBox(
            height: 30,
          ),
          _buildContent(context),
        ]),
      ),
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
    return Card(
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
    );
  }
}
