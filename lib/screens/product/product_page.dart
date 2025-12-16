import 'package:flutter/material.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:formation_flutter/res/app_colors.dart';
import 'package:formation_flutter/res/app_icons.dart';
import 'package:formation_flutter/screens/product/product_header.dart';
import 'package:formation_flutter/screens/product/product_provider.dart';
import 'package:formation_flutter/screens/product/tabs/product_tab0.dart';
import 'package:formation_flutter/screens/product/tabs/product_tab1.dart';
import 'package:formation_flutter/screens/product/tabs/product_tab2.dart';
import 'package:formation_flutter/screens/product/tabs/product_tab3.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductDetailsCurrentTab _tab = ProductDetailsCurrentTab.summary;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return ProductProvider(
      product: generateProduct(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            ProductHeader(),
            SliverPadding(
              padding: EdgeInsetsDirectional.only(top: 10.0),
              sliver: SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: false,
                child: _getBody(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tab.index,
          onTap: (int position) {
            _tab = ProductDetailsCurrentTab.values[position];
            setState(() {});
          },
          items: ProductDetailsCurrentTab.values
              .map(
                (ProductDetailsCurrentTab tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.label(appLocalizations),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: _tab != ProductDetailsCurrentTab.summary,
          child: ProductTab0(),
        ),
        Offstage(
          offstage: _tab != ProductDetailsCurrentTab.info,
          child: ProductTab1(),
        ),
        Offstage(
          offstage: _tab != ProductDetailsCurrentTab.nutrition,
          child: ProductTab2(),
        ),
        Offstage(
          offstage: _tab != ProductDetailsCurrentTab.nutritionalValues,
          child: ProductTab3(),
        ),
      ],
    );
  }
}

enum ProductDetailsCurrentTab {
  summary(AppIcons.tab_barcode),
  info(AppIcons.tab_fridge),
  nutrition(AppIcons.tab_nutrition),
  nutritionalValues(AppIcons.tab_array);

  const ProductDetailsCurrentTab(this.icon);

  final IconData icon;

  String label(AppLocalizations appLocalizations) => switch (this) {
    ProductDetailsCurrentTab.summary => appLocalizations.product_tab_summary,
    ProductDetailsCurrentTab.info => appLocalizations.product_tab_properties,
    ProductDetailsCurrentTab.nutrition =>
      appLocalizations.product_tab_nutrition,
    ProductDetailsCurrentTab.nutritionalValues =>
      appLocalizations.product_tab_nutrition_facts,
  };
}
