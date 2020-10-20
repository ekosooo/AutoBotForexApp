import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/tools_detail_model.dart';
import '../func_global.dart';

// ignore: must_be_immutable
class FormSubscribeEAPage extends StatefulWidget {
  String toolsID;
  String toolsName;
  String toolsRate;
  String toolsUrlImg;
  List<Product> productList;

  FormSubscribeEAPage({
    Key key,
    this.toolsID,
    this.toolsName,
    this.toolsRate,
    this.toolsUrlImg,
    this.productList,
  });

  @override
  FormSubscribeEAPageState createState() => FormSubscribeEAPageState();
}

class FormSubscribeEAPageState extends State<FormSubscribeEAPage> {
  //-- dropdown --
  var period;
  var priceProduct;
  var affiliate;
  @override
  void initState() {
    super.initState();
    period = widget.productList[0].period;
    priceProduct = widget.productList[0].price;
    affiliate = widget.productList[0].aff;
  }

  //--- function post data ---
  bool isLoading = false;
  Future postSubscribe(
    String toolid,
    String name,
    String email,
    String mobile,
    String period,
    String aff,
  ) async {
    final String baseUrl = kBaseUrlApi + 'tools/EA/trans';
    final response = await http.post(
      '$baseUrl',
      body: {
        'toolid': toolid,
        'name': name,
        'email': email,
        'mobile': mobile,
        'period': period,
        'aff': aff,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> map = json.decode(response.body);
      String status = map['status'];
      if (status == 'success') {
        return FunctionGlobal().showSuccessDialog(
            context, 'Please check your email for more information..');
      } else {
        return FunctionGlobal()
            .showErrorDialog(context, 'Sorry, something wrong..');
      }
    } else {
      throw Exception('Fail load data');
    }
  }

  //--- form key --
  final formKey = GlobalKey<FormState>();

  //--- controller text field ---
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noHpController = TextEditingController();

  //--- font and padding style form ---
  var textStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 28.ssp,
    color: kTextColor,
  );
  var paddingTextField = EdgeInsets.symmetric(
    vertical: 15.w,
    horizontal: 15.w,
  );
  var textStyleHint = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 28.ssp,
    color: kTextLightColor,
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //---- product ----
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.w),
                        Text(
                          'Product',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 30.ssp,
                            color: kTextLightColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
                          height: 215.w,
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: double.infinity,
                                  height: 160.w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.w, horizontal: 30.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              //-- Title EA --
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'EA ' + widget.toolsName,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nunito-ExtraBold",
                                                      fontSize: 35.ssp,
                                                      color: kTextColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$' + priceProduct,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nunito-ExtraBold",
                                                      fontSize: 35.ssp,
                                                      color: kTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              //-- desc ea --
                                              SizedBox(height: 10.w),

                                              //--- rating ea ---
                                              SizedBox(height: 5.w),
                                              Row(
                                                children: <Widget>[
                                                  RatingBar(
                                                    itemSize: 25.w,
                                                    onRatingUpdate: null,
                                                    initialRating: double.parse(
                                                        widget.toolsRate),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    widget.toolsRate,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nunito-ExtraBold",
                                                      fontSize: 22.ssp,
                                                      color: kTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //-- img product --
                              Positioned(
                                top: 0,
                                left: 20.w,
                                child: Container(
                                  height: 190.w,
                                  width: 135.w,
                                  child: Image.network(
                                    widget.toolsUrlImg,
                                    fit: BoxFit.fill,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(8.w, 21.w),
                                        blurRadius: 25.w,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 2.w,
                    width: double.infinity,
                    color: Colors.grey[50],
                  ),

                  //----- personal data --------
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20.w),
                        Text(
                          'Personal Data',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 30.ssp,
                            color: kTextLightColor,
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //-- Name --
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                cursorColor: kTextColor,
                                validator: (value) =>
                                    value.isEmpty ? 'Name cant empty' : null,
                                decoration: InputDecoration(
                                  fillColor: kBgInputText,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: textStyleHint,
                                  contentPadding: paddingTextField,
                                ),
                              ),
                              SizedBox(height: 20.w),

                              //-- Email --
                              TextFormField(
                                controller: emailController,
                                validator: (String value) =>
                                    value.isEmpty ? 'Email cant empty' : null,
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                cursorColor: kTextColor,
                                decoration: InputDecoration(
                                  fillColor: kBgInputText,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: textStyleHint,
                                  contentPadding: paddingTextField,
                                ),
                              ),

                              SizedBox(height: 20.w),

                              //-- Handphone --
                              TextFormField(
                                controller: noHpController,
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                cursorColor: kTextColor,
                                decoration: InputDecoration(
                                  fillColor: kBgInputText,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Mobile Phone',
                                  hintStyle: textStyleHint,
                                  contentPadding: paddingTextField,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ---- price ----
                  SizedBox(height: 30.w),
                  Container(
                    height: 2.w,
                    width: double.infinity,
                    color: Colors.grey[50],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20.w),
                        Text(
                          'Price',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 30.ssp,
                            color: kTextLightColor,
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: DropdownButton(
                            iconSize: 50.w,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: period,
                            items: widget.productList.map((data) {
                              return DropdownMenuItem(
                                child: Text(
                                  data.desc,
                                  style: textStyle,
                                ),
                                value: data.period,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  period = value;
                                  priceProduct =
                                      valPrice(widget.productList, value);
                                  affiliate =
                                      valAffiliate(widget.productList, value);
                                },
                              );
                            },
                          ),
                          decoration: BoxDecoration(
                            color: kBgInputText,
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //---- Button ----
                  SizedBox(height: 100.w),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35.w),
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(18.w),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 21.w),
                          blurRadius: 35.w,
                          color: kPrimaryColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.black.withOpacity(0.1),
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            postSubscribe(
                              widget.toolsID,
                              nameController.text,
                              emailController.text,
                              noHpController.text,
                              period,
                              affiliate,
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            'Yes, subscribe',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 30.ssp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60.w),
                ],
              ),
            ),
    );
  }

  //------- line function --------------
  //------------------------------------

  //----- app bar --------
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Checkout',
        style: TextStyle(
          fontFamily: 'Nunito-ExtraBold',
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
      centerTitle: true,
    );
  }

  //-- function untuk mendapatkan nilai affliate dari data price product yang dipilih ---
  valAffiliate(List<Product> product, value) {
    for (var i = 0; i < product.length; i++) {
      if (product[i].period == value) {
        return product[i].aff;
      }
    }
  }

  valPrice(List<Product> product, value) {
    for (var i = 0; i < product.length; i++) {
      if (product[i].period == value) {
        return product[i].price;
      }
    }
  }
}
