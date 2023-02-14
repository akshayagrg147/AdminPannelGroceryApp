import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/ProductScreenModal.dart';
import '../components/recent_files.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
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
              Text(
                "Add, edit, remove and list products here",
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Sort(),
          Expanded(child: SearchField()),
          AddCard()
        ],
      ),
    );
  }
}




