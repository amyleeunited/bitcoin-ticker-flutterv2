import 'package:bitcoin_ticker/cryptocurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
//import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  var bitCoinValue;
  var ethereumValue;
  var liteCoinValue;
  CoinData myCoinData = CoinData();
//  CryptoCurrency myCryptoCurrency = CryptoCurrency();

  DropdownButton getAndroidPicker(){
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker(){
    List<Text> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency,
        style: TextStyle(
          color: Colors.white,
        ),
      );
      dropDownItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
      setState(() {
        selectedCurrency = currenciesList[selectedIndex];
        updateUI();
      });
      },
      children: dropDownItems,
      );
  }

  void updateUI() async {
    try {
      var bitCoinData = await myCoinData.getBitCoinData(selectedCurrency);
      var ethereumData = await myCoinData.getEthereumData(selectedCurrency);
      var liteCoinData = await myCoinData.getLiteCoinData(selectedCurrency);
      setState(() {
        bitCoinValue = bitCoinData['last'];
        ethereumValue = ethereumData['last'];
        liteCoinValue = liteCoinData['last'];
      });
      } catch (e) {
        print(e);
      }
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCurrency(
              cryptoCurrencyValue: bitCoinValue,
              selectedCurrency: selectedCurrency,
              cryptoType: 'BTC',
          ),
          CryptoCurrency(
            cryptoCurrencyValue: ethereumValue,
            selectedCurrency: selectedCurrency,
            cryptoType: 'ETH',
          ),
          CryptoCurrency(
            cryptoCurrencyValue: liteCoinValue,
            selectedCurrency: selectedCurrency,
            cryptoType: 'LTC',
          ),
          SizedBox(height: 216.0),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
//            child: Platform.isIOS ? getIOSPicker() : getAndroidPicker(),
            child: getIOSPicker(),
          ),
        ],
      ),
    );
  }
}



