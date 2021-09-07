import 'package:equatable/equatable.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';

class ItemsStates extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}
class ItemsInitState extends ItemsStates{}
class ItemsLoadingState extends ItemsStates {}
class ItemsLoadedState extends ItemsStates {
  List<FCategories> categorie;
  List<FStock> catalogue;
  List<FStock> newItems;
  List<FStock> slaesItems;
  List<FStock> filterItems;
  ItemsLoadedState({ this.catalogue,  this.categorie,this.newItems,this.slaesItems,this.filterItems});
}
class ItemsFailedLoadState extends ItemsStates {
  String errorMessage;
  ItemsFailedLoadState({this.errorMessage});
}
