import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/provider/cart_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/utill/app_constants.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/view/screens/menu/menu_screen.dart';
import 'package:flutter_grocery/view/screens/onboarding/on_boarding_screen.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  @override
  void initState() {
    super.initState();

    final newVersion = NewVersion(
      iOSId: 'org.nativescript.TheFreshMart',
      androidId: 'org.nativescript.TheFreshMart',
    );

    advancedStatusCheck(newVersion);

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        print('-----------------${isNotConnected ? 'Not' : 'Yes'}');
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Provider.of<SplashProvider>(context, listen: false).initSharedData();
    Provider.of<CartProvider>(context, listen: false).getCartData();
    _route();
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      if (isSuccess) {
        if (Provider
            .of<SplashProvider>(context, listen: false)
            .configModel!
            .maintenanceMode!) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteHelper.getMaintenanceRoute(), (route) => false);
        } else {
          Timer(Duration(seconds: 1), () async {
            double _minimumVersion = 0.0;
            if (Platform.isAndroid) {
              _minimumVersion = Provider
                  .of<SplashProvider>(context, listen: false)
                  .configModel!
                  .playStoreConfig!
                  .minVersion ?? 6.0;
            } else if (Platform.isIOS) {
              _minimumVersion = Provider
                  .of<SplashProvider>(context, listen: false)
                  .configModel!
                  .appStoreConfig!
                  .minVersion ?? 6.0;
            }
            if (AppConstants.APP_VERSION < _minimumVersion &&
                !ResponsiveHelper.isWeb()) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteHelper.getUpdateRoute(), (route) => false);
            }
            else {
              if (Provider.of<AuthProvider>(context, listen: false)
                  .isLoggedIn()) {
                Provider.of<AuthProvider>(context, listen: false).updateToken();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteHelper.menu, (route) => false,
                    arguments: MenuScreen());
              } else {
                print('===intro=>${Provider.of<SplashProvider>(
                    context, listen: false).showIntro()}');
                if (Provider.of<SplashProvider>(context, listen: false)
                        .showIntro()) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteHelper.onBoarding, (route) => false,
                      arguments: OnBoardingScreen());
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteHelper.menu, (route) => false,
                      arguments: MenuScreen());
                }
                // Navigator.pushNamedAndRemoveUntil(context, RouteHelper.onBoarding, (route) => false, arguments: OnBoardingScreen());
              }
            }
          });
        }
      }
    });
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        dialogTitle: 'Update Available',
        dialogText: 'Custom Text',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(Images.app_logo, height: 130),
          // SizedBox(height: 30),
          // Text(AppConstants.APP_NAME,
          //     textAlign: TextAlign.center,
          //     style: poppinsMedium.copyWith(
          //       color: Theme.of(context).primaryColor,
          //       fontSize: 50,
          //     )),
        ],
      ),
    );
  }
}
