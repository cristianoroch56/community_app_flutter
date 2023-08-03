import 'package:community_app/constants/responsive.dart';
import 'package:community_app/pages/event_details/event_details_controller.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/style.dart';
import '../../constants/textstyle.dart';
import '../../pages/latest_events/model/events_model.dart';

class Latesteventsdata extends StatelessWidget {
  final Events event;
  final bool isLive;
  const Latesteventsdata(
      {super.key, required this.event, required this.isLive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(0.2)),
      width: wp(58),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            blurRadius: 10.0,
          ),
          BoxShadow(
            color: COLOR_BOXSHADOW,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(ROUTE_EVENTDETAILS_PAGE, arguments: event);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: wp(1), left: wp(1), top: hp(0.5)),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(event.eventImage,
                          height: hp(15),
                          width: wp(100),
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              color: COLOR_PRIMARY.withOpacity(0.3),
                              height: hp(15),
                              width: wp(100),
                              child: Icon(
                                Icons.image,
                                size: 30,
                                color: COLOR_PRIMARY,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: COLOR_PRIMARY.withOpacity(0.3),
                                height: hp(15),
                                width: wp(100),
                                child: Icon(
                                  Icons.image,
                                  size: 30,
                                  color: COLOR_PRIMARY,
                                ),
                              ))),
                  GetBuilder<EventDetailsController>(
                    init: EventDetailsController(),
                    initState: (_) {},
                    builder: (controller) {
                      return Positioned(
                        top: hp(0.5),
                        right: wp(1),
                        child: InkWell(
                          onTap: () {
                            event.isBookmarked = !event.isBookmarked;
                            controller.bookmarkEvent(
                                event.id, !event.isBookmarked);
                          },
                          child: CircleAvatar(
                            backgroundColor: COLOR_WHITE,
                            radius: 12,
                            child: SvgPicture.asset('assets/icons/ic_frame.svg',
                                height: 12,
                                colorFilter: event.isBookmarked
                                    ? ColorFilter.mode(
                                        COLOR_PRIMARY, BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn)),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !isLive
                      ? SizedBox(
                          height: hp(0.5),
                        )
                      : Container(),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Text(
                          event.eventName,
                          overflow: TextOverflow.ellipsis,
                          style: textMediumStyle.copyWith(
                              fontFamily: fontMedium,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      SizedBox(width: wp(1.5)),
                      isLive
                          ? Image.asset(
                              "assets/icons/1.5x/Instagram.png",
                              height: hp(5),
                              width: wp(9),
                            )
                          : Container(),
                      SizedBox(
                        width: wp(5),
                      )
                    ],
                  ),
                  !isLive
                      ? SizedBox(
                          height: hp(0.5),
                        )
                      : Container(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_Vector.svg',
                        height: hp(2),
                      ),
                      SizedBox(width: wp(1.5)),
                      Flexible(
                        child: Text(
                          event.location,
                          overflow: TextOverflow.ellipsis,
                          style: textSmallStyle.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
