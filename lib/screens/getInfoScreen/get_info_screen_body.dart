import 'dart:io';

import 'package:chatapp/screens/loginScreen/login_screen.dart';
import 'package:chatapp/src/gradient_button_loading.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:chatapp/viewModels/getInfoScreenViewModels/get_info_screen_viewmodels.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../utils/app_functions.dart';

class GetInfoScreenBody extends StatefulWidget {
  final String phone;
  final String password;

  const GetInfoScreenBody({super.key, required this.phone, required this.password});

  @override
  State<GetInfoScreenBody> createState() => _GetInfoScreenBodyState();
}

class _GetInfoScreenBodyState extends State<GetInfoScreenBody> with TickerProviderStateMixin {
  late GetInfoScreenViewModel gisvm;

  TextEditingController nameInputController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  String based64AvatarImage = "";

  File? avatarImage;
  String urlAvatarImage = "";

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    gisvm = Provider.of<GetInfoScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    gisvm = Provider.of<GetInfoScreenViewModel>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50 * responsiveSize.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18 * responsiveSize.width),
            child: Text(
              "Please let us know more about your information.",
              style: TextStyle(
                fontFamily: Assets.fontsSVNGilroyMedium,
                fontSize: 22 * responsiveSize.width,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50 * responsiveSize.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18 * responsiveSize.width),
            child: Row(
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: Assets.fontsSVNGilroyMedium,
                    fontSize: 20 * responsiveSize.width,
                  ),
                ),
                SizedBox(
                  width: 12 * responsiveSize.width,
                ),
                Flexible(
                  child: TextField(
                    controller: nameInputController,
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                    ),
                    style: TextStyle(
                      fontFamily: Assets.fontsSVNGilroyRegular,
                      fontSize: 16 * responsiveSize.width,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20 * responsiveSize.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18 * responsiveSize.width),
            child: Row(
              children: [
                Text(
                  "Date of birth",
                  style: TextStyle(
                    fontFamily: Assets.fontsSVNGilroyMedium,
                    fontSize: 20 * responsiveSize.width,
                  ),
                ),
                SizedBox(
                  width: 12 * responsiveSize.width,
                ),
                Flexible(
                  child: SizedBox(
                    child: Center(
                      child: TextField(
                        controller: dateInputController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date",
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateInputController.text = formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30 * responsiveSize.height,
          ),
          Text(
            "Pick an image to set your avatar",
            style: TextStyle(
              fontFamily: Assets.fontsSVNGilroyMedium,
              fontSize: 20 * responsiveSize.width,
            ),
          ),
          SizedBox(
            height: 20 * responsiveSize.height,
          ),
          Container(
            width: 250 * responsiveSize.width,
            height: 250 * responsiveSize.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(250 * responsiveSize.width),
            ),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                onAvatarImagePressed();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250 * responsiveSize.width),
                child: (avatarImage == null)
                    ? SvgPicture.asset(Assets.svgsAvatarDefault)
                    : Image.file(
                        avatarImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 20 * responsiveSize.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18 * responsiveSize.width),
            child: GradientButtonLoading(
              title: gisvm.saveBtnState,
              onTap: () {
                onGetInfoSubmit();
              },
              isLoading: (gisvm.loading) ? true : false,
            ),
          ),
        ],
      ),
    );
  }

  Future onAvatarImagePressed() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                onImagePick(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 26 * responsiveSize.height),
                  child: Center(
                    child: Text(
                      "Choose image from gallery",
                      style: TextStyle(
                        fontSize: 18 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1 * responsiveSize.height,
            ),
            InkWell(
              onTap: () {
                onImagePick(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 26 * responsiveSize.height),
                  child: Center(
                    child: Text(
                      "Capture image",
                      style: TextStyle(
                        fontSize: 18 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future onImagePick(ImageSource source) async {
    try {
      final image = await ImagePicker().getImage(source: source);
      if (image == null) {
        return;
      }
      File? img = File(image.path);
      img = await cropAvatarImage(imageFile: img);
      setState(() {
        avatarImage = img;
      });
    } on PlatformException catch (e) {
      CustomDialog().showDialog(
        SvgPicture.asset(Assets.svgsIcSystemError),
        "Oops! You've got an error!",
        e.toString(),
        () {},
        () {},
      );
    }
  }

  Future<File?> cropAvatarImage({required File imageFile}) async {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    return File(croppedFile!.path);
  }

  void onGetInfoSubmit() async {
    if (gisvm.saveBtnState == "Save") {
      if (nameInputController.text.isEmpty || dateInputController.text.isEmpty) {
        CustomDialog().showDialog(
          SvgPicture.asset(Assets.svgsIcSystemError),
          "Oops! You've got an error!",
          "Please fill up all fields.",
          () {},
          () {},
        );
      } else {
        setState(() {
          gisvm.loading = true;
        });
        if (avatarImage != null) {
          final ref = FirebaseStorage.instance.ref().child("avatar_${widget.phone}");
          final snapshot = await ref.putFile(avatarImage!).whenComplete(() => {});
          urlAvatarImage = await snapshot.ref.getDownloadURL();
        }
        gisvm.getInfo(
          widget.phone,
          widget.password,
          nameInputController.text,
          dateInputController.text,
          urlAvatarImage,
        );
      }
    } else if (gisvm.saveBtnState == "Finish") {
      CustomDialog().showDialog(
        SvgPicture.asset(Assets.svgsIcSuccess),
        "Everything is done!",
        "Start your journey now!",
        () {
          CustomNavigator().pushReplacePrevious(const LoginScreen());
        },
        () {
          CustomNavigator().pushReplacePrevious(const LoginScreen());
        },
      );
    }
  }
}
