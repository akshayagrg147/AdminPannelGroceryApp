import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../models/CategoryScreenModal.dart';
import '../components/header.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({Key? key}) : super(key: key);

  @override
  State<Categoryscreen> createState() => CategoryscreenState();
}

class CategoryscreenState extends State<Categoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
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
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        "Add, edit, remove and list Category here",
                        style: Theme.of(context).textTheme.subtitle1,
                        textDirection: TextDirection.ltr,
                      ),
                      ProductHeader(),
                      SizedBox(height: defaultPadding),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                ProductList(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
      padding: EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.subtitle1,
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

DataRow recentFileDataRow(CategoryScreenModal fileInfo) {
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
    return Container(
      child: const Row(
        children: [
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Sort(),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: SearchField()),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: AddCard1())
              ],
            ),
          ),
        ],
      ),
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
      margin: EdgeInsets.only(left: defaultPadding),
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
              child: Text("Add new Category"),
            ),
          ],
        ),
      ),
    );
  }

  void openAlert(BuildContext context) {
    State1? set = State1.no;
    State1? cod = State1.no;
    var dialog = Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Expanded(
        flex: 5,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: [
              const SizedBox(
                  width: double.infinity,
                  child: Text("ADD CATEGORY",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ))),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Category Name",
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.ac_unit_sharp),
                    ),
                  ),
                ),
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
                        color: Colors.white,
                        // color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset("assets/icons/Search.svg"),
                    ),
                  ),
                ),
              ),
              Text(
                "only one tag per product is allow product here",
                style: Theme.of(context).textTheme.subtitle1,
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
              Text(
                "Show on Home Page",
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.start,
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: State1.yes,
                      groupValue: set,
                      onChanged: (value) => set,
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                        value: State1.no,
                        groupValue: set,
                        onChanged: (State1? st) {
                          set = st;
                        }),
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 15))),
                onPressed: () {},
                child: const Text('Save!'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  onPressed: () {},
                  child: const Text('Cancel!'))
            ]),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}

enum State1 { yes, no }
