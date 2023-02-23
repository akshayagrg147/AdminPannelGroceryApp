import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/OfferScreenModal.dart';
import '../components/header.dart';
import 'CategoryScreen.dart';

class Offerscreen extends StatefulWidget {
  const Offerscreen({Key? key}) : super(key: key);

  @override
  State<Offerscreen> createState() => _OfferscreenState();
}

class _OfferscreenState extends State<Offerscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: SideMenu(),

    body: SafeArea(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    if (Responsive.isDesktop(context))
    Expanded(
    child: SideMenu(),
    ),
      Expanded(
        flex: 5,
        child: SingleChildScrollView(
          primary: false,
          padding:  EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const SizedBox(
                  width: double.infinity,
                  child:  Text("Offers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,

                      ))
              ),
              Text(
                "Add, edit, remove and list offers here",
                style: Theme.of(context).textTheme.subtitle1,textDirection: TextDirection.ltr,
              ),
              ProductHeader(),
              SizedBox(height: defaultPadding),
              Row(
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
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
                  label: Text("Title"),
                ),
                DataColumn(
                  label: Text("Image"),
                ),
                DataColumn(
                  label: Text("Description"),
                ),

                DataColumn(
                  label: Text("Condition"),
                ),
                DataColumn(
                  label: Text("Discount"),
                ),
                DataColumn(
                  label: Text("Actions"),
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

DataRow recentFileDataRow(OfferScreenModal fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.title!)),
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.image!,
              height: 30,
              width: 30,
            ),

          ],
        ),
      ),
      DataCell(Text(fileInfo.description!)),
      DataCell(Text(fileInfo.condition!)),
      DataCell(Text(fileInfo.discounts!)),
      DataCell(Text(fileInfo.actions!)),
    ],
  );
}
class ProductHeader extends StatefulWidget {
  const  ProductHeader({Key? key}) : super(key: key);

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Sort(),
          Expanded(child: SearchField()),
          AddCard1()
        ],
      ),
    );
  }

}
class AddCard1  extends StatelessWidget  {

  const AddCard1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
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
          child: Column(
            children: [
              Container(
                child:
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: Text("Add new Offer"),
                ),

              ),
              Icon(
                Icons.add,
              ),
            ],
          )


      ),
    );
  }

  void openAlert(BuildContext context) {
    State1? set=State1.no;
    State1? cod=State1.no;
    var dialog = Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child:
      Expanded(
        flex: 5,
        child: ListView(
            shrinkWrap: true,

            padding: EdgeInsets.all(15.0),
            children: [
              const SizedBox(
                  width: double.infinity,
                  child:  Text("ADD OFFER",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,

                      ))
              )
              ,
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter offer title",
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
                      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter offer description",
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child:  const Icon(Icons.numbers),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width : 242.0,
                height: 42.0,
                decoration:   BoxDecoration(
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
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "offer code",

                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child:  const Icon(Icons.numbers),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Off will user get in %",

                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child:  const Icon(Icons.percent_outlined),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              const SizedBox(
                width: double.infinity, // <-- TextField width
                height: 120,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter offer condition",

                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                  ),
                  maxLines: 5, // <-- SEE HERE
                  minLines: 1,
                ),
              ),
             ElevatedButton(
                child: Text('Cancel'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                onPressed: () {

                }
                ,),
              SizedBox(height: 20),
              ElevatedButton(
                  child: Text('Save'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  onPressed: () {

                  }
              )


            ] ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }

}