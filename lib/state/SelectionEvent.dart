abstract class SelectionEvent {}

class UpdateSelectionEvent extends SelectionEvent {
  final String selectedItem;

  UpdateSelectionEvent(this.selectedItem);
}
