import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentDialog extends Dialog {
  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  Future<Widget> load_buy() async {
    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo _purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings _offerings = await Purchases.getOfferings();

    if (_purchaserInfo == null) {
      return Text("null");
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 18),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("appreciate"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'rex',
                        fontWeight: FontWeight.normal,
                        color: AppColors.VIOLET),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).translate("price"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'rex',
                            fontWeight: FontWeight.normal,
                            color: AppColors.VIOLET,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "10\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'rex',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PINK,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "1\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'rex',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.VIOLET),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: AnimatedButton(() async {
                        await Purchases.setup(
                            "joxdRNutDmmrudomDHmIbGerKngVcZlD");
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
                          AppLocalizations.of(context).translate("buy_month"),
                          18,
                          MediaQuery.of(context).size.width / 4,
                          FontWeight.bold),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: AnimatedButton(() async {
                            await Purchases.setup(
                                "joxdRNutDmmrudomDHmIbGerKngVcZlD");
                            PurchaserInfo _purchaserInfo =
                                await Purchases.getPurchaserInfo();
                            Offerings offerings =
                                await Purchases.getOfferings();
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
                                          await Purchases.purchasePackage(
                                              monthly);
                                    }
                                  }
                                }
                              }
                            }
                          },
                              'rex',
                              AppLocalizations.of(context)
                                  .translate("buy_days"),
                              18,
                              MediaQuery.of(context).size.width / 4,
                              FontWeight.bold),
                        ))
                  ],
                ),
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
