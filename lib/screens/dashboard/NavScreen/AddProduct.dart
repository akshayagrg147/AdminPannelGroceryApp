import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        const CustemTextField(
            image: "assets/icons/dribble.svg", hint: "Enter Product Name"),
        // TextField(
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //    hintText: "Enter Product Name",
        //
        //     fillColor: secondaryColor,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //     ),
        //     prefixIcon: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         padding: EdgeInsets.all(defaultPadding * 0.75),
        //         margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           //color: primaryColor,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: SvgPicture.asset("assets/icons/dribble.svg"),
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        const CustemTextField(

            hint: "Enter Product Regular Price"),

        const SizedBox(height: 20),
        const CustemTextField(
             hint: "Price per quantity"),

        const SizedBox(height: 20),
        const CustemTextField(
             hint: "Price per quantity"),

        // TextField(
        //   keyboardType: TextInputType.number,
        //   decoration: InputDecoration(
        //     hintText: "Price per quantity",
        //
        //     fillColor: secondaryColor,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //     ),
        //     prefixIcon: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         padding: EdgeInsets.all(defaultPadding * 0.75),
        //         margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: SvgPicture.asset("assets/icons/Search.svg"),
        //       ),
        //     ),
        //   ),
        // ),

        const SizedBox(height: 20),
        const SizedBox(
          width: double.infinity, // <-- TextField width
          height: 120,

          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter Poduct Description",
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
        const SizedBox(height: 20),
        const CustemTextField(

            hint: "Enter Product Delivery Instruction"),
        // TextField(
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //    hintText: "Enter Product Delivery Instruction",
        //
        //     fillColor: secondaryColor,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //     ),
        //     prefixIcon: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         padding: EdgeInsets.all(defaultPadding * 0.75),
        //         margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: SvgPicture.asset("assets/icons/Search.svg"),
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        const CustemTextField(

          hint: "Enter Pin code",
        ),
        // TextField(
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //     hintText: "Enter Pin code",
        //
        //     fillColor: secondaryColor,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //     ),
        //     suffixIcon: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         padding: EdgeInsets.all(defaultPadding * 0.75),
        //         margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: SvgPicture.asset("assets/icons/Search.svg"),
        //       ),
        //     ),
        //   ),
        // ),
        Text(
          "Please fill all the pincode if it is supported on specific pincode and if it is supported on all pincode the leave it empty",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 20),
        const CustemTextField(

          hint: "Enter tags Here",
        ),

        // TextField(
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //     hintText: "Enter tags Here",
        //
        //     fillColor: secondaryColor,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //     ),
        //     suffixIcon: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         padding: EdgeInsets.all(defaultPadding * 0.75),
        //         margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: SvgPicture.asset("assets/icons/Search.svg"),
        //       ),
        //     ),
        //   ),
        // ),
        Text(
          "only one tag per product is allow product here",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 20),
        Container(
          width: 242.0,
          height: 42.0,
          decoration: BoxDecoration(
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
        const SizedBox(height: 20),
        Container(
          width: 242.0,
          height: 42.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: const Color(0xff2c2c2c),
          ),
          child: const Center(
            child: Text(
              'Upload Image2',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 18,
                color: Colors.white,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ]),
    );
  }
}

class CustemTextField extends StatelessWidget {
  const CustemTextField({
    required this.hint,
     this.image="assets/icons/dribble.svg",
    super.key,
  });

  final String hint;
  final String image;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
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
              color: Colors.white,
              //color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(image),
          ),
        ),
      ),
    );
  }
}
