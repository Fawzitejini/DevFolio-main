import 'package:equatable/equatable.dart';
import 'package:folio/menu/bloc/repository/bloc_stock_model.dart';

class ItemsStates extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}
class ItemsInitState extends ItemsStates{}
class ItemsLoadingState extends ItemsStates {}
class ItemsLoadedState extends ItemsStates {
  List<ProductCategories> categorie;
  List<BlocStockModel> catalogue;
  List<BlocStockModel> newItems;
  ItemsLoadedState({ this.catalogue,  this.categorie,this.newItems});
}
class ItemsFailedLoadState extends ItemsStates {
  String errorMessage;
  ItemsFailedLoadState({this.errorMessage});
}
