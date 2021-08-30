
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/menu/bloc/events/items_events.dart';
import 'package:folio/menu/bloc/repository/firebase_reposetory.dart';
import 'package:folio/menu/bloc/states/items_states.dart';
class ItemsBloc extends Bloc<ItemsEvents, ItemsStates> {
  Freposetery freposetery;
  ItemsBloc(ItemsStates initialState, this.freposetery)
      : super(initialState);
  @override
  Stream<ItemsStates> mapEventToState(ItemsEvents event) async* {
    if (event is FetchData) {
      yield ItemsLoadingState();
      try {
        yield ItemsLoadedState(
            catalogue: freposetery.publicStock(),
            categorie: freposetery.getCategorie(),
            newItems:  freposetery.getNewitems(),
            slaesItems: freposetery.getSalesitems()
            );
      } catch (e) {
        yield ItemsFailedLoadState(errorMessage: e.toString());
      }
    }
  }
}
