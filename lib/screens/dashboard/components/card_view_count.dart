import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/cubit/BarGraphCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../Utils/stat_controller.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';
import '../../../models/daily_stat_ui_model.dart';
import '../../../repositories/cubit/UpdateDeliveryCubit.dart';
import '../../../sharedpreference/PreferencesUtil.dart';
import '../../../state/all_admin_order_state.dart';
import '../../../state/delivery_amount_state.dart';
import '../NavScreen/NavigationBloc.dart';
import 'card_view.dart';
var statController = Get.put(StatController());
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
  late BarGraphCubit cubitBar;
@override
  void initState() {
    // TODO: implement initState
  DateTime currentDate = DateTime.now();
  DateTime startDate = currentDate.subtract(Duration(days: 6));

  String formattedStartDate = DateFormat('dd/MM/yyyy').format(startDate);
  String formattedEndDate = DateFormat('dd/MM/yyyy').format(currentDate);

  cubitBar = BlocProvider.of<BarGraphCubit>(context);
  cubitBar.fetchAllOrderCount(formattedStartDate, formattedEndDate);

    super.initState();

  }
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

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
                    icon: Icon(Icons.account_balance_wallet,color: Colors.white),
                    label: Text(labelText, style: TextStyle(color: Colors.white)),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 25),
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
              childAspectRatio: _size.width < 1400 ?3 : 2.5,
            ),
          ),
          if (Responsive.isMobile(context))
            barChart()
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
              child: Text('Submit',style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black)),
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

    return SizedBox(
      height: 500, // specify a height here,
      child: Row(
        children: [
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: countResponse?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context) ? crossAxisCount ~/ 2 : crossAxisCount,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) => CardView(
                info: countResponse![index], // Ensure countResponse is not null
                performClick: () {
                  // Handle item click based on index
                  if (index == 0) {
                    // navigationBloc.navigateToScreen(NavigationEvent.navigateToProducts,context);
                  } else if (index == 1) {
                    // navigationBloc.navigateToScreen(NavigationEvent.navigateToAllUser,context);
                  } else if (index == 2) {
                    // navigationBloc.navigateToScreen(NavigationEvent.navigateToOrder,context);
                  } else {
                    // navigationBloc.navigateToScreen(NavigationEvent.navigateToCategory,context);
                  }
                },
              ),
            ),
          ),
          barChart(),
        ],
      ),
    );
  }



}
Widget _pageIndicatorText() {
  return Center(
    child: Obx(() => Text(
      statController.currentWeek.value,
    )),
  );
}

Widget _previousWeekButton() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        onPressed: () {
          statController.onPreviousWeek();
        },
        elevation: 2.0,

        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.amber,
        ),
        padding: EdgeInsets.all(8.0),
        shape: CircleBorder(),
      ),
    ),
  );
}

Widget _nextWeekButton() {
  return Obx(
        () => Visibility(
      visible: statController.displayNextWeekBtn.value,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RawMaterialButton(
            onPressed: () {
              statController.onNextWeek();
            },
            elevation: 2.0,

            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.amber,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
    ),
  );
}
Widget _buildSectionTitle(String title, String subTitle) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'YourFontFamily',
                // Replace with your desired font family
                fontWeight: FontWeight.bold, // Set the font weight to bold
              )
          ),
        ),
        Text(
            subTitle,
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'YourFontFamily',
              // Replace with your desired font family
              fontWeight: FontWeight.bold, // Set the font weight to bold
            )
        )
      ],
    ),
  );
}
Widget _buildDayIndicator(DailyStatUiModel model, int type) {
  final width = 14.0;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
          width: 48.0,
          height: 24.0,
          child: Visibility(
            visible: true,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),

              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    '${model.stat}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          )),
      SizedBox(
        height: 4.0,
      ),
      Expanded(
        child: NeumorphicIndicator(
          width: width,
          percent: statController.getStatPercentage(model.stat, type),
        ),
      ),
      SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          model.day ?? 'Default Day', // Use a default value if model or model.day is null
          style: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 18,
            color: Colors.black45,
            height: 1,
          ),
        )

        ,
      )
    ],
  );
}

Widget _buildWeekIndicators(List<DailyStatUiModel> models, int type) {
  if (models.length == 7) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 152,
        width: 400,
        child: Row(

          children: <Widget>[
        Expanded(child: _buildDayIndicator(models[0], type)),
        Expanded(child: _buildDayIndicator(models[1], type)),
  Expanded(child: _buildDayIndicator(models[2], type)),
  Expanded(child:   _buildDayIndicator(models[3], type)),
  Expanded(child:    _buildDayIndicator(models[4], type)),
  Expanded(child:   _buildDayIndicator(models[5], type)),
  Expanded(child:      _buildDayIndicator(models[6], type)),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}

_getDayDecoratedBox(bool isToday) {
  if (isToday) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      color: Theme.of(Get.context!).primaryColor,
    );
  } else {
    return BoxDecoration();
  }
}
Widget _buildGraphStat() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      _buildSectionTitle(
        'Delivered',
        '',
      ),
      BlocConsumer<BarGraphCubit, AllAdminOrderState>(
        listener: (context, state) {
          if (state is AllAdminOrderErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is AllAdminOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllAdminOrderLoadedState) {
            List<DailyStatUiModel> dailyStatList = state.orderValue.itemData.map((barGraphOrder) {
              return DailyStatUiModel.fromBarGraphOrder(barGraphOrder);
            }).toList();
            print("dailystatlist ${dailyStatList.length}");

            return  _buildWeekIndicators(dailyStatList, 1);
          } else if (state is AllAdminOrderErrorState) {
            return Center(
              child: Text(state.error),
            );
          }

          return Container();
        },
      ),



    ],
  );
}
Widget barChart(){
  return Container(
    width: 300, // Adjust the width as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
      children: [
        _buildGraphStat(),

        //  Add other widgets here as needed

        _pageIndicatorText(),
        Row(children: [
          _previousWeekButton(),
          _nextWeekButton(),
        ],)
      ],
    ),
  );

}
