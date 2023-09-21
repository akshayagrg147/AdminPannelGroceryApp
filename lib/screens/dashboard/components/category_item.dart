import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../commonWidget/common_elevted_Button.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';
import '../../../repositories/Modal/add_category_modal.dart';
import '../../../repositories/cubit/AddCategoryCubit.dart';
import '../../../repositories/cubit/AllProductCubit.dart';
import '../../../repositories/cubit/DeleteProductCubit.dart';
import '../../../responsive.dart';
import '../../../state/add_category_state.dart';
import '../../../state/delete_product_state.dart';
import '../NavScreen/CategoryScreen.dart';

class CategoryItems extends StatelessWidget {
  final List<ItemDataCategory>? itemData;
  final Function(String) deleteCategory;
  final ProductCategoryCubit cubit;

  CategoryItems(
    this.cubit,
    this.itemData,
    this.deleteCategory, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryCubit, DeleteProductState>(
        listener: (context1, state) {
      if (state is DeleteProductLoadedState) {
        SnackBar snackBar = const SnackBar(
          content: Text("Deleted Successfully"),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        deleteCategory("deleted");
      }
    }, builder: (context, state) {
      if (state is DeleteProductLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: SizedBox(
                    width: 220,
                    child: AddCard("Add new Category", onTap: (tap) {
                      print("Add new Category $tap");
                      if (tap) {
                        openAlert(context, false, ItemData(),
                            (s) => {if (s == "added") cubit.fetchCategory()});
                      }
                    }),
                  ),
                ),
              ),
    BlocConsumer<DeleteCategoryCubit, DeleteProductState>(
    listener: (context, state) {
    if (state is DeleteProductErrorState) {
    SnackBar snackBar = SnackBar(
    content: Text(state.error),
    backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    BlocProvider.of<DeleteCategoryCubit>(context)
        .resetState();
    }
    else if(state is DeleteProductLoadedState){
      SnackBar snackBar = const SnackBar(
        content: Text('Deleted category Sucessfully'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      BlocProvider.of<DeleteCategoryCubit>(context)
          .resetState();
    }
    },
        builder: (context, state) {
    if (state is DeleteProductLoadingState) {
    return Container();
    }
    else if (state is DeleteProductLoadedState) {
    log(state.products.runtimeType.toString());



    //   return Text("${obj.message}");
    } else if (state is DeleteProductErrorState) {
    return Center(
    child: Text(state.error),
    );
    }

  return  ListView.builder(
                shrinkWrap: true,
                itemCount: itemData!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = itemData![index];

                  return productItemRow(data, context,(value){
                    BlocProvider.of<DeleteCategoryCubit>(context)
                        .deleteCategory(value);

                  });
                },
              );
    })
            ],
          ),
        ),
      );
    });
  }
}

Widget productItemRow(ItemDataCategory data, BuildContext context,Function(String) itemPass) {
  bool isSnackBarShown = false;
  return Padding(
    key: UniqueKey(),
    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
    child: Container(
      // padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Text(data.category.toString(),

              textAlign: TextAlign.start,

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black,)),
        ),
        Expanded(
          child: Image.network(
            data.imageUrl.toString(),
            width: 100,
            height: 100,
            fit: BoxFit.fill,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListView.builder(
              itemCount: data.subCategoryList!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = data.subCategoryList![index];
                return Text(
                  item.name ?? "null",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,),
                );
              },
            ),
          ),
        ),
        Expanded(
             child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                itemPass(data.category!);

                // Perform delete operation
              },

             ),
           )
      ]),
    ),
  );
}

