import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/constants/style.dart';
import 'package:community_app/pages/chat_page/model/message_model.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/chat_page/chat_page_controller.dart';
import 'package:community_app/pages/message_page/message_controller.dart';
import 'package:community_app/widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/responsive.dart';
import '../../constants/textstyle.dart';
import '../auth/authentication_manager.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatPageController>(
      init: ChatPageController(),
      initState: (_) {},
      builder: (controller) {
        // Timer.periodic(const Duration(seconds: 5),
        //     (_) => controller.getMessagesFunction());
        return WillPopScope(
          onWillPop: () async {
            MessageController messageController = Get.find();
            messageController.getThreadsFunction();
            messageController.update();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.only(top: hp(1.5)),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 21,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          controller.thread?.user2Image ?? "",
                          height: hp(6.9),
                          width: wp(14),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                                child: SpinKitFadingCircle(
                              color: Theme.of(context).primaryColor,
                            ));
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                                AuthenticationManager().getUserId() ==
                                        controller.thread?.user1.toString()
                                    ? "${controller.thread?.user2Data?.firstName?.substring(0, 1)}${controller.thread?.user2Data?.lastName?.substring(0, 1)}"
                                    : "${controller.thread?.user1Data?.firstName?.substring(0, 1)}${controller.thread?.user1Data?.lastName?.substring(0, 1)}",
                                style: textMediumStyle.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: wp(2),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AuthenticationManager().getUserId() ==
                                  controller.thread?.user1.toString()
                              ? ("${controller.thread?.user2Data!.firstName} ${controller.thread?.user2Data!.lastName}")
                              : ("${controller.thread?.user1Data!.firstName} ${controller.thread?.user1Data!.lastName}"),
                          style: textMediumStyle.copyWith(
                              fontFamily: fontMedium,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Text(
                            AuthenticationManager().getUserId() ==
                                    controller.thread?.user1.toString()
                                ? "id: ${controller.thread?.user2Data!.id}"
                                : "id: ${controller.thread?.user1Data!.id}",
                            style: textMediumSmallStyle.copyWith(
                                color: Theme.of(context).primaryColorLight)),
                      ],
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: wp(5), top: hp(2)),
                child: InkWell(
                  onTap: () async {
                    Get.back();
                    MessageController messageController = Get.find();
                    messageController.getThreadsFunction();
                    messageController.update();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/ic_back.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColorDark, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2)),
              child: Column(
                children: [
                  SizedBox(
                    height: hp(1),
                  ),
                  Expanded(
                      child: GetBuilder<ChatPageController>(
                          init: ChatPageController(),
                          initState: (_) {},
                          builder: (controller) {
                            return ListView.builder(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: controller.messages.length,
                              padding: EdgeInsets.symmetric(horizontal: wp(1)),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                final reversedIndex =
                                    controller.messages.length - 1 - index;
                                MessageData message =
                                    controller.messages[reversedIndex];
                                return Column(
                                  children: [
                                    (reversedIndex == 0 ||
                                            (reversedIndex > 0 &&
                                                getDateTimeTag(
                                                        message.createdAt!) !=
                                                    getDateTimeTag(controller
                                                        .messages[
                                                            reversedIndex - 1]
                                                        .createdAt!)))
                                        ? Text(
                                            getDateTimeTag(message.createdAt!),
                                            style: textMediumStyle.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        : const SizedBox.shrink(),
                                    Align(
                                      alignment: message.sender ==
                                              (AuthenticationManager()
                                                          .getUserId() ==
                                                      controller.thread?.user1
                                                          .toString()
                                                  ? controller.thread
                                                      ?.user2Data!.username
                                                  : controller.thread
                                                      ?.user1Data!.username)
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: wp(2), vertical: hp(1)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: wp(2),
                                            vertical: hp(0.6)),
                                        decoration: BoxDecoration(
                                            color: message.sender ==
                                                    (AuthenticationManager()
                                                                .getUserId() ==
                                                            controller
                                                                .thread?.user1
                                                                .toString()
                                                        ? controller
                                                            .thread
                                                            ?.user2Data!
                                                            .username
                                                        : controller
                                                            .thread
                                                            ?.user1Data!
                                                            .username)
                                                ? Theme.of(context)
                                                    .primaryColorLight
                                                    .withOpacity(0.2)
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: message.message != null
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      message.message ?? "",
                                                      style: textMediumStyle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: wp(2),
                                                  ),
                                                  Text(
                                                    formatThreadDateTime(
                                                        message.createdAt!),
                                                    style: textMediumSmallStyle
                                                        .copyWith(fontSize: 7),
                                                  ),
                                                  SizedBox(
                                                    width: wp(1),
                                                  ),
                                                  message.sender ==
                                                          (AuthenticationManager()
                                                                      .getUserId() ==
                                                                  controller.thread
                                                                      ?.user1
                                                                      .toString()
                                                              ? controller
                                                                  .thread
                                                                  ?.user1Data!
                                                                  .username
                                                              : controller
                                                                  .thread
                                                                  ?.user2Data!
                                                                  .username)
                                                      ? message.isRead!
                                                          ? Image.asset(
                                                              "assets/icons/3x/right_tick.png",
                                                              scale: dp(
                                                                  context, 8),
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            )
                                                          : Image.asset(
                                                              "assets/icons/3x/right_tick.png",
                                                              scale: dp(
                                                                  context, 8),
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight,
                                                            )
                                                      : const SizedBox.shrink()
                                                ],
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            content: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(dp(
                                                                            context,
                                                                            20)),
                                                                child: Image
                                                                    .network(
                                                                  message.image ??
                                                                      "",
                                                                  width:
                                                                      wp(100),
                                                                  height:
                                                                      hp(40),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ))),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: wp(60),
                                                      height: hp(30),
                                                      child: message
                                                              .image!.isEmpty
                                                          ? SpinKitFadingCircle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .scaffoldBackgroundColor,
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: message
                                                                        .image ??
                                                                    "",
                                                                width: wp(60),
                                                                height: hp(30),
                                                                fit:
                                                                    BoxFit.fill,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    SpinKitFadingCircle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor,
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              ),
                                                            ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          formatThreadDateTime(
                                                              message
                                                                  .createdAt!),
                                                          style:
                                                              textMediumSmallStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          7),
                                                        ),
                                                        SizedBox(
                                                          width: wp(2),
                                                        ),
                                                        message.sender ==
                                                                (AuthenticationManager().getUserId() ==
                                                                        controller
                                                                            .thread
                                                                            ?.user1
                                                                            .toString()
                                                                    ? controller
                                                                        .thread
                                                                        ?.user1Data!
                                                                        .username
                                                                    : controller
                                                                        .thread
                                                                        ?.user2Data!
                                                                        .username)
                                                            ? message.isRead ==
                                                                    true
                                                                ? Image.asset(
                                                                    "assets/icons/3x/right_tick.png",
                                                                    scale: dp(
                                                                        context,
                                                                        8),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/icons/3x/right_tick.png",
                                                                    scale: dp(
                                                                        context,
                                                                        8),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorLight,
                                                                  )
                                                            : const SizedBox
                                                                .shrink()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          })),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: wp(1)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: COLOR_LIGHTGRAY,
                          ),
                          child: CustomTextFormField(
                              inputFormatters: [],
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  controller.setMessageStatus(true);
                                } else {
                                  controller.setMessageStatus(false);
                                }
                              },
                              textInputAction: TextInputAction.newline,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 12),
                              textCapitalization: TextCapitalization.sentences,
                              textInputType: TextInputType.multiline,
                              textEditingController:
                                  controller.messageController,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              customobscuretext: true,
                              hintText: Tkey.typeMessage.tr,
                              hintStyle: textMediumStyle,
                              suffixIcon:
                                  controller.messageController.text.isEmpty
                                      ? SizedBox(
                                          height: hp(3),
                                          width: wp(27),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: dp(context, 20),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.camera,
                                                        context);
                                                  }),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.photo,
                                                    size: dp(context, 20),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    controller.pickImage(
                                                        ImageSource.gallery,
                                                        context);
                                                  }),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                        ),
                      ),
                      (controller.messageController.text.isNotEmpty &&
                              controller.messageController.text != "")
                          ? IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                if (controller
                                    .messageController.text.isNotEmpty) {
                                  controller.sendMessage(
                                      controller.messageController.text);
                                }
                              },
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    height: hp(1),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
