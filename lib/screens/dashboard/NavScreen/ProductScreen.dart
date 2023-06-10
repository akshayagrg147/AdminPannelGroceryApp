import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/product_state.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/ProductScreenModal.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                    primary: false,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: MultiProvider(
                        providers: [
                          Provider<ProductCubit>(
                            create: (_) => ProductCubit(),
                          ),
                        ],
                        child: SafeArea(
                          child: BlocConsumer<ProductCubit, ProductState>(
                            listener: (context, state) {
                              if (state is ProductErrorState) {
                                SnackBar snackBar = SnackBar(
                                  content: Text(state.error),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            builder: (context, state) {
                              if (state is ProductLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ProductLoadedState) {
                                return buildPostListView(state.products);
                              } else if (state is ProductErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }

                              return Container();
                            },
                          ),
                        ))),
              ),
            ],
          ),
        ));
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Id"),
                ),
                DataColumn(
                  label: Text("Images"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Cash on delevery"),
                ),
                DataColumn(
                  label: Text("Product Delivery In"),
                ),
                DataColumn(
                  label: Text("Free Shipping"),
                ),
                DataColumn(
                  label: Text("Quantity"),
                ),
                DataColumn(
                  label: Text("RegularPrice"),
                ),
                DataColumn(
                  label: Text("Offer"),
                ),
                DataColumn(
                  label: Text("Description"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildPostListView(List<ItemData> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      ItemData post = posts[index];

      return ListTile(
        title: Text(post.categoryType.toString()),
        subtitle: Text(post.category.toString()),
      );
    },
  );
}

DataRow recentFileDataRow(ProductScreenModal fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.id!)),
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.images!,
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.Name!)),
      DataCell(Text(fileInfo.cashondelevery!)),
      DataCell(Text(fileInfo.productdeliveryin!)),
      DataCell(Text(fileInfo.freeshipping!)),
      DataCell(Text(fileInfo.quantity!)),
      DataCell(Text(fileInfo.regularprice!)),
      DataCell(Text(fileInfo.offer!)),
      DataCell(Text(fileInfo.description!)),
    ],
  );
}

class ProductHeader extends StatefulWidget {
  const ProductHeader({Key? key}) : super(key: key);

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 3,
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Sort(),
              SizedBox(width: 20),
              Expanded(child: SearchField()),
              SizedBox(
                width: 10,
              ),
              Expanded(child: AddCard1())
            ],
          ),
        ),
      ],
    );
  }
}

class AddCard1 extends StatelessWidget {
  const AddCard1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 3,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: InkWell(
          onTap: () {
            openAlert(context);
          },
          child: const Row(
            children: [
              Icon(Icons.add),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 3),
                child: Text("Add new product"),
              ),
            ],
          ),
        ));
  }

  void openAlert(BuildContext context) {
    int? value = 0;
    State1? set = State1.no;
    TextEditingController productname = TextEditingController();
    var dialog = Dialog(
      insetPadding: const EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Expanded(
        flex: 5,
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
            children: [
              const SizedBox(
                  width: double.infinity,
                  child: Text("ADD PRODUCT",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ))),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Product Name",
                  //fillColor: Colors.white,
                  fillColor: secondaryColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        //color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.ac_unit_sharp),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // TextField(
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: "Enter Product Regular Price",
              //     fillColor: secondaryColor,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     ),
              //     prefixIcon: InkWell(
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(defaultPadding * 0.75),
              //         margin: EdgeInsets.symmetric(
              //             horizontal: defaultPadding / 2),
              //         decoration: BoxDecoration(
              //           borderRadius: const BorderRadius.all(
              //               Radius.circular(10)),
              //         ),
              //         child: const Icon(Icons.numbers),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),
              // TextField(
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: "Price per quantity",
              //
              //     fillColor: secondaryColor,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     ),
              //     prefixIcon: InkWell(
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(defaultPadding * 0.75),
              //         margin: EdgeInsets.symmetric(
              //             horizontal: defaultPadding / 2),
              //         decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: const BorderRadius.all(
              //               Radius.circular(10)),
              //         ),
              //         child: const Icon(Icons.numbers),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),

              // TextField(
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: "Price per quantity",
              //
              //     fillColor: secondaryColor,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     ),
              //     prefixIcon: InkWell(
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(defaultPadding * 0.75),
              //         margin: EdgeInsets.symmetric(
              //             horizontal: defaultPadding / 2),
              //         decoration: BoxDecoration(
              //           borderRadius: const BorderRadius.all(
              //               Radius.circular(10)),
              //         ),
              //         child: const Icon(Icons.numbers),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // <-- TextField width
                height: 120,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: productname,
                  decoration: const InputDecoration(
                    hintText: "Enter Poduct Description",
                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 5,
                  // <-- SEE HERE
                  minLines: 1,
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Enter Product Delivery Instruction",
                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
              const SizedBox(height: 20),
              //AddProductTextField(image: "assets/icons/Search.svg",hint:"Enter Pin code", ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter Pin code",
                  fillColor: secondaryColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.numbers),
                    ),
                  ),
                ),
              ),
              Text(
                "Please fill all the pincode if it is supported on specific pincode and if it is supported on all pincode the leave it empty",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter tags Here",
                  fillColor: secondaryColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset("assets/icons/Search.svg"),
                    ),
                  ),
                ),
              ),
              Text(
                "only one tag per product is allow product here",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Container(
                width: 242.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xff2c2c2c),
                ),
                child: const Center(
                  child: Text(
                    'Upload Image1',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 242.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xff2c2c2c),
                ),
                child: const Center(
                  child: Text(
                    'Upload Image2',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "In Stock",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),

              Column(
                children: [
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: State1.no,
                      groupValue: set,
                      onChanged: (value) => set,
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                        value: State1.yes,
                        groupValue: set,
                        onChanged: (State1? st) {
                          set = st;
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Free Shipping",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Column(children: [
                ListTile(
                  title: const Text('Yes'),
                  leading: Radio(
                    value: 1,
                    groupValue: value,
                    onChanged: (value) {
                      setState(() {
                        value = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No'),
                  leading: Radio(
                    value: 2,
                    groupValue: value,
                    onChanged: (value) {},
                  ),
                ),
              ]),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(30)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 15))),
                onPressed: () {},
                child: const Text('Save!'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(30)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                  onPressed: () {},
                  child: const Text('Cancel!'))
            ]),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: dialog,
            ),
          );
        });
  }
}

void setState(Null Function() param0) {}

enum State1 { yes, no }
