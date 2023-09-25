import 'dart:developer';

import 'package:adminpannelgrocery/repositories/cubit/AddCouponsCubit.dart';
import 'package:adminpannelgrocery/state/add_coupon_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../commonWidget/sppiner.dart';
import '../../../constants.dart';
import '../../../repositories/Modal/CouponFormData.dart';
import '../../../responsive.dart';
import '../../main/components/side_menu.dart';
import '../components/headerDashboard.dart';
import 'AllCouponsScreen.dart';

class CouponScreen extends StatefulWidget {
  CouponScreen({super.key});

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final _formKey = GlobalKey<FormState>();
   DateTime _picDate =DateTime.now();
   DateTime _expireedDate=DateTime.now();
  CouponFormData _formData = CouponFormData();
  String? _discountType;
  late AddCouponsCubit cubit;


  String selectedValue = "";
  TextEditingController cuponCodeName = TextEditingController();
  TextEditingController cuponTitle = TextEditingController();
  TextEditingController discountedAmountController = TextEditingController();
  TextEditingController minimumPurchaseController = TextEditingController();
  TextEditingController discountPercentageController =
      TextEditingController();

  String selectedOption = 'Discount Amount';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(false),
      resizeToAvoidBottomInset: true,
      body: Container(

        child: Responsive.isDesktop(context)
            ? buildDesktopLayout()
            : Responsive.isMobile(context)
                ? buildMobileLayout(context)
                : Container(),
      ),
    );
  }


  @override
  void initState() {
  cubit=  BlocProvider.of<AddCouponsCubit>(context);
  }

  Widget buildDesktopLayout() {

    return Row(
      children: [
        if (Responsive.isDesktop(context))
          Expanded(
            child: SideMenu(true),
          ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Padding(

                padding: const EdgeInsets.only(left: 20,right: 10),
                child: Column(

                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(

                        onPressed:(){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  AllCouponsScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('All Coupons->'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(

                          children: [


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Expanded(
                              //   child: commonTextFieldWidget(
                              //     type: TextInputType.text,
                              //     controller: categoryName,
                              //     hintText: "Coupon Title",
                              //     secondaryColor: secondaryColor,
                              //     labelText: "Please enter a coupon title",
                              //     onChanged: (val) {},
                              //   ),
                              // ),

                              Expanded(
                                child: commonTextFieldWidget(
                                  secondaryColor: Colors.white,
                                  type: TextInputType.text,
                                  controller: cuponCodeName,
                                  hintText: "Coupon Code",

                                  labelText: "Please enter a coupon code.",
                                  onChanged: (val) {},
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: commonTextFieldWidget(

                                  type: TextInputType.text,
                                  controller: cuponTitle,
                                  hintText: "Coupon Code",
                                  secondaryColor: Colors.white,
                                  labelText: "Please enter a coupon title.",
                                  onChanged: (val) {},
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:  SpinnerWidget(
                                  items: ['Discount Amount', 'Percentage'],
                                  onChanged: (value, index) {
                                    setState(() {
                                      selectedOption = value; // Update the selected option
                                    });
                                  },
                                  selectedValue: selectedOption,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              if (selectedOption == 'Discount Amount')
                                Expanded(
                                  child: commonTextFieldWidget(
                                    type: TextInputType.text,
                                    controller: discountedAmountController,
                                    hintText: "Discounted Amount",
                                    secondaryColor: Colors.white,
                                    labelText: "Please enter the discounted amount.",
                                    onChanged: (val) {},
                                  ),
                                ) else
                                Expanded(child: commonTextFieldWidget(
                                  type: TextInputType.text,
                                  controller: discountPercentageController,
                                  hintText: "Enter Percentage",
                                  secondaryColor: Colors.white,
                                  labelText: "Please enter the percentage.",
                                  onChanged: (val) {},
                                )),

                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: commonTextFieldWidget(
                                type: TextInputType.text,
                                controller: minimumPurchaseController,
                                margin: 40,
                                hintText: "Minimum Purchase",
                                    secondaryColor: Colors.white,
                                labelText: "Please enter the minimum purchase amount.",
                                onChanged: (val) {},
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _picstartDate(context),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black, // Remove background color
                                        elevation: 0, // Remove elevation
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.calendar_today), // You can replace this with your own icon
                                          SizedBox(width: 8), // Add spacing between icon and text
                                          Text(
                                            _picDate != null ? 'Start Date: ${_picDate.toLocal()}' : 'Start Date',
                                            style: TextStyle(color: Colors.white), // Adjust text color
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _picExpireDate(context),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black, // Remove background color
                                        elevation: 0, // Remove elevation
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.calendar_today), // Replace with your icon
                                          SizedBox(width: 8), // Add spacing between icon and text
                                          Text(
                                            _expireedDate != null ? 'Expire Date: ${_expireedDate.toLocal()}' : 'Expire Date',
                                            style: TextStyle(color: Colors.white), // Adjust text color
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                            SizedBox(
                              height: 50,
                            ),
                          BlocConsumer<AddCouponsCubit, AddCouponState>(
                            listener: (context, state) {
                              if (state is AddCouponErrorState) {
                                SnackBar snackBar = SnackBar(
                                  content: Text(state.error),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              else if (state is AddCouponLoadedState) {
                                if (state.products.statusCode == 200) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text(state.products.message!),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  AllCouponsScreen(),
                                    ),
                                  );
                                }
                                else{
                                  SnackBar snackBar = SnackBar(
                                    content: Text(state.products.message??"something went wrong"),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }





                                //   return Text("${obj.message}");
                              }
                            },
                            builder: (context, state) {
                              print(state);
                              if (state is AddCouponLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }


                              return  Column(

                                children: [
                                ElevatedButton(
                                onPressed: _submitForm,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Submit'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(500, 0),
                              ),)

                                ],
                              );
                            },
                          )

                        ],
                      ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMobileLayout(BuildContext context) {


    print("checkedcalled $selectedOption");
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child:  Column(
          children: [
            DashboardHeader(
              imageUrl:  "",
              name:  "null", title: "Coupons",),
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Aligns children to the end (bottom)
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  ElevatedButton(

                    onPressed:(){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  AllCouponsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black38, // Change the background color here
                    ),
                    child: const Text('All Coupons->',),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  commonTextFieldWidget(
                    type: TextInputType.text,
                    padding: 10,
                    controller: cuponCodeName,
                    hintText: "Coupon Code",
                    secondaryColor: Colors.white,
                    labelText: "Please enter a coupon code.",
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  commonTextFieldWidget(
                    type: TextInputType.text,
                    padding: 10,
                    controller: cuponTitle,
                    hintText: "Coupon Code",
                    secondaryColor: Colors.white  ,
                    labelText: "Please enter a coupon title.",
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SpinnerWidget(
                    items: ['Discount Amount', 'Percentage'],
                    onChanged: (value, index) {
                      setState(() {
                        selectedOption = value;
                        print("checkedcalled $selectedOption");// Update the selected option
                      });
                    },
                    selectedValue: selectedOption,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (selectedOption == 'Discount Amount')
                  commonTextFieldWidget(
                    type: TextInputType.text,
                    controller: discountedAmountController,
                    hintText: "Discounted Amount",
                    secondaryColor: Colors.white  ,
                    labelText: "Please enter the discounted amount.",
                    onChanged: (val) {},
                  ) else
                  commonTextFieldWidget(
                    type: TextInputType.text,
                    controller: discountPercentageController,
                    hintText: "Enter Percentage",
                    secondaryColor: Colors.white  ,
                    labelText: "Please enter the percentage.",
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  commonTextFieldWidget(
                    type: TextInputType.text,
                    controller: minimumPurchaseController,
                    margin: 40,
                    hintText: "Minimum Purchase",
                    secondaryColor: Colors.white  ,
                    labelText: "Please enter the minimum purchase amount.",
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Start Date ',style: TextStyle(
                    color: Colors.black, // Change the text color here
                    fontSize: 14, // Adjust the font size as needed
                  ),),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Change the background color here
                    ),
                    onPressed: () => _picstartDate(context),
                    child: Text(_picDate !=  null ? '${_picDate.toLocal()}' : 'Start Date',style: TextStyle(color: Colors.white),)
      ,
                  ),

                ],),
                  SizedBox(
                    height: 10,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Expire Date ',style: TextStyle(
                  color: Colors.black, // Change the text color here
                  fontSize: 14, // Adjust the font size as needed
                ),),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Change the background color here
                    ),
                    onPressed: () => _picExpireDate(context),
                    child:   Text(
                        _expireedDate !=  null ? '${_expireedDate.toLocal()}' : 'Expire Date',style: TextStyle(color: Colors.white),)
      ,
                  ),
                ),
                SizedBox(height: 20),

              ],),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _picstartDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _picDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != _picDate) {
      setState(() {
        _picDate = selectedDate;
      });
    }
  }
  Future<void> _picExpireDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _expireedDate,
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );

    if (pickedDate != null && pickedDate != _expireedDate) {
      setState(() {
        _expireedDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formData.couponCode = cuponCodeName.text;
      _formData.couponTitle=cuponTitle.text;
      _formData.couponType="its for fun";
      _formData.discountPercentage = discountPercentageController.text;
      _formData.discountedAmount = discountedAmountController.text;
      _formData.minimumPurchase = minimumPurchaseController.text;
      _formData.startDate = _picDate.toString().split(" ").first;
      _formData.expireDate = _expireedDate.toString().split(" ").first;
      cubit.addCoupon(_formData);
    }
  }


}

class Product {
  final String title;
  final String description;

  Product({required this.title, required this.description});
}
