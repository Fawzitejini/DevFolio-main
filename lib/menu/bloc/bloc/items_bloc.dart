
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/bloc_stock_reposetery.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
class ItemsBloc extends Bloc<ItemsEvents, ItemsStates> {
  NoneAsyncBlocStockReposetery noneAsyncBlocStockReposetery;
  ItemsBloc(ItemsStates initialState, this.noneAsyncBlocStockReposetery)
      : super(initialState);
  @override
  Stream<ItemsStates> mapEventToState(ItemsEvents event) async* {
    if (event is FetchData) {
      yield ItemsLoadingState();
      try {
        yield ItemsLoadedState(
            catalogue: noneAsyncBlocStockReposetery.getStockData(),
            categorie: noneAsyncBlocStockReposetery.getCategorie(),
            newItems:  noneAsyncBlocStockReposetery.getNewitems()
            );
      } catch (e) {
        yield ItemsFailedLoadState(errorMessage: e.toString());
      }
    }
  }
}
