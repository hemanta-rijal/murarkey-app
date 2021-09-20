import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * Created by Suman Prasad Neupane on 9/13/2021.
 * https://www.youtube.com/watch?v=qwVpNj_flo8&list=PLs9jM-gMRP6ONUuuwqJjYtMJ9t3HSLlV_&index=2
 * https://developer.esewa.com.np/#/epay
 */
class EsewaEpayPayment extends StatefulWidget {
  final double tAmt;
  final double amt;
  final double txAmt;

  final double psc;
  final double pdc;

  final String pid;

  final String su;
  final String fu;

  const EsewaEpayPayment({
    Key key,
    @required this.pid,
    @required this.tAmt,
    @required this.amt,
    @required this.txAmt,
    @required this.psc,
    @required this.pdc,
    @required this.su,
    @required this.fu,
  }) : super(key: key);

  @override
  _EsewaEpayPaymentState createState() => _EsewaEpayPaymentState();
}

class _EsewaEpayPaymentState extends State<EsewaEpayPayment> {
  WebViewController _webViewController;
  Repository _repository = new Repository();

  String _SCD_TEST = "EPAYTEST";
  String _SCD_LIVE = "";

  _loadHTMLfromAsset() async {
    String file = await rootBundle.loadString("assets/epay_request.html");
    _webViewController.loadUrl(Uri.dataFromString(file,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  // ePay deatils
  String pid = UniqueKey().toString();
  double tAmt = 1000;
  double amt = 800;
  double txAmt = 100;
  double psc = 50;
  double pdc = 50;
  String scd = "EPAYTEST";
  String su = "https://github.com/kaledai";
  String fu = "https://refactoring.guru/design-patterns/factory-method";

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    //Test environment
    pid = widget.pid;

    tAmt = widget.tAmt;
    amt = widget.amt;
    txAmt = widget.txAmt;

    psc = widget.psc;
    pdc = widget.pdc;

     scd = _SCD_TEST;

    su = widget.su;
    fu = widget.fu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       String pid = UniqueKey().toString();
      //       _webViewController.evaluateJavascript(
      //           'requestPayment(tAmt = $tAmt, amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        leading: SizedBox.shrink(),
      ),
      body: WebView(
        initialUrl: "about:blank",
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
            name: "message",
            onMessageReceived: (message) {},
          ),
        ]),
        onPageFinished: (data) {
          setState(() {
            _webViewController.evaluateJavascript(
                'requestPayment(tAmt = $tAmt, amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');

          });
        },
        onWebViewCreated: (webViewController) {
          _webViewController = webViewController;
          _loadHTMLfromAsset();
        },
      ),
    );
  }
}

//'requestPayment(tAmt = ${widget.tAmt}, amt = ${widget.amt}, txAmt = ${widget.txAmt}, psc = ${widget.psc}, pdc = ${widget.pdc}, scd = "${scd}", pid = "$pid", su = "$su", fu = "$fu")');

//'requestPayment(tAmt = ${widget.tAmt}, amt = ${widget.amt}, txAmt = ${widget.txAmt}, psc = ${widget.psc}, pdc = ${widget.pdc}, scd = "${scd}", pid = "${widget.pid}", su = "${widget.su}", fu = "${widget.fu}")');
