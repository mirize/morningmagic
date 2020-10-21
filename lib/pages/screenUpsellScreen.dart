import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/screenStart.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UpsellBuyScreen extends StatefulWidget {
  UpsellBuyScreen({Key key}) : super(key: key);

  @override
  _UpsellBuyScreenState createState() => _UpsellBuyScreenState();
}

class _UpsellBuyScreenState extends State<UpsellBuyScreen> {
  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  Future<void> initPlatformState() async {
    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  Widget load_buy() {
    if (_purchaserInfo == null) {
      return null;
    } else {
      var isPro =
          _purchaserInfo.entitlements.active.containsKey("all_features");
      if (isPro) {
        return IsProScreen();
      } else {
        return UpsellScreen(
          offerings: _offerings,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.TOP_GRADIENT,
            AppColors.MIDDLE_GRADIENT,
            AppColors.BOTTOM_GRADIENT
          ],
        )),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: AnimatedButton(
                  () async {
                    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
                    PurchaserInfo _purchaserInfo =
                        await Purchases.getPurchaserInfo();
                    Offerings offerings = await Purchases.getOfferings();
                    if (_purchaserInfo == null) {
                      return Text("null");
                    } else {
                      var isPro = _purchaserInfo.entitlements.active
                          .containsKey("all_features");
                      if (isPro) {
                        return IsProScreen();
                      } else {
                        if (offerings != null) {
                          final offering = offerings.current;
                          if (offering != null) {
                            final monthly = offering.monthly;
                            if (monthly != null) {
                              PurchaserInfo purchaserInfo =
                                  await Purchases.purchasePackage(monthly);
                            }
                          }
                        }
                      }
                    }
                  },
                  'rex',
                  AppLocalizations.of(context).translate("buy_days"),
                  22,
                  null,
                  null,
                ),
              ),
              Container(
                height: 100,
                child: AnimatedButton(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StartScreen()));
                }, 'rex', AppLocalizations.of(context).translate("menu"), 22,
                    null, null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpsellScreen extends StatelessWidget {
  final Offerings offerings;

  UpsellScreen({Key key, @required this.offerings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offerings != null) {
      final offering = offerings.current;
      if (offering != null) {
        final monthly = offering.monthly;
        if (monthly != null) {
          return Container(
            child: Center(
              child: PurchaseButton(package: monthly),
            ),
          );
        }
      }
    }
  }
}

class PurchaseButton extends StatelessWidget {
  final Package package;

  PurchaseButton({Key key, @required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        try {
          PurchaserInfo purchaserInfo =
              await Purchases.purchasePackage(package);
          var isPro = purchaserInfo.entitlements.all["all_features"].isActive;
          if (isPro) {
            return IsProScreen();
          }
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
            print("User cancelled");
          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
            print("User not allowed to purchase");
          }
        }
        return UpsellBuyScreen();
      },
      child: Text(AppLocalizations.of(context).translate("pay")),
    );
  }
}

class IsProScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          AppLocalizations.of(context).translate("user_is_pro"),
        ),
      ),
    );
  }
}
