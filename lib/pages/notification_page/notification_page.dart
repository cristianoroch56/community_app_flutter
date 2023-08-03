import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constants/functions.dart';
import '../../constants/style.dart';
import '../../constants/responsive.dart';
import '../../translation/key.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';
import 'notification_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        initState: (_) {},
        builder: (controller) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Customappbarwidget(
              leadingchild: Padding(
                padding: EdgeInsets.only(left: wp(5), top: hp(2)),
                child: SvgPicture.asset("assets/icons/ic_back.svg",
                    height: hp(2.4),
                    width: wp(2.4),
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColorDark, BlendMode.srcIn)),
              ),
              leadingonTap: () {
                Get.back();
              },
              leadingWidth: wp(14),
              title: Tkey.notificationtitele.tr,
              fontSize: 22,
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
              child: controller.isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                    ))
                  : controller.listofnotification.isEmpty
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: hp(5)),
                                Image.asset("assets/icons/3x/notification.png",
                                    height: hp(50), width: wp(70)),
                                Text(Tkey.noNotificationtexttitle.tr,
                                    style: titleTextStyle),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: wp(20), right: wp(20), top: hp(2)),
                                  child: Text(
                                      Tkey.noNotificationtextsubtitle.tr,
                                      style: textMediumSmallStyle.copyWith(
                                          fontSize: 14)),
                                ),
                                Text(Tkey.noNotificationtextsubtitle2.tr,
                                    style: textMediumSmallStyle.copyWith(
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: hp(1)),
                          child: ListView.builder(
                            controller: controller.scrollController,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.listofnotification.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: wp(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: COLOR_LIGHTGRAY,
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: hp(1), horizontal: wp(0.2)),
                                child: Slidable(
                                  closeOnScroll: true,
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: 0.2,
                                      children: [
                                        SlidableAction(
                                          autoClose: true,
                                          flex: 1,
                                          icon: Icons.delete,
                                          label: Tkey.delete.tr,
                                          spacing: 2,
                                          padding: const EdgeInsets.all(2),
                                          backgroundColor: Colors.red,
                                          onPressed: (context) {
                                            controller.deletNotification(
                                                id: controller
                                                    .listofnotification[index]
                                                    .id);
                                            controller.update();
                                          },
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: wp(5), vertical: hp(1)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${controller.listofnotification[index].title}",
                                            style: textMediumStyle.copyWith()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: wp(60),
                                                child: Text(
                                                    "${controller.listofnotification[index].content}",
                                                    style: textMediumSmallStyle
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              const Spacer(),
                                              Text(
                                                  formatDate(
                                                      "${controller.listofnotification[index].createdAt}"),
                                                  style: textMediumSmallStyle
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight)),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          getTimeDuration(
                                              "${controller.listofnotification[index].updatedAt}"),
                                          style: smallRegularTextStyle.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
            // ),
          );
        });
  }
}
