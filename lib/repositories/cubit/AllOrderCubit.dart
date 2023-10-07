
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/state/all_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/ProductRepository.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  int skip = 0;
  final ProductRepository repository;

  AllOrderCubit(this.repository) : super(AllOrderLoadingState());

  void loadOrders() {
    if (state is AllLoadingMoreState) return;
    final currentState = state;
    List<OrderData> oldOrders = [];

    if (currentState is AllOrderLoadedState) {
      oldOrders = List.from(currentState.itemData ?? []);
    }

    emit(AllLoadingMoreState(oldOrders, isFirstFetch: skip == 0));

    repository.fetchOrders(skip, 10).then((newOrders) {
      skip = skip + 10;

      final List<OrderData> orders = List.from(oldOrders);
      orders.addAll(newOrders.itemData!);

      emit(AllOrderLoadedState(orders));
    });
  }

  void resetState() {
    emit(AllOrderInitialState());
  }
}
