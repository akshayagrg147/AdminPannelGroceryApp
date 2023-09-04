//import 'package:admin_dum/models/MyFiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../repositories/Modal/RecentOrderCountResponse.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.info,
    required this.performClick
  }) : super(key: key);

  final CountResponse info;
  final String? Function() performClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        performClick();
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding * 0.75),
                  height: 45,
                  width: 45,

                  child: Image.network(

                    info.image.toString(), // Replace with your actual image URL
                    fit: BoxFit.cover, // How the image should be fitted within the container
                  ),

                ),
              ],
            ),
            Text(
              info.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // ProgressLine(
            //   color: info.color,
            //   percentage: info.percentage,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${info.count}",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white70),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
