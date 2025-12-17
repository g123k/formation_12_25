import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/res/app_colors.dart';
import 'package:formation_flutter/res/app_icons.dart';
import 'package:formation_flutter/screens/product/bloc/product_bloc.dart';
import 'package:formation_flutter/screens/product/product_header.dart';
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
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: AppColors.white),
      child: BlocProvider<ProductBloc>(
        create: (_) =>
            ProductBloc()..add(LoadProduct(barcode: '5000159484695')),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, ProductState state) {
            return switch (state) {
              ProductInitial() => const _ProductPageEmpty(),
              ProductLoading() => const _ProductPageEmpty(),
              ProductLoaded() => const _ProductPageLoaded(),
              ProductError() => const _ProductPageError(),
            };
          },
        ),
      ),
    );
  }
}

class _ProductPageEmpty extends StatelessWidget {
  const _ProductPageEmpty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}

class _ProductPageError extends StatelessWidget {
  const _ProductPageError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}

class _ProductPageLoaded extends StatefulWidget {
  const _ProductPageLoaded();

  @override
  State<_ProductPageLoaded> createState() => _ProductPageLoadedState();
}

class _ProductPageLoadedState extends State<_ProductPageLoaded> {
  ProductDetailsCurrentTab _tab = ProductDetailsCurrentTab.summary;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
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
