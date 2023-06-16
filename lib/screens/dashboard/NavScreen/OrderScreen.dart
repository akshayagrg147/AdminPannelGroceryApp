import 'package:adminpannelgrocery/models/OrderScreenModal.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/header.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
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
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const SizedBox(
                          width: double.infinity,
                          child: Text("Orders",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
                      Text(
                        "Add, edit, remove and list Order here",
                        style: Theme.of(context).textTheme.subtitle1,
                        textDirection: TextDirection.ltr,
                      ),
                      ProductHeader(),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: const [
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
                  label: Text("created_at"),
                ),
                DataColumn(
                  label: Text("AddressType"),
                ),
                DataColumn(
                  label: Text("flat Number"),
                ),
                DataColumn(
                  label: Text("Street"),
                ),
                DataColumn(
                  label: Text("Locality"),
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

DataRow recentFileDataRow(OrderScreenModal fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.created_at!)),
      DataCell(Text(fileInfo.AddressType!)),
      DataCell(Text(fileInfo.flat_Number!)),
      DataCell(Text(fileInfo.Street!)),
      DataCell(Text(fileInfo.Locality!)),
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
    return  Row(
      children: [
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Sort(),
              SizedBox(
                width: 10,
              ),
              Expanded(child: SearchField()),
              SizedBox(
                width: 10,
              ),
              Expanded(child: AddCard(onTap: (val){

              },))
            ],
          ),
        ),
      ],
    );
  }
}
