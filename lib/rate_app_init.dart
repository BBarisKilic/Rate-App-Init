// Copyright 2022 The RateAppInit Author. All rights reserved.
// Use of this source code is governed by a MIT-style license that
// can be found in the LICENSE file.

library rate_app_init;

import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInit extends StatefulWidget {
  const RateAppInit({
    Key? key,
    required this.builder,
    this.onLoading,
    this.appStoreId,
    this.googlePlayId,
    this.minDays,
    this.remindDays,
    this.minLaunches,
    this.remindLaunches,
  }) : super(key: key);

  final Widget Function(RateMyApp) builder;
  final Widget? onLoading;
  final String? appStoreId;
  final String? googlePlayId;
  final int? minDays;
  final int? remindDays;
  final int? minLaunches;
  final int? remindLaunches;

  @override
  State<RateAppInit> createState() => _RateAppInitState();
}

class _RateAppInitState extends State<RateAppInit> {
  RateMyApp? _rateMyApp;

  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        appStoreIdentifier: widget.appStoreId,
        googlePlayIdentifier: widget.googlePlayId,
        minDays: widget.minDays,
        minLaunches: widget.minLaunches,
        remindDays: widget.remindDays,
        remindLaunches: widget.remindLaunches,
      ),
      onInitialized: (_, rateMyApp) async {
        setState(() => _rateMyApp = rateMyApp);

        if (rateMyApp.shouldOpenDialog) {
          await rateMyApp.showStarRateDialog(context);
        }
      },
      builder: (context) {
        return _rateMyApp == null
            ? widget.onLoading ??
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
            : widget.builder(_rateMyApp!);
      },
    );
  }
}
