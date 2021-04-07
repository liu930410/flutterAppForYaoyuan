import 'dart:ffi';

import 'package:app/Screens/ItemInfoInputPage/item_info_input_page.dart';
import 'package:app/config/config.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String> getRequestFunction() async {
  Response response = await MyApp.dio
      .get(getUniIDUrl, options: Options(responseType: ResponseType.plain));
  return response.data;
}

class UserInfoInputPage extends StatefulWidget {
  @override
  _UserInfoInputPageState createState() => _UserInfoInputPageState();
}

class _UserInfoInputPageState extends State<UserInfoInputPage> {
  String uniCode = "B20210001";

  List<String> locations = ["委托单位临床科室", "医用电生理实验室422"];
  String location = "委托单位临床科室";
  String apartment;
  TextEditingController apartmentController = new TextEditingController();

  GlobalKey formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("客户信息录入"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getRequestFunction(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            uniCode = snapshot.data;
          }

          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: [
                            Container(
                              height: 64,
                              child: Text(
                                "唯一识别号",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                            Container(
                              height: 64,
                              child: Text(
                                uniCode,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: [
                            Container(
                              height: 64,
                              child: Text(
                                "委托单位",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                            TextFormField(
                                autofocus: false,
                                controller: apartmentController,
                                decoration: InputDecoration(
                                  hintText: "输入单位信息",
                                ),
                                onSaved: (v) {
                                  apartment = v;
                                },
                                //校验
                                validator: (v) {
                                  return v.trim().length > 0 ? null : "不能为空";
                                }),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          children: [
                            Container(
                              height: 64,
                              child: Text(
                                "校准地点",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                            Container(
                              height: 64,
                              child: DropdownButton(
                                value: location,
                                items: locations.map((i) {
                                  return new DropdownMenuItem(
                                    child: Text(i.toString()),
                                    value: i,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    location = value;
                                  });
                                },
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("下一步"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if ((formKey.currentState as FormState)
                                  .validate()) {
                                //验证通过提交数据
                                (formKey.currentState as FormState).save();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemInfoInputPage(),
                                    settings: RouteSettings(
                                      arguments: {
                                        "uniCode": uniCode,
                                        "apartment": apartment,
                                        "location": location
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
