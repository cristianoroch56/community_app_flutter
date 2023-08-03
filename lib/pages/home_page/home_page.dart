import 'package:community_app/constants/responsive.dart';
import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/pages/auth/cache_manager.dart';
import 'package:community_app/pages/home_page/homepage_controller.dart';
import 'package:community_app/widget/custom_datalist_card/latest_events_data.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constants/functions.dart';
import '../../translation/key.dart';
import '../../routes/app_routes.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_no_data.dart';

class Homepage extends StatelessWidget with CacheManager {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      initState: (_) {},
      builder: (controller) {
        return CustomRefreshIndicator(
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
            child: Obx(
              () => Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: Customappbarwidget(
                  title: "Hi, ${getUserName() ?? "Good Morning"} ",
                  leadingchild: Padding(
                    padding: EdgeInsets.only(
                        top: hp(2.5), left: wp(4), bottom: hp(0.5)),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 10,
                      child: Text(getUserName()!.substring(0, 1).toUpperCase()),
                    ),
                  ),
                  actions: [
                    InkWell(
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
                                  ))
                        ]),
                      ),
                    ),
                  ],
                ),
                body: controller.newsList.isEmpty &&
                        controller.latestEventsList.isEmpty
                    ? Center(
                        heightFactor: hp(0.4),
                        child: const SizedBox(
                          child: CustomNoData(
                            iconaddress: card,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: wp(4), top: hp(2.5)),
                                  child: controller.newsList.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          Tkey.latestnews.tr,
                                          style: textMediumStyle.copyWith(
                                              fontFamily: fontMedium,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                ),
                                const Spacer(),
                                controller.newsList.isEmpty
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          right: wp(4),
                                          top: hp(2.5),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller
                                                .newsList.isNotEmpty) {
                                              Get.toNamed(
                                                  ROUTE_LATESTNEWS_PAGE);
                                            }
                                          },
                                          child: Text(
                                            Tkey.seeall.tr,
                                            style: textMediumStyle.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: hp(2)),
                            Padding(
                              padding: EdgeInsets.only(left: wp(2)),
                              child: SizedBox(
                                  height: hp(23.8),
                                  child: controller.newsList.isEmpty
                                      ? Center(
                                          child: Text(
                                          Tkey.noNewsFound.tr,
                                          style: textMediumStyle.copyWith(
                                              fontFamily: fontMedium),
                                        ))
                                      : Obx(
                                          () => ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller
                                                          .pageSizeNews.value <
                                                      controller.newsList.length
                                                  ? controller
                                                      .pageSizeNews.value
                                                  : controller.newsList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                                  width: wp(40),
                                                  decoration: BoxDecoration(
                                                    color: COLOR_WHITE,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: COLOR_BOXSHADOW,
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          ROUTE_NEWSDETAIL_PAGE,
                                                          arguments: controller
                                                              .newsList[index]);
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            child: Image.network(
                                                                "${controller.newsList[index].image}",
                                                                height: hp(11),
                                                                width: wp(100),
                                                                fit:
                                                                    BoxFit.fill,
                                                                loadingBuilder:
                                                                    (context,
                                                                        child,
                                                                        loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null) {
                                                                    return child;
                                                                  }
                                                                  return Container(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            0.3),
                                                                    height:
                                                                        hp(11),
                                                                    width:
                                                                        wp(100),
                                                                    child: Icon(
                                                                      Icons
                                                                          .image,
                                                                      size: 30,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                  );
                                                                },
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Container(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor
                                                                          .withOpacity(
                                                                              0.3),
                                                                      height:
                                                                          hp(11),
                                                                      width: wp(
                                                                          100),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .image,
                                                                        size:
                                                                            30,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    ))),
                                                        SizedBox(
                                                            height: hp(0.5)),
                                                        Text(
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${controller.newsList[index].newsContent}",
                                                          style: smallRegularTextStyle
                                                              .copyWith(
                                                                  fontFamily:
                                                                      fontMedium,
                                                                  fontSize: dp(
                                                                      context,
                                                                      10)),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(height: hp(1)),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/ic_clock.svg',
                                                              height: hp(1.8),
                                                            ),
                                                            SizedBox(
                                                                width: wp(1)),
                                                            Text(
                                                                getTimeDuration(
                                                                    "${controller.newsList[index].createdAt}"),
                                                                style: smallRegularTextStyle.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorLight))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: wp(4), top: hp(2.5)),
                                  child: controller.latestEventsList.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          Tkey.latestevents.tr,
                                          style: textMediumStyle.copyWith(
                                              fontFamily: fontMedium,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                ),
                                const Spacer(),
                                controller.latestEventsList.isEmpty
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            right: wp(4), top: hp(2.5)),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller
                                                .latestEventsList.isNotEmpty) {
                                              Get.toNamed(
                                                  ROUTE_LATESTEVENTS_PAGE);
                                            }
                                          },
                                          child: Text(
                                            Tkey.seeall.tr,
                                            style: textMediumStyle.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: hp(2)),
                            Padding(
                              padding: EdgeInsets.only(left: wp(2)),
                              child: SizedBox(
                                height: hp(24),
                                child: controller.latestEventsList.isEmpty
                                    ? Center(
                                        child: Text(
                                        Tkey.noEventsFound.tr,
                                        style: textMediumStyle.copyWith(
                                            fontFamily: fontMedium),
                                      ))
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller
                                                    .pageSizeEvents.value <
                                                controller
                                                    .latestEventsList.length
                                            ? controller.pageSizeEvents.value
                                            : controller
                                                .latestEventsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (controller
                                              .latestEventsList.isEmpty) {
                                            Text(Tkey.noEventsFound.tr);
                                          } else {
                                            final event = controller
                                                .latestEventsList[index];
                                            return Latesteventsdata(
                                              event: event,
                                              isLive: getLiveStatus(
                                                  event.eventDate,
                                                  event.eventDuration),
                                            );
                                          }
                                          return null;
                                        }),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ));
      },
    );
  }
}
