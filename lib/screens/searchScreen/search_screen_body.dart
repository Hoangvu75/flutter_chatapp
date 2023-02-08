import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/gradient_button.dart';
import '../../viewModels/searchScreenViewModels/search_screen_viewmodels.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> with TickerProviderStateMixin {
  late SearchScreenViewModel ssvm;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ssvm = Provider.of<SearchScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ssvm = Provider.of<SearchScreenViewModel>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20 * responsiveSize.width,
              right: 20 * responsiveSize.width,
              top: 20 * responsiveSize.height,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) => ssvm.search(searchController.text),
              decoration: InputDecoration(
                hintText: "Search for phone number...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(
                  15 * responsiveSize.width,
                  15 * responsiveSize.width,
                  15 * responsiveSize.width,
                  0,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  size: 28 * responsiveSize.width,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50 * responsiveSize.height,
          ),
          (ssvm.searchPhoneResponse != null)
              ? Column(
                  children: [
                    SizedBox(
                      width: 150 * responsiveSize.width,
                      height: 150 * responsiveSize.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(250 * responsiveSize.width),
                        child: (ssvm.searchPhoneResponse!.profile!.avatar == "")
                            ? SvgPicture.asset(Assets.svgsAvatarDefault)
                            : Image.network(
                                ssvm.searchPhoneResponse!.profile!.avatar!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20 * responsiveSize.height,
                    ),
                    Text(
                      ssvm.searchPhoneResponse!.profile!.name!,
                      style:
                          TextStyle(fontSize: 26 * responsiveSize.width, fontFamily: Assets.fontsSVNGilroyRegular),
                    ),
                    SizedBox(
                      height: 10 * responsiveSize.height,
                    ),
                    Text(
                      ssvm.searchPhoneResponse!.profile!.birthday!,
                      style: TextStyle(
                        fontSize: 16 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    (phoneNumber == searchController.text)
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.all(20 * responsiveSize.width),
                            child: ScaleTap(
                              child: GradientButton(
                                title: "Connect",
                                onTap: () {
                                  ssvm.connect(searchController.text);
                                  showToast(
                                    "Connected to ${searchController.text}",
                                    context: AppUtils.currentContext,
                                    position: StyledToastPosition(
                                      align: Alignment.bottomCenter,
                                      offset: 350 * responsiveSize.height,
                                    ),
                                    backgroundColor: PColors.gradientButtonStart,
                                    textPadding: EdgeInsets.symmetric(
                                      vertical: 20 * responsiveSize.height,
                                      horizontal: 50 * responsiveSize.width,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 20 * responsiveSize.width,
                                      color: Colors.white,
                                      fontFamily: Assets.fontsSVNGilroySemiBold,
                                    ),
                                    alignment: Alignment.topCenter,
                                    borderRadius: BorderRadius.circular(10 * responsiveSize.width),
                                    duration: const Duration(seconds: 4),
                                    animation: StyledToastAnimation.fade,
                                    reverseAnimation: StyledToastAnimation.rotate,
                                    animDuration: const Duration(seconds: 1),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
