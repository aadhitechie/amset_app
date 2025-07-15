import 'dart:developer';
import 'dart:io';

import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {super.key,
      required this.imageUrl,
      required this.size,
      this.borderColor,
      this.borderSize,
      this.space,
      this.isFile = false,
      this.onEdit,
      this.editButtonSvg,
      this.isUpdating = false});
  final String? imageUrl;
  final double size;
  final Color? borderColor;
  final double? borderSize;
  final double? space;
  final bool isFile;
  final bool isUpdating;
  final VoidCallback? onEdit;
  final String? editButtonSvg;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.all(space ?? 0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: borderColor ?? kWhite, width: borderSize ?? 1),
                  borderRadius: BorderRadius.circular(size / 2)),
              child: ClipOval(
                child: imageUrl == null || imageUrl!.isEmpty
                    ? Image.asset(
                        'assets/png/person_default.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : isFile
                        ? Image.file(
                            File(imageUrl!),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            fadeInDuration: const Duration(milliseconds: 100),
                            placeholder: (_, __) => Image.asset(
                              'assets/png/person_default.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
              ),
            ),
            if (isUpdating) loadingWidget(),
            if (onEdit != null) editButton()
          ],
        ),
      ),
    );
  }

  Positioned editButton() {
    var buttonSize = size * 0.27;
    log(buttonSize.toString());

    return Positioned(
        right: 0,
        bottom: 0,
        child:
            //  Container(
            //   width: buttonSize,
            //   height: buttonSize,
            //   padding: const EdgeInsets.all(2),
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: grey,
            //   ),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(color: themeColor, width: 1)),
            //     child: Center(
            //       child: Icon(
            //         Icons.camera_alt_outlined,
            //         size: buttonSize * 2 / 3 - 2,
            //       ),
            //     ),
            //   ),
            // ),
            SvgIcon(
          editButtonSvg ?? 'assets/svg/camera_icon.svg',
          size: buttonSize,
        ));
  }
}
