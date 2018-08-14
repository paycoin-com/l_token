import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l_token/model/assets.dart';
import 'package:l_token/model/wallet.dart';
import 'package:l_token/pages/routes/routes.dart';
import 'package:l_token/style/styles.dart';
import 'package:l_token/view/wallet_widget.dart';

class WalletPage extends StatelessWidget {
  static const String routeName = Routes.wallet + "/index";

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  final List<Assets> _assets = [];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appbar(context),
      body: new RefreshIndicator(
//          color: theme.accentColor,
          key: _refreshIndicatorKey,
          child: ListView(children: _body()),
          onRefresh: _handleRefresh),
    );
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 2), () {
      completer.complete(null);
    });
    return completer.future.then((_) {
      print('refresh complete');
      _scaffoldKey.currentState?.showSnackBar(new SnackBar(
          content: const Text('Refresh complete'),
          action: new SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }

  Widget _appbar(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double iconSize = 28.0;
    final double coinTypeSize = 12.0;
    final coinTypeWidget = new Ink(
      decoration: new BoxDecoration(
          border: new Border.all(color: Color(0xff273541)),
          borderRadius: const BorderRadius.all(const Radius.circular(12.0))),
      padding: EdgeInsets.only(left: 6.0, top: 4.0, right: 6.0, bottom: 4.0),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'ETH',
            style: new TextStyle(color: Colors.black, fontSize: coinTypeSize),
          ),
          new Icon(
            Icons.keyboard_arrow_down,
            size: coinTypeSize,
            color: Colors.black,
          )
        ],
      ),
    );
    return new AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      bottom: new PreferredSize(
          child: Divider(
            height: Dimens.line,
          ),
          preferredSize: new Size.fromHeight(Dimens.line)),
      elevation: 0.0,
      centerTitle: true,
      leading: new IconButton(
          icon: Image.asset('assets/images/ic_qrcode.png',
              width: iconSize, height: iconSize),
          onPressed: () {
            print('onpressed');
          }),
      actions: <Widget>[
        new IconButton(
          icon: Image.asset('assets/images/ic_qrcode_scan.png',
              width: iconSize, height: iconSize),
          onPressed: () {
            print('scan');
          },
        ),
      ],
      title: new InkWell(
        child: coinTypeWidget,
        borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
        onTap: () {
          print('to wallet manage');
        },
      ),
    );
  }

  List<Widget> _body(){
    List<Widget> list = List();
    HDWallet wallet = new HDWallet();
    wallet.address = "0xafb87869fd4132e8700e8678765cecd6b259cda8";
    wallet.name = "HDWallet";
    Widget currentWalletWidget = new WalletWidget(wallet);
    Widget assetsMarkWidget = Container();

    list.add(currentWalletWidget);
    list.add(assetsMarkWidget);
//    List<Widget> assetsList = _assets.map<Widget>((Assets assets){
//
//      return Container();
//    });
//    list.addAll(assetsList);
    return list;
  }

}
