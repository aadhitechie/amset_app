
import 'package:amster_app/routes.dart';
import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobTileWidget extends StatelessWidget {
  const JobTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Get.toNamed(Routes.jobDetail),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10.r))
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  AvatarWidget(
                      imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiXN9xSEe8unzPBEQOeAKXd9Q55efGHGB9BA&s',
                      size: 50.w),
                      const hSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Text('Graphic designer',style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text('Amset acdemy LLP',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10.sp),
                        ),
                        const vSpace(5),
                        Row(children: [
                          Icon(Icons.work,size: 10.w,),
                          const hSpace(2),
                          Text('5 Years',style: TextStyle(fontSize: 10.sp),)
                        ],)
                      ],)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
