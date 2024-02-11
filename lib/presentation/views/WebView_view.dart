// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// Project imports:
import 'package:maskany_app/data/data_sources/local/shared_pref.dart';

import '../view_model/CUBIT/cubit/app_cubit.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key, required this.url, required this.packageID})
      : super(key: key);
  final String url;
  final int packageID;
  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  double _progress = 0;
  String lastUrl = "";
  String id = "";
  // String buttonText='';
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onLoadStop: (controller, url) async {
                inAppWebViewController = controller;
                lastUrl = url.toString();
                final Uri url2 = Uri.parse(lastUrl);

                //! Extracted Full URL
                BlocProvider.of<AppCubit>(context).TrxURL = lastUrl;
                CacheHelper.saveData(
                    key: 'trxURL',
                    value: BlocProvider.of<AppCubit>(context).TrxURL);

                //! Extract success value
                BlocProvider.of<AppCubit>(context).isTrxConfirmed =
                    url2.queryParameters['success'];
                CacheHelper.saveData(
                    key: 'trxBool',
                    value: BlocProvider.of<AppCubit>(context).isTrxConfirmed);

                //! Extracted Just ID from url
                BlocProvider.of<AppCubit>(context).TrxidFromURL =
                    url2.queryParameters['id'];
                CacheHelper.saveData(
                    key: 'trxID',
                    value: BlocProvider.of<AppCubit>(context).TrxidFromURL);
                print(
                    "Extracted Success Value: ${BlocProvider.of<AppCubit>(context).isTrxConfirmed}");
                print(
                    "Extracted ID: ${BlocProvider.of<AppCubit>(context).TrxidFromURL}");

                if (CacheHelper.getData(key: 'trxBool') == 'true') {
                  // CacheHelper.saveData(key: 'newbuttontitle', value: 'تأكيد الاشتراك');

                  BlocProvider.of<AppCubit>(context).confirmTransaction(
                      context: context,
                      packageID: widget.packageID,
                      transactionID:
                          CacheHelper.getData(key: 'trxID').toString(),
                      subscriptionID: 0);
                  // BlocProvider.of<AppCubit>(context).packages=[];
                  Future.delayed(Duration(seconds: 3));
                  Navigator.pop(context);
                  // print('refreshed');
                }
              },
            ),
            _progress < 1
                ? LinearProgressIndicator(
                    value: _progress,
                  )
                : const SizedBox(),
            // if(CacheHelper.getData(key: 'trxBool') == 'true')
            // Align(
            //     alignment: Alignment(0,.5),
            //     child: IconButton(
            //       onPressed: () {
            //         // inAppWebViewController.getUrl();
            //         inAppWebViewController.closeAllMediaPresentations();
            //       },
            //       icon: Icon(
            //         Icons.arrow_forward_ios,size: 30.r,
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
