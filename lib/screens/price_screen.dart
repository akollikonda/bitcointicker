import 'dart:io';

import 'package:bitcointicker/coin_data.dart';
import 'package:bitcointicker/services/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  Future<dynamic> getExchnageRate(String coin, String currency) async {
    CoinModel model = CoinModel();
    var coinData = await model.getCoinData(coin, currency);
    return coinData['rate'];
  }

  Widget iosPicker() {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32,
      scrollController: FixedExtentScrollController(initialItem: 0),
      onSelectedItemChanged: (int selectedItem) {
        print(selectedItem);
        setState(() {
          selectedCurrency = currenciesList[selectedItem];
        });
      },
      children: gerDropDownCupertionItems(),
    );
  }

  Widget adroidPicker() {
    return DropdownButton(
      value: selectedCurrency,
      items: getDropDownItems(),
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value!;
        });
      },
    );
  }

  Widget dropDownSelector() {
    if (Platform.isIOS) {
      return iosPicker();
    } else {
      return adroidPicker();
    }
  }

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem> ddmil = [];
    for (String currency in currenciesList) {
      ddmil.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return ddmil;
  }

  List<Text> gerDropDownCupertionItems() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: dropDownSelector(),
          ),
        ],
      ),
    );
  }
}
