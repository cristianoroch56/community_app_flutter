import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/pages/auth/cache_manager.dart';
import 'package:community_app/widget/custom_appbar.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constants/functions.dart';
import '../../constants/style.dart';
import '../../constants/responsive.dart';
import '../../constants/textstyle.dart';
import '../../routes/app_routes.dart';
import '../../translation/key.dart';
import '../../widget/custom_no_data.dart';
import '../../widget/custom_textformfield.dart';
import 'message_controller.dart';
import 'model/message_model.dart';

class Messagepage extends StatelessWidget with CacheManager {
  const Messagepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        init: MessageController(),
        initState: (_) {},
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              if (controller.focusNode!.hasFocus) {
                controller.focusNode!.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: Customappbarwidget(
                title: "${Tkey.hi.tr}, ${getUserName()} ",
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.only(left: wp(4), right: wp(4), top: hp(2)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: wp(1)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: COLOR_LIGHTGRAY,
                        ),
                        child: CustomTextFormField(
                          onFieldSubmitted: (value) {
                            controller.searchThreadController.text =
                                controller.searchThreadController.text;
                            controller.focusNode?.unfocus();
                            controller.getThreadByNameFunction(
                                controller.searchThreadController.text);
                            controller.update();
                          },
                          onEditingComplete: () {
                            controller.focusNode?.unfocus();
                            controller.getThreadByNameFunction(
                                controller.searchThreadController.text);
                            controller.update();
                          },
                          onChanged: (p0) {
                            if (controller
                                .searchThreadController.text.isEmpty) {
                              controller.getThreadByNameFunction(
                                  controller.searchThreadController.text);
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
                              controller.getThreadByNameFunction(
                                  controller.searchThreadController.text);
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
                          textEditingController:
                              controller.searchThreadController,
                          customobscuretext: true,
                        ),
                      ),
                      SizedBox(height: hp(2)),
                      controller.isLoading.value
                          ? Center(
                              heightFactor: hp(1.2),
                              child: SpinKitFadingCircle(
                                color: Theme.of(context).primaryColor,
                              ))
                          : controller.threads.isEmpty
                              ? Center(
                                  heightFactor: hp(0.4),
                                  child: const SizedBox(
                                    child: CustomNoData(
                                      iconaddress: card,
                                    ),
                                  ),
                                )
                              : GetBuilder<MessageController>(
                                  init: MessageController(),
                                  initState: (_) {},
                                  builder: (controller) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      controller: controller.scrollController,
                                      itemCount: controller.threads.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ThreadData thread =
                                            controller.threads[index];
                                        return InkWell(
                                            onTap: () {
                                              Get.toNamed(ROUTE_CHAT_PAGE,
                                                  arguments: thread);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: hp(0),
                                                  horizontal: wp(0.2)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: hp(1),
                                                                bottom: hp(1),
                                                                left: wp(2)),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          radius: 21,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            child:
                                                                Image.network(
                                                              thread.user2Image ??
                                                                  "",
                                                              height: hp(6.9),
                                                              width: wp(14),
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      progress) {
                                                                if (progress ==
                                                                    null) {
                                                                  return child;
                                                                }
                                                                return Center(
                                                                    child:
                                                                        SpinKitFadingCircle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ));
                                                              },
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Text(
                                                                    AuthenticationManager().getUserId() ==
                                                                            thread.user1
                                                                                .toString()
                                                                        ? "${thread.user2Data?.firstName?.substring(0, 1).toUpperCase()}${thread.user2Data?.lastName?.substring(0, 1).toUpperCase()}"
                                                                        : "${thread.user1Data?.firstName?.substring(0, 1).toUpperCase()}${thread.user1Data?.lastName?.substring(0, 1).toUpperCase()}",
                                                                    style: textMediumStyle
                                                                        .copyWith(
                                                                            color:
                                                                                Theme.of(context).scaffoldBackgroundColor));
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: wp(5)),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            AuthenticationManager()
                                                                        .getUserId() ==
                                                                    thread.user1
                                                                        .toString()
                                                                ? "${thread.user2Data?.firstName} ${thread.user2Data?.lastName}"
                                                                : "${thread.user1Data?.firstName} ${thread.user1Data?.lastName}",
                                                            style: textMediumStyle.copyWith(
                                                                fontFamily:
                                                                    fontMedium,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark),
                                                          ),
                                                          thread.lastMessage
                                                                          ?.message ==
                                                                      null &&
                                                                  thread.lastMessage
                                                                          ?.image ==
                                                                      null
                                                              ? SizedBox(
                                                                  height: hp(3))
                                                              : const SizedBox
                                                                  .shrink(),
                                                          Row(
                                                            children: [
                                                              thread.lastMessage
                                                                          ?.sender ==
                                                                      (AuthenticationManager().getUserId() ==
                                                                              thread.user1
                                                                                  .toString()
                                                                          ? thread
                                                                              .user1Data
                                                                              ?.username
                                                                          : thread
                                                                              .user2Data
                                                                              ?.username)
                                                                  ? Image.asset(
                                                                      "assets/icons/3x/right_tick.png",
                                                                      scale: dp(
                                                                          context,
                                                                          8),
                                                                      color: (thread.lastMessage?.message == null &&
                                                                              thread.lastMessage?.image ==
                                                                                  null)
                                                                          ? Colors
                                                                              .transparent
                                                                          : thread.lastMessage?.isRead == true
                                                                              ? Theme.of(context).primaryColor
                                                                              : Theme.of(context).primaryColorLight)
                                                                  : const SizedBox.shrink(),
                                                              SizedBox(
                                                                width: wp(1.5),
                                                              ),
                                                              thread.lastMessage
                                                                          ?.message !=
                                                                      null
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: hp(
                                                                              1)),
                                                                      child:
                                                                          SizedBox(
                                                                        width: wp(
                                                                            40),
                                                                        child:
                                                                            Text(
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          thread.lastMessage?.message ??
                                                                              "",
                                                                          style:
                                                                              textMediumSmallStyle.copyWith(color: Theme.of(context).primaryColorLight),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox
                                                                      .shrink(),
                                                              thread.lastMessage
                                                                          ?.image !=
                                                                      null
                                                                  ? Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top: hp(
                                                                            1),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.image,
                                                                            color:
                                                                                Theme.of(context).primaryColorLight,
                                                                            size:
                                                                                dp(context, 15),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                wp(0.5),
                                                                          ),
                                                                          Text(
                                                                              "Image",
                                                                              style: textMediumSmallStyle.copyWith(color: Theme.of(context).primaryColorLight)),
                                                                        ],
                                                                      ))
                                                                  : const SizedBox
                                                                      .shrink(),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: wp(5),
                                                                bottom: hp(2)),
                                                        child:
                                                            thread.lastMessage ==
                                                                    null
                                                                ? const Text("")
                                                                : Text(
                                                                    getDateTimeTag(
                                                                        thread.lastMessage!.createdAt ??
                                                                            ""),
                                                                    maxLines: 1,
                                                                    style: smallRegularTextStyle.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight),
                                                                  ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: COLOR_LIGHTGRAY,
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
