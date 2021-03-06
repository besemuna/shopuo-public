import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/InternetErrorComponent.dart';
import 'package:shopuo/Components/LoadingComponent.dart';
import 'package:shopuo/Components/ProductCard.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/OnSaleViewModel.dart';
import "../Models/ProductModel.dart";

class OnSale extends StatefulWidget {
  @override
  _OnSaleState createState() => _OnSaleState();
}

class _OnSaleState extends State<OnSale> {
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<OnSaleViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  OnSaleViewModel model;

  ScrollController scrollController;
  scrollControllerListener() {
    if (scrollController.position.maxScrollExtent - scrollController.offset <
        50) model.fetchProducts();
  }

  // get length of product from model
  int getProductLength(model) => model.products.values
      .fold(0, (previousValue, element) => previousValue + element.length);

  // get products from model
  List<ProductModel> getProducts(model) {
    List<ProductModel> products = [];
    model.products.values.forEach((item) {
      item.forEach((element) => products.add(element));
    });
    return products;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnSaleViewModel>(
      builder: (_, model, __) => SafeArea(
        child: Scaffold(
          appBar: HeaderComponent(
            title: "On Sale",
            leadingCallback: () {
              model.navigateToOrders();
            },
            leading: "assets/svg_icons/package.svg",
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // loading indicator
              if (!model.fetched)
                Positioned.fill(child: LoadingComponent())
              else if (false)
                Positioned.fill(child: InternetErrorComponent())
              else
                GridView.builder(
                  cacheExtent: 5000,
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: .7,
                  ),
                  itemCount: getProductLength(model),
                  itemBuilder: (contex, index) {
                    List<ProductModel> products = getProducts(model);
                    return ProductCard(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "ProductDetails",
                          arguments: {"product": products[index]},
                        );
                      },
                      product: products[index],
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
