import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/AllOrders.dart';
import '../../../repositories/Modal/UserResponse.dart';

class UserItem extends StatelessWidget {
  final List<UserData>? userData;

  UserItem(
    this.userData, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 1200,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 900,
              columns: const [
                DataColumn(label: Text("User Image")),
                DataColumn(
                  label: Text("Phone"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
              ],
              rows: List.generate(
                userData!.length,
                (index) => UserItemRow(userData![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow UserItemRow(UserData data) {
  SizedBox(height: 16.0);
  return DataRow(cells: [
    DataCell(
      Row(
        children: [
          // SvgPicture.asset(
          //   fileInfo.icon!,
          //   height: 30,
          //   width: 30,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Image.network(
              data.profileImage.toString(),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (ctx, obj, stack) {
                return Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
                ;
              },
            ),
          ),
        ],
      ),
    ),
    DataCell(Text(data.phone!)),
    DataCell(Text(data.name!)),
    DataCell(Text(data.email!)),
  ]);
}
