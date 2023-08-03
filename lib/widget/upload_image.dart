import 'package:community_app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/responsive.dart';
import '../translation/key.dart';

class Uploadimage extends StatelessWidget {
  final Function()? onTapCamera;
  final Function()? onTapGallery;
  const Uploadimage(
      {super.key, required this.onTapCamera, required this.onTapGallery});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      content: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: hp(22),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Tkey.picImageFrom.tr,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: COLOR_PRIMARY),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: hp(2),
              ),
              InkWell(
                onTap: onTapCamera,
                child: Container(
                  decoration: BoxDecoration(
                    color: COLOR_PRIMARY,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(
                            Icons.camera,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(width: wp(5)),
                        Text(
                          Tkey.cAMERA.tr,
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: hp(2)),
              InkWell(
                onTap: onTapGallery,
                child: Container(
                  decoration: BoxDecoration(
                    color: COLOR_PRIMARY,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(
                            Icons.browse_gallery_outlined,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          )),
                      SizedBox(width: wp(5)),
                      Text(Tkey.gALLERY.tr,
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor))
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
