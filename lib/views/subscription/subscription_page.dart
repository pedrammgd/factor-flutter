import 'package:factor_flutter_mobile/models/factor_product_model/factor_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poolakey/flutter_poolakey.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SubscriptionPage> createState() => _SubScriptionPageState();
}

class _SubScriptionPageState extends State<SubscriptionPage> {
  var _gasLevels = ["0", "1", "2", "3", "4", "_inf"];
  var _gasLevel = 4;
  var _vehicleState = "free";
  Map<String, ProductItem> _productsMap = {};

  String _logText = "";

  @override
  void initState() {
    _initShop();
    super.initState();
  }

  Future<void> _initShop() async {
    _productsMap["gas"] = ProductItem("buy_gas", true);
    _productsMap["premium"] = ProductItem("upgrade_app", false);
    _productsMap["infinite_gas_monthlyi"] =
        ProductItem("get_infinite_gas", false);

    var message = "";
    var rsaKey =
        "MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwC3GmsXxlUYD9F//22IBEBUBBZ2I4BsDzxjfMc/6eGS7iYt4jhExxoiX3dBsrPrr0MXoZ3ZYZW4KzxiFgXix1CVYEDu6OUXTOuzDz8hFvZYBykfg39EH4g5zrBi6weUA0do0A6IYpD7RwNOaHFqX2G+zpjzTHYUKjLcIr+bohSdiCpK6saqfbgAbheWXHkujyDktd3+aCo6ylvlxO8HpAjfTEMPS39adCnM9Uw5FCcCAwEAAQ==";
    bool connected = false;
    try {
      connected = await FlutterPoolakey.connect(rsaKey,
          onDisconnected: () => message = "Poolakey disconnected!");
    } on Exception catch (e) {
      setState(() {
        message = e.toString();
      });
    }
    if (!connected) {
      _log(message);
      return;
    }
    _reteriveProducts();
  }

  Future<void> _reteriveProducts() async {
    var purchases = await FlutterPoolakey.getAllPurchasedProducts();
    var subscribes = await FlutterPoolakey.getAllSubscribedProducts();
    var allPurchases = <PurchaseInfo>[];
    allPurchases.addAll(purchases);
    allPurchases.addAll(subscribes);
    for (var purchase in allPurchases) {
      _handlePurchase(purchase);
    }

    var skuDetailsList =
        await FlutterPoolakey.getInAppSkuDetails(_productsMap.keys.toList());

    for (var skuDetails in skuDetailsList) {
      _productsMap[skuDetails.sku]?.skuDetails = skuDetails;

      // inject purchaseInfo
      PurchaseInfo? purchaseInfo;
      for (var p in allPurchases) {
        if (p.productId == skuDetails.sku) purchaseInfo = p;
      }
      _productsMap[skuDetails.sku]?.purchaseInfo = purchaseInfo;
    }
    setState(() {});
  }

  Future<void> _handlePurchase(PurchaseInfo purchase) async {
    _log(purchase.originalJson);
    if (purchase.productId == "gas") {
      if (_gasLevel < 5) _gasLevel = (_gasLevel + 1).clamp(0, 4);
    } else if (purchase.productId == "infinite_gas_monthlyi") {
      _gasLevel = 5;
    } else if (purchase.productId == "premium") {
      _vehicleState = "premium";
    }

    if (_productsMap[purchase.productId]!.consumable) {
      var result = await FlutterPoolakey.consume(purchase.purchaseToken);
      if (!result) {
        _log("object");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final size = MediaQuery.of(context).size;
    final items = _productsMap.values.toList();
    final itemHeight = 100.0;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SubscriptionPage object that was created by
        // the App.build methodx, and use it to set our appbar title.
        title: Text('widget'),
      ),
      body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.green.withAlpha(44),
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/$_vehicleState.png", width: 110),
                          SizedBox(
                            height: 8,
                          ),
                          Image.asset("assets/gas${_gasLevels[_gasLevel]}.png",
                              width: 110)
                        ],
                      ),
                      SizedBox(
                        width: 128,
                        height: 56,
                        child: ElevatedButton(
                          child: Text("یه دوری بزن"),
                          onPressed: _drive,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 6),
              SizedBox(
                  height: items.length * itemHeight,
                  child: ListView.builder(
                      itemExtent: itemHeight,
                      itemBuilder: (c, i) => _itemBuilder(items[i]),
                      itemCount: items.length)),
              SizedBox(height: 6),
              Expanded(
                  child: Stack(
                children: [
                  SingleChildScrollView(
//scrollable Text - > wrap in SingleChildScrollView -> wrap that in Expanded
                    child: Text(
                      _logText,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 4,
                    width: 36,
                    child: ElevatedButton(
                      onPressed: _clearLog,
                      child: Icon(Icons.delete),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }

  void _drive() {
    if (_gasLevel >= 5) return;
    _gasLevel = (_gasLevel - 1).clamp(0, 4);
    setState(() {});
  }

  Widget _itemBuilder(ProductItem item) {
    var title = item.skuDetails == null ? "Title" : item.skuDetails!.title;
    var description =
        item.skuDetails == null ? "Description" : item.skuDetails!.description;
    var price = item.skuDetails == null ? "Price" : item.skuDetails!.price;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Card(
            child: InkWell(
                onTap: () => _onItemTap(item),
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: IgnorePointer(
                        ignoring: true,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/${item.icon}.png",
                                  width: 100),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(title, textAlign: TextAlign.right),
                                    Text(description,
                                        textAlign: TextAlign.right),
                                    Text(price, textAlign: TextAlign.right),
                                  ]),
                            ]))))));
  }

  Future<void> _onItemTap(ProductItem item) async {
    if (item.skuDetails == null) return;
    PurchaseInfo? purchaseInfo;
    try {
      purchaseInfo = await FlutterPoolakey.purchase(item.skuDetails!.sku);
    } catch (e) {
      _log(e.toString());
      return;
    }
    _handlePurchase(purchaseInfo);
  }

  void _log(String message) {
    _logText += message + "\n";
    setState(() {});
  }

  void _clearLog() {
    _logText = "";
    setState(() {});
  }

  @override
  void dispose() {
    // FlutterPoolakey.
    super.dispose();
  }
}
