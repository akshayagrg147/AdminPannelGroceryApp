import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/SelectionState.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(SelectionInitial());

  void selectItem(String selectedItem, OrderData data) {
    emit(SelectionUpdated(selectedItem, data));
  }
}