void openAlert(BuildContext context, bool editButton, ItemData data,
    final Function(String) addedCategory) {
  double dialogWidth = Responsive.isMobile(context) ? 300.0 : 600.0;
  TextEditingController categoryName = TextEditingController();
  TextEditingController subCategory1 = TextEditingController();
  TextEditingController subCategory2 = TextEditingController();
  TextEditingController subCategory3 = TextEditingController();
  TextEditingController subCategory4 = TextEditingController();
  bool isLoading = false;
  List<ImageKitRequest> imageupload = [
    ImageKitRequest("null", null),
    ImageKitRequest("null", null),
    ImageKitRequest("null", null),
    ImageKitRequest("null", null),
    ImageKitRequest("null", null),
    ImageKitRequest("null", null),
  ];
  int pressCount = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          color: Colors.white,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return BlocConsumer<AddCategoryCubit, AddCategoryState>(
                listener: (context, state) {
                  if (state is AddCategoryErrorState) {
                    SnackBar snackBar = SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state is AddCategoryLoadedState) {
                    addedCategory("added");
                    SnackBar snackBar = const SnackBar(
                      content: Text('Success'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is AddCategoryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AddCategoryLoadedState) {
                    var response = state.products;
                    if (response.statusCode == 200) {
                      CategoryScreen();
                      Navigator.of(context).pop();
                    }
                  }
                  return Container(
                    width: Responsive.isMobile(context) ? 250.0 : 400.0,
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                              width: double.infinity,
                              child: Text("ADD Coupon",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ))),
                          const SizedBox(height: 20),
                          commonTextFieldWidget(
                            type: TextInputType.text,
                            controller: categoryName,
                            hintText: "Bottle",
                            secondaryColor: Colors.white,
                            labelText: "Enter category",
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 20),
                          CommonImageButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });

                              _uploadImage((imageFile, imageId) {
                                if (imageFile != null) {
                                  setState(() {
                                    isLoading = false;
                                    imageupload[0] =
                                        (ImageKitRequest(imageFile, imageId));
                                  });
                                } else {
                                  // Image file is null, handle the error
                                  print(
                                      'Error occurred while picking or reading the image file');
                                }
                              });
                            },
                            buttonText: "Upload category",
                            selectedImagePath:
                                imageupload[0].imageUrl!.contains("null")
                                    ? ImageKitRequest(null, null)
                                    : imageupload[0],
                            deleteImage: (ob) {
                              deleteImage(
                                  "public_CNOvWRGNG5CloBTlee3SVVdDvYM=",
                                  "private_mtuLv1FkF+TOXlUyH/YlB/BJguQ=",
                                  ob.imageId);
                              imageupload[0] = (ImageKitRequest("null", null));
                            },
                          ),
                          //subcontroller 1
                          const SizedBox(
                            height: 10,
                          ),
                          isLoading ? CircularProgressIndicator() : SizedBox(),
                          commonTextFieldWidget(
                            type: TextInputType.text,
                            controller: subCategory1,
                            hintText: "Bottle",
                            secondaryColor: Colors.white,
                            labelText: "Enter subcategory 1",
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 20),
                          CommonImageButton(
                            onPressed: () {
                              print(pressCount);
                              _uploadImage((imageFile, imageId) {
                                print('Image uploaded! ${imageFile}');
                                setState(() {
                                  imageupload[1] =
                                      (ImageKitRequest(imageFile, imageId));
                                });
                              });
                            },
                            buttonText: "Upload sub category",
                            selectedImagePath:
                                imageupload[1].imageUrl!.contains("null")
                                    ? ImageKitRequest(null, null)
                                    : imageupload[1],
                            deleteImage: (obj) {
                              setState(() {
                                imageupload[1] = (ImageKitRequest("null", null));
                              });
                            },
                          ),

                          //sub controller 2
                          const SizedBox(
                            height: 10,
                          ),
                          commonTextFieldWidget(
                            type: TextInputType.text,
                            controller: subCategory2,
                            hintText: "Bottle",
                            secondaryColor: Colors.white,
                            labelText: "Enter subcategory 2",
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 20),
                          CommonImageButton(
                            onPressed: () {
                              print(pressCount);
                              _uploadImage((imageFile, imageId) {
                                print('Image uploaded! ${imageFile}');
                                setState(() {
                                  imageupload[2] =
                                      (ImageKitRequest(imageFile, imageId));
                                });
                              });
                            },
                            buttonText: "Upload sub category",
                            selectedImagePath:
                                imageupload[2].imageUrl!.contains("null")
                                    ? ImageKitRequest(null, null)
                                    : imageupload[2],
                            deleteImage: (obj) {
                              setState(() {
                                imageupload[2] = (ImageKitRequest("null", null));
                              });
                            },
                          ),

                          //sub controller 3

                          const SizedBox(
                            height: 10,
                          ),
                          commonTextFieldWidget(
                            type: TextInputType.text,
                            controller: subCategory3,
                            hintText: "Bottle",
                            secondaryColor: Colors.white,
                            labelText: "Enter subcategory 3",
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 20),
                          CommonImageButton(
                            onPressed: () {
                              print(pressCount);
                              _uploadImage((imageFile, imageId) {
                                print('Image uploaded! ${imageFile}');
                                setState(() {
                                  imageupload[3] =
                                      (ImageKitRequest(imageFile, imageId));
                                });
                              });
                            },
                            buttonText: "Upload sub category",
                            selectedImagePath:
                                imageupload[3].imageUrl!.contains("null")
                                    ? ImageKitRequest(null, null)
                                    : imageupload[3],
                            deleteImage: (obj) {
                              setState(() {
                                imageupload[3] = (ImageKitRequest(null, "null"));
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          commonTextFieldWidget(
                            type: TextInputType.text,
                            controller: subCategory4,
                            hintText: "Bottle",
                            secondaryColor: Colors.white,
                            labelText: "Enter subcategory4",
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 20),
                          CommonImageButton(
                            onPressed: () {
                              print(pressCount);
                              _uploadImage((imageFile, imageId) {
                                print('Image uploaded! ${imageFile}');
                                setState(() {
                                  imageupload[4] =
                                      (ImageKitRequest(imageFile, imageId));
                                });
                              });
                            },
                            buttonText: "Upload sub category",
                            selectedImagePath:
                                imageupload[4].imageUrl!.contains("null")
                                    ? ImageKitRequest(null, null)
                                    : imageupload[4],
                            deleteImage: (obj) {
                              setState(() {
                                imageupload[4] = (ImageKitRequest(null, "null"));
                              });
                            },
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 15)),
                              ),
                              onPressed: () {
                                // List<AddSubCategoryList> list = getDataFromControllers(controllers);
                                List<SubCategoryListData> list = [
                                  SubCategoryListData(
                                      name: subCategory1.text,
                                      image: imageupload[1].imageUrl),
                                  SubCategoryListData(
                                      name: subCategory2.text,
                                      image: imageupload[2].imageUrl),
                                  SubCategoryListData(
                                      name: subCategory3.text,
                                      image: imageupload[3].imageUrl),
                                  SubCategoryListData(
                                      name: subCategory4.text,
                                      image: imageupload[4].imageUrl)
                                ];
                                if ((categoryName.text.isNotEmpty &&
                                        imageupload[0]
                                            .imageUrl!
                                            .contains("null")) ||
                                    (categoryName.text.isEmpty &&
                                        !imageupload[0]
                                            .imageUrl!
                                            .contains("null"))) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please upload categoryName Url'),
                                    ),
                                  );
                                  return;
                                }
                                if ((subCategory1.text.isNotEmpty &&
                                        imageupload[1]
                                            .imageUrl!
                                            .contains("null")) ||
                                    (subCategory1.text.isEmpty &&
                                        !imageupload[1]
                                            .imageUrl!
                                            .contains("null"))) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please upload subCategory1 Url'),
                                    ),
                                  );
                                  return;
                                }
                                if ((subCategory2.text.isNotEmpty &&
                                        imageupload[2]
                                            .imageUrl!
                                            .contains("null")) ||
                                    (subCategory2.text.isEmpty &&
                                        !imageupload[2]
                                            .imageUrl!
                                            .contains("null"))) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please upload subCategory2'),
                                    ),
                                  );
                                  return;
                                }
                                if ((subCategory3.text.isNotEmpty &&
                                        imageupload[3]
                                            .imageUrl!
                                            .contains("null")) ||
                                    (subCategory3.text.isEmpty &&
                                        !imageupload[3]
                                            .imageUrl!
                                            .contains("null"))) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please upload subCategory3 Url'),
                                    ),
                                  );
                                  return;
                                }
                                if ((subCategory4.text.isNotEmpty &&
                                        imageupload[4]
                                            .imageUrl!
                                            .contains("null")) ||
                                    (subCategory4.text.isEmpty &&
                                        !imageupload[4]
                                            .imageUrl!
                                            .contains("null"))) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please upload subCategory4 Url'),
                                    ),
                                  );
                                  return;
                                }

                                print('imageupload_0 ${imageupload[0].imageUrl}');
                                BlocProvider.of<AddCategoryCubit>(context)
                                    .addCategory(list, categoryName.text,
                                        imageupload[0].imageUrl!);
                              },
                              child: const Text('Save!'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 15)),
                              ),
                              onPressed: () {},
                              child: const Text('Cancel!'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}

Future<void> _uploadImage(Function(String, String) fn) async {
  var headers = {
    'Authorization':
        'Basic cHJpdmF0ZV9tdHVMdjFGa0YrVE9YbFV5SC9ZbEIvQkpndVE9Og=='
  };

  var url = 'https://upload.imagekit.io/api/v1/files/upload';

  // Select an image using ImagePicker
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    var imageFile = await pickedImage.readAsBytes();

    try {
      var dio = Dio();
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageFile,
          filename: pickedImage.path.split('/').last,
        ),
        'fileName': 'image_$timestamp.png',
        'folder': 'category',
      });

      var response = await dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        var responseData = jsonResponse["url"].toString();
        fn(responseData, jsonResponse["fileId"].toString());
        print('Image uploaded! ${responseData}   @@${jsonResponse["fileId"].toString()}');
      } else {
        print('Failed to upload image: ${response.statusMessage}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  } else {
    print('No image selected.');
  }
}
