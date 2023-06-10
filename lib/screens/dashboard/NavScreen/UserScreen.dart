import 'package:adminpannelgrocery/models/UserScreenModal.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/header.dart';

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
                const Expanded(
                  child: SideMenu(),
                ),
              const Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  primary: false,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Text("Users",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
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
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Check all your users' details here",
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
                  label: Text("Username"),
                ),
                DataColumn(
                  label: Text("Gender"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Phone Number"),
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

DataRow recentFileDataRow(UserScreenModal fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.username!)),
      DataCell(Text(fileInfo.gender!)),
      DataCell(Text(fileInfo.email!)),
      DataCell(Text(fileInfo.phonenumber!)),
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
              SizedBox(
                width: 10,
              ),
              Expanded(child: SearchField()),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
