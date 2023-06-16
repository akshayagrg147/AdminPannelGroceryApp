import 'package:adminpannelgrocery/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String?  title;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({

    this.title,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Total Product",
    numOfFiles: 15,

    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Categories",
    numOfFiles: 4,

    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Orders",
    numOfFiles: 1328,

    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Total Users",
    numOfFiles: 5328,

    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
