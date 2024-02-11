// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/packages_view.dart';
import '../../core/app_resources/images.dart';
import '../../core/common_widgets/custom_buttom.dart';
import '../../data/data_sources/local/shared_pref.dart';

class PurchasePackageCheckView extends StatefulWidget {
  final int packageID;
  const PurchasePackageCheckView({super.key, required this.packageID});

  @override
  State<PurchasePackageCheckView> createState() =>
      _PurchasePackageCheckViewState();
}

class _PurchasePackageCheckViewState extends State<PurchasePackageCheckView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
         if (state is UserAlreadySubscribedInAPackageState) {
            Flushbar(
              message: 'أنت مشترك في باقة اخري',
              duration: Duration(seconds: 4),
              backgroundColor: Colors.red,
            )..show(context);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CacheHelper.getData(key: 'trxBool') != 'true'
                  ? Center(
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 10,
                        margin: EdgeInsets.symmetric(horizontal: 15.w
                        ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 40.h),
                        child: Column(
                          children: [
                            Text('هل تريد الاستمرار في الاشتراك في هذه الباقة ؟'),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () => cubit.getPackagePaymentURL(
                                        packageID: widget.packageID,
                                        context: context),
                                    child: Text(
                                      'نعم',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                InkWell(
                                    onTap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PackagesView(),
                                        )),
                                    child: Text(
                                      'لا',
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                  : Center(
                      child: Container(
                      // alignment: Alignment.center,
                      height: 400.h,
                      // width: 400.w,
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(Images.successLogo),
                          ),
                          Text(
                            'تم الاشتراك في الباقة بنجاح',
                            style: Theme.of(context).textTheme.displayLarge,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            'أنت الان مشترك في هذه الباقة',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          const Spacer(),
                          CustomButton(
                              text: 'رجوع',
                              onpressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PackagesView(),
                                    ));
                              })
                        ],
                      ),
                    ))
            ],
          );
        },
      ),
    );
  }
}
