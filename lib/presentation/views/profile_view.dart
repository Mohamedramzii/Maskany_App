import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_resources/images.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الحساب',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55.r,
                backgroundImage: const AssetImage(Images.profile),
              ),
            ),
            SizedBox(height: 5.h,),
            Text('محمد أحمد',style: Theme.of(context).textTheme.displayLarge,),
            Text('mohamedahmed123@gmail.com',style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: 20.h,),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.info_outline_rounded),
              title: Text('معلومات شخصية',style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(Icons.arrow_forward_ios,size: 20.r,),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.diamond_rounded),
              title: Text('الباقات',style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(Icons.arrow_forward_ios,size: 20.r,),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.settings),
              title: Text('الاعدادات',style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(Icons.arrow_forward_ios,size: 20.r,),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.location_on),
              title: Text('القاهرة',style: Theme.of(context).textTheme.bodyMedium,),
              
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.add_card),
              title: Text('طرق الدفع',style: Theme.of(context).textTheme.bodyMedium,),
              // trailing: Row(
              //   children: [],
              // ),
              
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.logout,color: Colors.red,),
              title: Text('تسجيل الخروج',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),),
              
            ),
          ],
        ),
      ),
    );
  }
}
