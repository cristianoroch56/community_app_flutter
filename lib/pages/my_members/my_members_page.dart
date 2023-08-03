import 'package:community_app/pages/my_members/my_members_controller.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:community_app/widget/custom_appbar.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';
import '../../constants/style.dart';
import '../../constants/responsive.dart';
import '../../translation/key.dart';
import '../../widget/custom_no_data.dart';
import '../../widget/custom_textformfield.dart';
import '../../widget/custom_datalist_card/my_member_data.dart';

class Memberspage extends GetView<MymembersController> {
  const Memberspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.focusNode!.hasFocus) {
          controller.focusNode!.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: Customappbarwidget(
          leadingonTap: () {
            Get.back();
          },
          leadingWidth: wp(14),
          title: Tkey.myMembers.tr,
          fontSize: 22,
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(ROUTE_ADDMEMBERS_PAGE);
              },
              child: Padding(
                padding: EdgeInsets.only(right: wp(5), top: hp(2)),
                child: SvgPicture.asset("assets/icons/plus-square.svg",
                    height: hp(2.7),
                    width: wp(2.7),
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColorDark, BlendMode.srcIn)),
              ),
            )
          ],
          leadingchild: Padding(
            padding: EdgeInsets.only(left: wp(5), top: hp(2)),
            child: SvgPicture.asset("assets/icons/ic_back.svg",
                height: hp(2.4),
                width: wp(2.4),
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColorDark, BlendMode.srcIn)),
          ),
        ),
        body: Obx(
          () => CustomRefreshIndicator(
            builder: (context, child, indicatorcontroller) {
              return AnimatedBuilder(
                animation: indicatorcontroller,
                builder: (context, _) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100.0 * indicatorcontroller.value,
                        child: Lottie.asset("assets/lottie/loadingbar.json"),
                      ),
                      Transform.translate(
                        offset: Offset(0.0, 40.0 * indicatorcontroller.value),
                        child: child,
                      ),
                    ],
                  );
                },
              );
            },
            offsetToArmed: 40.0,
            onRefresh: controller.pullToRefresh,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: wp(4), right: wp(4), top: hp(2)),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: COLOR_LIGHTGRAY,
                    ),
                    child: CustomTextFormField(
                      onFieldSubmitted: (value) {
                        controller.mymemberController.text =
                            controller.mymemberController.text;
                        controller.focusNode?.unfocus();
                        controller.getmembers();
                        controller.update();
                      },
                      onEditingComplete: () {
                        controller.focusNode?.unfocus();
                        controller.searchmymembers();
                        controller.update();
                      },
                      onChanged: (p0) {
                        if (controller.mymemberController.text.isEmpty) {
                          controller.currentPage = 1;
                          controller.getmembers();
                          controller.update();
                        }
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 12,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.searchmymembers();
                          controller.update();
                        },
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      inputFormatters: [],
                      border: InputBorder.none,
                      hintText: Tkey.search.tr,
                      focusedBorder: InputBorder.none,
                      textCapitalization: TextCapitalization.none,
                      textInputType: TextInputType.text,
                      textEditingController: controller.mymemberController,
                      customobscuretext: true,
                    ),
                  ),
                  SizedBox(height: hp(2)),
                  controller.isLoading.value
                      ? Center(
                          heightFactor: hp(1.4),
                          child: SpinKitFadingCircle(
                            color: Theme.of(context).primaryColor,
                          ))
                      : controller.listofmembers.isEmpty
                          ? Center(
                              heightFactor: hp(0.4),
                              child: const SizedBox(
                                child: CustomNoData(
                                  iconaddress: card,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: hp(80),
                              child: LoadMore(
                                isFinish: controller.listofmembers.length >=
                                    controller.count.value,
                                onLoadMore: () => controller.getmembers(),
                                delegate: const DefaultLoadMoreDelegate(),
                                textBuilder: (LoadMoreStatus status) {
                                  String text;
                                  switch (status) {
                                    case LoadMoreStatus.fail:
                                      text = "load fail tap to retry".tr;
                                      break;
                                    case LoadMoreStatus.idle:
                                      text = "wait for loading".tr;
                                      break;
                                    case LoadMoreStatus.loading:
                                      text = "loading wait for moment".tr;
                                      break;
                                    case LoadMoreStatus.nomore:
                                      text = "";
                                      break;
                                    default:
                                      text = "";
                                  }
                                  return text;
                                },
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.listofmembers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MyMembersData(
                                        member:
                                            controller.listofmembers[index]);
                                  },
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
