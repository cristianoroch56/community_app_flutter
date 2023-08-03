import 'package:community_app/routes/app_routes.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';
import '../../constants/responsive.dart';
import '../../constants/style.dart';
import '../../translation/key.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_no_data.dart';
import '../../widget/custom_textformfield.dart';
import '../../widget/custom_datalist_card/members_data.dart';
import '../auth/cache_manager.dart';
import 'member_controller.dart';

class Memberpage extends StatelessWidget with CacheManager {
  const Memberpage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemberController>(
      init: MemberController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            if (controller.focusNode!.hasFocus) {
              controller.focusNode!.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: COLOR_WHITE,
            appBar: Customappbarwidget(
              title: "${Tkey.hi.tr},${getUserName()} ",
              leadingchild: Padding(
                padding:
                    EdgeInsets.only(top: hp(2.5), left: wp(4), bottom: hp(0.5)),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 10,
                  child: Text(getUserName()!.substring(0, 1).toUpperCase()),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ROUTE_NOTIFICATION_PAGE);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: wp(4),
                      top: hp(2),
                    ),
                    child: Stack(children: [
                      SvgPicture.asset(
                        'assets/icons/ic_notification.svg',
                        height: hp(3),
                      ),
                      controller.isRead.value
                          ? const SizedBox.shrink()
                          : Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.circle,
                                color: Theme.of(context).primaryColor,
                                size: dp(context, 10),
                              ),
                            ),
                    ]),
                  ),
                ),
              ],
            ),
            body: CustomRefreshIndicator(
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
                child: Obx(() {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: COLOR_LIGHTGRAY,
                        ),
                        child: CustomTextFormField(
                          inputFormatters: [],
                          onFieldSubmitted: (value) {
                            controller.membersController.text =
                                controller.membersController.text;
                            controller.focusNode?.unfocus();
                            controller.getmember();
                            controller.update();
                          },
                          onEditingComplete: () {
                            controller.focusNode?.unfocus();
                            controller.searchmembers();
                            controller.update();
                          },
                          onChanged: (p0) {
                            if (controller.membersController.text.isEmpty) {
                              controller.currPage = 1;
                              controller.getmember();
                              controller.update();
                            }
                          },
                          textInputAction: TextInputAction.search,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 12,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.searchmembers();
                              controller.update();
                            },
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: Tkey.search.tr,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.text,
                          textEditingController: controller.membersController,
                          customobscuretext: true,
                        ),
                      ),
                      SizedBox(height: hp(2)),
                      controller.isLoading.value
                          ? Center(
                              child: SpinKitFadingCircle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : controller.listofmember.isEmpty
                              ? Center(
                                  heightFactor: hp(0.4),
                                  child: const SizedBox(
                                    child: CustomNoData(
                                      iconaddress: card,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: hp(73),
                                  child: LoadMore(
                                    isFinish: controller.listofmember.length >=
                                        controller.membersmodel!.count!,
                                    onLoadMore: controller.getMoreMember,
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
                                      controller: controller.scrollController,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.listofmember.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MembersData(
                                          allmembers:
                                              controller.listofmember[index],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    ],
                  );
                }),
              ),
            ),
          ),
          // ),
        );
      },
    );
  }
}
