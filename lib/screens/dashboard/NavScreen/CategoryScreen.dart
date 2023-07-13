import 'dart:convert';
import 'dart:developer';




import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';
import 'package:adminpannelgrocery/state/all_category_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../commonWidget/common_elevted_Button.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';
import '../../../repositories/Modal/add_category_modal.dart';
import '../../../repositories/cubit/AddCategoryCubit.dart';
import '../components/category_item.dart';
import 'package:image_picker/image_picker.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  late ProductCategoryCubit Cubit;
  late DeleteProductCubit cubitdeleteNewProuct;
  List<ItemDataCategory>? listProducts = [];


  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<ProductCategoryCubit>(context);
    cubitdeleteNewProuct = BlocProvider.of<DeleteProductCubit>(context);
    Cubit.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
// if(listProducts?.isNotEmpty ?? true)
              Align(
                alignment: Alignment.topRight,
                child: AddCard(onTap: (tap) {
                  if (tap) {
                    openAlert(context, false, ItemData(),
                        (s) => {Cubit.fetchCategory()});
                  }
                }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: SideMenu(),
                    ),
                  Expanded(
                    flex: 5,
                    child: SafeArea(
                      child:
                          BlocConsumer<ProductCategoryCubit, AllCategoryState>(
                        listener: (context, state) {
                          if (state is AllCategoryErrorState) {
                            SnackBar snackBar = SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          print(state);
                          if (state is AllCategoryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllCategoryLoadedState) {
                            print(
                                'category Items ${state.category.itemData?.length.toString()}');
                            log(state.category.runtimeType.toString());
                            var obj = state.category;
                            listProducts = obj.itemData ?? [];
                            return CategoryItems(listProducts, (delete) {
                              Cubit.fetchCategory();
                            });
                            //   return Text("${obj.message}");
                          } else if (state is AllCategoryErrorState) {
                            return Center(
                              child: Text(state.error),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

void openAlert(BuildContext context, bool editButton, ItemData data,
    final Function(String) addedCategory) {
  double dialogWidth = Responsive.isMobile(context) ? 300.0 : 600.0;
  TextEditingController categoryName = TextEditingController();
  String imagefile="";

  List<Widget> textFields = [];
  List<ImageKitRequest> imageupload=[];

  List<TextEditingController> controllers = [];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(32.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                  SnackBar snackBar = const SnackBar(
                    content: Text('Success'),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  addedCategory("");
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
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        commonTextFieldWidget(
                          type: TextInputType.text,
                          controller: categoryName,
                          hintText: "Bottle",
                          secondaryColor: secondaryColor,
                          labelText: "Enter subcategory",
                          onChanged: (val) {},
                        ),
                        CommonImageButton(
                          onPressed: () {
                            _uploadImage((imageFile,imageId) {
                              if (imageFile != null) {
                                setState(() {
                                  imageupload.add(ImageKitRequest(imageFile, imageId));
                                });
                              } else {
                                // Image file is null, handle the error
                                print('Error occurred while picking or reading the image file');
                              }
                            });
                          },
                          buttonText: "Upload category",
                          selectedImagePath: imageupload.isNotEmpty ? imageupload[0]:ImageKitRequest( null,null),
                          deleteImage: (ob){

deleteImage("public_CNOvWRGNG5CloBTlee3SVVdDvYM=", "private_mtuLv1FkF+TOXlUyH/YlB/BJguQ=", ob.imageId);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              TextEditingController controller = TextEditingController();
                              controllers.add(controller);
                              textFields.add(
                                commonTextFieldWidget(
                                  type: TextInputType.text,
                                  controller: controller,
                                  hintText: "Bottle",
                                  secondaryColor: secondaryColor,
                                  labelText: "Enter subcategory",
                                  onChanged: (val) {},
                                ),
                              );
                              CommonImageButton(
                                onPressed: () {
                                  _uploadImage((imageFile,imageId) {
                                    if (imageFile != null) {
                                      // imageupload.add(imageFile);
                                      // imagefile = imageFile.toString();
                                    } else {
                                      // Image file is null, handle the error
                                      print('Error occurred while picking or reading the image file');
                                    }
                                  });
                                },
                                buttonText: "Upload sub category",
                                selectedImagePath: imageupload.isNotEmpty ? imageupload[0]:ImageKitRequest(null,null),
                                deleteImage: (obj){

                                },
                              );
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                        Column(
                          children: textFields,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                              textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15)),
                            ),
                            onPressed: () {
                              List<AddSubCategoryList> list = getDataFromControllers(controllers);
                              print('listOfSize is $list');
                              BlocProvider.of<AddCategoryCubit>(context).addCategory(list, categoryName.text);
                            },
                            child: const Text('Save!'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                              textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 15)),
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
      );
    },
  );
}

class ImageKitRequest {
  String ?imageUrl;
  String ?imageId;
  ImageKitRequest(this.imageUrl,this.imageId);
}



Future<void> deleteImage(String publicKey, String privateKey, String imageId) async {
  final authString = '$publicKey:$privateKey';
  final encodedAuth = base64.encode(utf8.encode(authString));

  final dio = Dio();
  dio.options.headers['Authorization'] = 'Basic $encodedAuth';

  final url = 'https://api.imagekit.io/v1/files/$imageId';

  try {
    final response = await dio.delete(url);

    if (response.statusCode == 204) {
      // Image deleted successfully
      print('Image deleted successfully');
    } else {
      // Error deleting image
      print('Error deleting image: ${response.data}');
    }
  } catch (error) {
    // Error handling
    print('Error deleting image: $error');
  }
}




Future<void> _uploadImage(Function(String,String) fn) async {
  var headers = {
    'Authorization': 'Basic cHJpdmF0ZV9tdHVMdjFGa0YrVE9YbFV5SC9ZbEIvQkpndVE9Og=='
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
        'fileName':'image_$timestamp.png'
      });

        var response = await dio.post(
          url,
          data: formData,
          options: Options(headers: headers),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = response.data;
          var responseData = jsonResponse["url"].toString();
          fn(responseData,jsonResponse["fileId"].toString());
        print('Image uploaded! ${responseData}');
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











List<AddSubCategoryList> getDataFromControllers(
    List<TextEditingController> controllers) {
  List<AddSubCategoryList> data = [];
  for (var controller in controllers) {
    data.add(AddSubCategoryList(name: controller.text));
  }
  return data;
}

void setState(Null Function() param0) {}

enum State1 { yes, no }
