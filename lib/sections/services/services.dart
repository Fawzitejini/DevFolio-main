import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/bloc/items_bloc.dart';
import 'package:folio/nou_used/bloc_stock_reposetery.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
import 'package:folio/sections/services/servicesDesktop.dart';
import 'package:folio/sections/services/servicesMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ItemsBloc(ItemsInitState(), NoneAsyncBlocStockReposetery(),),child:
    ScreenTypeLayout(
      mobile: ServiceMobiles(),
      tablet: ServiceMobiles(),
      desktop: ServiceDesktop(),
    ));
  }
}
