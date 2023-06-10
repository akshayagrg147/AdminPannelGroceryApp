import 'package:adminpannelgrocery/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
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
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Categories",
    numOfFiles: 4,
    svgSrc: "assets/icons/google_drive.svg",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Orders",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Total Users",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
