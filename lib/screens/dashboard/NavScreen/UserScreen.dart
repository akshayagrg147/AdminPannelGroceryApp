import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/CategoryScreenModal.dart';
import '../../../models/ProductScreenModal.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
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
    child: ProductList(),
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

          // SizedBox(
          //   width: double.infinity,
          //   height: 400,
          //   child: DataTable2(
          //     columnSpacing: defaultPadding,
          //     minWidth: 600,
          //     columns: const [
          //       DataColumn(
          //         label: Text("Id"),
          //       ),
          //       DataColumn(
          //         label: Text("Images"),
          //       ),
          //       DataColumn(
          //         label: Text("Name"),
          //       ),
          //       DataColumn(
          //         label: Text("Cash on delevery"),
          //       ),
          //       DataColumn(
          //         label: Text("Product Delivery In"),
          //       ),
          //       DataColumn(
          //         label: Text("Free Shipping"),
          //       ),
          //       DataColumn(
          //         label: Text("Quantity"),
          //       ),
          //       DataColumn(
          //         label: Text("RegularPrice"),
          //       ),
          //       DataColumn(
          //         label: Text("Offer"),
          //       ),
          //       DataColumn(
          //         label: Text("Description"),
          //       ),
          //     ],
          //     rows: List.generate(
          //       demoRecentFiles.length,
          //           (index) => recentFileDataRow(demoRecentFiles[index]),
          //     ),
          //   ),
          // ),
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
