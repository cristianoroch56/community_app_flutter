import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/news_details/news_details_controller.dart';
import 'package:community_app/widget/custom_alert_dialogue.dart';
import 'package:community_app/widget/custom_report_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/functions.dart';
import '../../constants/responsive.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsDetailsController>(
      init: NewsDetailsController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: Customappbarwidget(
            title: "",
            style: titleTextStyle.copyWith(fontSize: 18),
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
            leadingWidth: wp(14),
            leadingonTap: () {
              Get.back();
            },
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: hp(2)),
                Text(controller.news?.newsTitle ?? "",
                    style: titleTextStyle.copyWith(
                        color: Theme.of(context).primaryColorDark)),
                SizedBox(height: hp(2)),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/ic_clock.svg",
                        height: 16, width: 16),
                    SizedBox(width: wp(2)),
                    Text(getTimeDuration("${controller.news?.createdAt}"),
                        style: textMediumSmallStyle.copyWith(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.24))),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (controller.isReprtedNews.value == false) {
                          showDialog(
                            context: context,
                            builder: (ctx) => CustomAlertDialog(
                              title: Text(
                                Tkey.report.tr,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                Tkey.areYouSureYouWantToReport.tr,
                                textAlign: TextAlign.center,
                              ),
                              onPressedNo: () {
                                Get.back();
                              },
                              onPressedYes: () {
                                controller.reportNewsDetailsFunction(
                                    controller.news?.id);
                                Get.back();
                              },
                            ),
                          );
                        }
                      },
                      child: Obx(
                        () => CustomReportButton(
                            isReported: controller.isReprtedNews.value),
                      ),
                    )
                  ],
                ),
                SizedBox(height: hp(2)),
                Text(
                  controller.news?.newsContent ?? "",
                  style: textMediumSmallStyle.copyWith(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.8)),
                ),
                SizedBox(height: hp(3)),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      "${controller.news?.image}",
                      height: hp(28),
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          height: hp(30),
                          width: wp(100),
                          child: Icon(
                            Icons.image,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        height: hp(30),
                        width: wp(100),
                        child: Icon(
                          Icons.image,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
