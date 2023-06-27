
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../NavScreen/NavigationBloc.dart';
import 'card_view.dart';

class CardViewCount extends StatelessWidget {

  final List<CountResponse>? responseCount;
   CardViewCount(this.responseCount, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('print my fields ${responseCount}');
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Summary",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(responseCount,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(responseCount),
          desktop: FileInfoCardGridView(responseCount,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {

  final List<CountResponse>? countResponse;
   FileInfoCardGridView(this.countResponse, {
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: countResponse?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          CardView(info: countResponse![index],performClick: (){
        if(index==0) {
          navigationBloc.navigateToScreen(NavigationEvent.navigateToProducts,context);
        }
        else if(index==1) {
          navigationBloc.navigateToScreen(NavigationEvent.navigateToAllUser,context);
        }
        else{
          navigationBloc.navigateToScreen(NavigationEvent.navigateToOrder,context);
        }
      },),
    );
  }
}
