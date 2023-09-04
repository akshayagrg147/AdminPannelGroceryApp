
import 'package:adminpannelgrocery/models/AllOrders.dart';
abstract class SelectionState {}

class SelectionInitial extends SelectionState {}

class SelectionUpdated extends SelectionState {
  final String selectedItem;
  final OrderData data;

  SelectionUpdated(this.selectedItem,this.data);
}