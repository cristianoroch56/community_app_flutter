import 'package:community_app/pages/event_details/event_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/functions.dart';
import '../../constants/responsive.dart';
import '../../translation/key.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventDetailsController>(
      init: EventDetailsController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: Customappbarwidget(
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
            leadingonTap: () {
              Get.back();
            },
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(1)),
            physics: const BouncingScrollPhysics(),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  controller.events?.eventImage ?? "",
                  height: hp(30),
                  width: wp(100),
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
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
              SizedBox(height: hp(1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.events?.eventName ?? "",
                          style: titleTextStyle.copyWith(
                              color: Theme.of(context).primaryColorDark)),
                      Text(
                          formatEventDateTime(
                              controller.events?.eventDate ?? ""),
                          style: textSmallStyle.copyWith(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.8))),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.events?.isLiked =
                              !controller.events!.isLiked;
                          controller.likeEvent(controller.events!.id,
                              !controller.events!.isLiked);
                        },
                        child: controller.events!.isLiked
                            ? SvgPicture.asset(
                                "assets/icons/ic_heart_filled.svg",
                              )
                            : SvgPicture.asset("assets/icons/ic_heart.svg",
                                height: 24, width: 24),
                      ),
                      SizedBox(
                        width: wp(4),
                      ),
                      InkWell(
                        onTap: () {
                          controller.bookmarkEvent(controller.events!.id,
                              !controller.events!.isBookmarked);
                          controller.events?.isBookmarked =
                              !controller.events!.isBookmarked;
                        },
                        child: SvgPicture.asset(
                            "assets/icons/ic_frame_event.svg",
                            colorFilter: controller.events!.isBookmarked
                                ? ColorFilter.mode(
                                    Theme.of(context).primaryColor,
                                    BlendMode.srcIn)
                                : const ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                            height: 24,
                            width: 24),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: hp(3),
              ),
              Text(
                Tkey.aboutEvent.tr,
                style: titleTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(height: hp(1)),
              Text(
                controller.events?.eventContent ?? "",
                style: textMediumSmallStyle.copyWith(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                ),
              ),
              SizedBox(height: hp(3)),
              Text(
                Tkey.location.tr,
                style: titleTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(
                height: hp(1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_Vector.svg",
                      ),
                      SizedBox(
                        width: wp(2),
                      ),
                      Text(controller.events?.location ?? "",
                          style: textMediumSmallStyle.copyWith(
                              color: Theme.of(context).primaryColorDark)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      controller
                          .openGoogleMaps(controller.events?.location ?? "");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_map_arrow.svg",
                      height: 24,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
