import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/menu/bloc/repository/bloc_stock_reposetery.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/sections/portfolio/portfolioDesktop.dart';
import 'package:folio/sections/portfolio/portfolioMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> ItemsBloc(ItemsInitState(), NoneAsyncBlocStockReposetery()),child:ScreenTypeLayout(
      mobile: PortfolioMobileTab(),
      tablet: PortfolioMobileTab(),
      desktop: PortfolioDesktop(),
    ) ,)
    ;
  }
}
