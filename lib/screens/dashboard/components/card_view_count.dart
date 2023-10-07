import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';
import '../../../repositories/cubit/UpdateDeliveryCubit.dart';
import '../../../sharedpreference/PreferencesUtil.dart';
import '../../../state/delivery_amount_state.dart';
import '../NavScreen/NavigationBloc.dart';
import 'card_view.dart';

class CardViewCount extends StatefulWidget {
  String? price;
  final List<CountResponse>? responseCount;

  CardViewCount(
    this.responseCount,this.price, {
    Key? key,
  }) : super(key: key);

  @override
  State<CardViewCount> createState() => _CardViewCountState();
}

class _CardViewCountState extends State<CardViewCount> {


  @override
  Widget build(BuildContext context) {
   // initializeData();
    print('printmyfields ${widget.price}');
    final Size _size = MediaQuery.of(context).size;
    final TextEditingController _textController = TextEditingController();

    _textController.text = "₹ ${widget.price}";

    String labelText = "Free Delivery";
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          BlocConsumer<UpdateDeliveryCubit, DeliveryAmountState>(
            listener: (context, state) {
              if (state is DeliveryAmountErrorState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is DeliveryAmountLoadedState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.products.message ?? ""),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is DeliveryAmountLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Summary",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showDialog(context, (value) {
                        BlocProvider.of<UpdateDeliveryCubit>(context)
                            .submitFreeDeliveryAmount(value);
                        print("valueAtFreeDelivery ${value}");
                        _textController.text = "₹ $value";
                      });
                    },
                    icon: Icon(Icons.account_balance_wallet),
                    label: Text(labelText),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: SizedBox(
                      width: 50, // Set the desired width
                      height: 50,
                      child: TextField(
                        readOnly: true,
                        controller: _textController, // Assign the controller
                        decoration: InputDecoration(
                          labelText: '',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: FileInfoCardGridView(
              widget.responseCount,
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio:
                  _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            ),
            tablet: FileInfoCardGridView(widget.responseCount),
            desktop: FileInfoCardGridView(
              widget.responseCount,
              childAspectRatio: _size.width < 1400 ? 2 : 1.1,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, Function(String) value) {
    TextEditingController textController = TextEditingController();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Get Free Delivery'),
          content: Container(
            color: Colors.grey, // Set the background color to white
            child: commonTextFieldWidget(
              type: TextInputType.number,
              controller: textController,
              hintText: "",
              secondaryColor: Colors.white,
              labelText: "Enter Amount",
              onChanged: (val) {},
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                String enteredText = textController.text;
                value(enteredText);
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

Future<String> getPrice() async {
  final price = await PreferencesUtil.getString('price');
  return price!;
}

class FileInfoCardGridView extends StatelessWidget {
  final List<CountResponse>? countResponse;

  FileInfoCardGridView(
    this.countResponse, {
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: countResponse?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => CardView(
        info: countResponse![index],
        performClick: () {
          if (index == 0) {
            //  navigationBloc.navigateToScreen(NavigationEvent.navigateToProducts,context);
          } else if (index == 1) {
            //  navigationBloc.navigateToScreen(NavigationEvent.navigateToAllUser,context);
          } else if (index == 2) {
            // navigationBloc.navigateToScreen(NavigationEvent.navigateToOrder,context);
          } else {
            //  navigationBloc.navigateToScreen(NavigationEvent.navigateToCategory,context);
          }
        },
      ),
    );
  }
}
