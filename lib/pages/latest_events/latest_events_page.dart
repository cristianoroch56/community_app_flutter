import 'package:community_app/pages/latest_events/latest_events_controller.dart';
import 'package:community_app/widget/custom_datalist_card/latest_events_data.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constants/functions.dart';
import '../../constants/responsive.dart';
import '../../constants/style.dart';
import '../../translation/key.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_textformfield.dart';

class LatestEventsPage extends StatelessWidget {
  const LatestEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LatestEventsController>(
        init: LatestEventsController(),
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
                title: Tkey.latestevents.tr,
                fontSize: 22,
                leadingonTap: () {
                  Get.back();
                },
                leadingWidth: wp(14),
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
                            child:
                                Lottie.asset("assets/lottie/loadingbar.json"),
                          ),
                          Transform.translate(
                            offset:
                                Offset(0.0, 40.0 * indicatorcontroller.value),
                            child: child,
                          ),
                        ],
                      );
                    },
                  );
                },
                offsetToArmed: 40.0,
                onRefresh: controller.pullToRefresh,
                child: controller.latestEventsList.isEmpty
                    ? Center(
                        child: SpinKitFadingCircle(
                        color: Theme.of(context).primaryColor,
                      ))
                    : DefaultTabController(
                        length: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              SizedBox(height: hp(2)),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: wp(1)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: COLOR_LIGHTGRAY),
                                child: CustomTextFormField(
                                  textEditingController:
                                      controller.eventSearchController,
                                  focusNode: controller.focusNode,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: Tkey.search.tr,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      controller.getFirstPageEventsFunction();
                                    }
                                  },
                                  hintStyle: textMediumStyle.copyWith(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.12)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 12),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.eventSearchController
                                            .text.isNotEmpty) {
                                          controller.searchEventsFunction();
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
                                  onEditingComplete: () {
                                    if (controller.eventSearchController.text
                                        .isNotEmpty) {
                                      controller.searchEventsFunction();
                                    }
                                  },
                                  customobscuretext: true,
                                ),
                              ),
                              SizedBox(height: hp(2)),
                              TabBar(
                                  labelStyle: textMediumStyle.copyWith(
                                      fontFamily: fontMedium),
                                  labelColor:
                                      Theme.of(context).primaryColorDark,
                                  unselectedLabelColor: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.5),
                                  unselectedLabelStyle:
                                      textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                  tabs: [
                                    Tab(text: Tkey.latestEvents.tr),
                                    Tab(text: Tkey.upcomingEvents.tr),
                                  ]),
                              SizedBox(height: hp(2)),
                              Expanded(
                                child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      latestEvents(controller, context),
                                      upcomingEvents(controller)
                                    ]),
                              ),
                              controller.isLoading.value
                                  ? Center(
                                      child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SpinKitFadingCircle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                            Tkey.sealoadingwaitformomentrch.tr),
                                      ],
                                    ))
                                  : Container(),
                              SizedBox(
                                height: hp(2),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          );
        });
  }

  Widget latestEvents(LatestEventsController controller, context) {
    return GridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 200, crossAxisCount: 2, mainAxisSpacing: 14),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.latestEventsList.length,
        itemBuilder: (BuildContext context, int index) {
          final events = controller.latestEventsList[index];
          return Latesteventsdata(
            event: events,
            isLive: getLiveStatus(events.eventDate, events.eventDuration),
          );
        });
  }

  Widget upcomingEvents(LatestEventsController controller) {
    return GridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 200, crossAxisCount: 2, mainAxisSpacing: 10),
        scrollDirection: Axis.vertical,
        itemCount: controller.upcomingEventsList.length,
        itemBuilder: (BuildContext context, int index) {
          final events = controller.upcomingEventsList[index];
          return Latesteventsdata(
            event: events,
            isLive: getLiveStatus(events.eventDate, events.eventDuration),
          );
        });
  }
}
