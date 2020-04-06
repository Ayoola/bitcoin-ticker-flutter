import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = currenciesList[0];
  int btcRate;

  //Creates a list of Text widgets from a List of String items
  List<Text> getPickerItems(List<String> items) {
    List<Text> pickerItems = [];
    for (String item in items) {
      pickerItems.add(Text(item, style: TextStyle(color: Colors.white)));
    }
    return pickerItems;
  }

  void getExchangeRate(c) async {
    dynamic coinData = await CoinData().getCoinData(c);
    if (coinData != null) {
      double rate = coinData['rate'];
      updateUIRate(rate);
    } else {
      print("Rate Limit Exceeded 😬");
    }
  }

  void updateUIRate(rate) {
    setState(() {
      btcRate = rate.round();
    });
  }

  @override
  void initState() {
    super.initState();
    getExchangeRate(currency);
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
                  '1 BTC = $btcRate $currency',
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
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (int selectedIndex) {
                getExchangeRate(currenciesList[selectedIndex]);
                setState(() {
                  currency = currenciesList[selectedIndex];
                });
              },
              children: getPickerItems(currenciesList),
            ),
          ),
        ],
      ),
    );
  }
}
