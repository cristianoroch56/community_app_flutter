import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/responsive.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/pages/home_page/homepage_controller.dart';
import 'package:community_app/pages/latest_news/latest_news_controller.dart';
import 'package:community_app/widget/custom_appbar.dart';
import 'package:community_app/widget/custom_report_button.dart';
import 'package:community_app/widget/custom_textformfield.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';
import '../../routes/app_routes.dart';
import '../../widget/load_more_delegate.dart';

class LatestNewsPage extends StatelessWidget {
  const LatestNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LatestNewsController>(
      init: LatestNewsController(),
      initState: (_) {},
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            if (controller.focusNode.hasFocus) {
              controller.focusNode.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Customappbarwidget(
              title: Tkey.latestnews.tr,
              fontSize: 22,
              leadingWidth: wp(14),
              leadingonTap: () {
                HomePageController homePageController = Get.find();
                homePageController.getNewsFunction();
                homePageController.update();
                Get.back();
              },
              leadingchild: Padding(
                padding: EdgeInsets.only(left: wp(5), top: hp(2)),
                child: SvgPicture.asset(
                  "assets/icons/ic_back.svg",
                  height: hp(2.4),
                  width: wp(2.4),
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColorDark, BlendMode.srcIn),
                ),
              ),
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
              child: controller.newsList.isEmpty
                  ? Center(
                      child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                    ))
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      child: Column(
                        children: [
                          SizedBox(height: hp(2)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: wp(1)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: COLOR_LIGHTGRAY),
                            child: CustomTextFormField(
                                textEditingController:
                                    controller.searchNewsController,
                                focusNode: controller.focusNode,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: Tkey.search.tr,
                                hintStyle: textMediumStyle.copyWith(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.12)),
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.getFirstPageNewsFunction();
                                  }
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 12),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller.searchNewsController.text
                                          .isNotEmpty) {
                                        controller.searchNewsFunction();
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_search.svg",
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.24),
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(
                                    minHeight: 24, minWidth: 24),
                                textCapitalization: TextCapitalization.words,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                customobscuretext: true,
                                onEditingComplete: () {
                                  if (controller
                                      .searchNewsController.text.isNotEmpty) {
                                    controller.searchNewsFunction();
                                  }
                                }),
                          ),
                          SizedBox(height: hp(2)),
                          Expanded(
                            child: LoadMore(
                              isFinish: controller.newsList.length >=
                                  controller.newsModel!.count!,
                              onLoadMore: controller.getNewsFunction,
                              delegate: CustomLoadMoreDelegate(context),
                              textBuilder: (LoadMoreStatus status) {
                                String text;
                                switch (status) {
                                  case LoadMoreStatus.fail:
                                    text = "load fail tap to retry";
                                    break;
                                  case LoadMoreStatus.idle:
                                    text = "wait for loading";
                                    break;
                                  case LoadMoreStatus.loading:
                                    text = "loading wait for moment";
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
                                shrinkWrap: true,
                                itemCount: controller.newsList.length,
                                padding:
                                    EdgeInsets.symmetric(horizontal: wp(1)),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(ROUTE_NEWSDETAIL_PAGE,
                                          arguments:
                                              controller.newsList[index]);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: hp(1)),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: wp(4),
                                        vertical: hp(1),
                                      ),
                                      decoration: BoxDecoration(
                                        color: COLOR_WHITE,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.1),
                                              offset: const Offset(1, -1),
                                              spreadRadius: 0.5),
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.1),
                                              offset: const Offset(-1, 1),
                                              spreadRadius: 0.5),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                    controller.newsList[index]
                                                            .newsTitle ??
                                                        "",
                                                    style: textMediumStyle.copyWith(
                                                        fontFamily: fontMedium,
                                                        color: Theme.of(context)
                                                            .primaryColorDark)),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .newsList[index]
                                                            .isReported ==
                                                        false) {
                                                      controller
                                                          .reportNewsFunction(
                                                              controller
                                                                      .newsList[
                                                                  index],
                                                              context);
                                                    }
                                                  },
                                                  child: CustomReportButton(
                                                    isReported: controller
                                                            .newsList[index]
                                                            .isReported ??
                                                        false,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: hp(1)),
                                          ExpandableText(
                                              controller.newsList[index]
                                                      .newsContent ??
                                                  "",
                                              expandText: "Read More",
                                              collapseText: "Read Less",
                                              maxLines: 4,
                                              style: textMediumSmallStyle,
                                              linkColor: Theme.of(context)
                                                  .primaryColor),
                                          SizedBox(height: hp(1)),
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "${controller.newsList[index].image}",
                                                height: hp(27),
                                                fit: BoxFit.fill,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Container(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.3),
                                                    height: hp(27),
                                                    width: wp(100),
                                                    child: Icon(
                                                      Icons.image,
                                                      size: 30,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                  height: hp(27),
                                                  width: wp(100),
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 30,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
