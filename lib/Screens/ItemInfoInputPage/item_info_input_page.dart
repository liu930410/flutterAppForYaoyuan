import 'package:app/Screens/UserInfoInputPage/user_Info_input_page.dart';
import 'package:app/Screens/components/show_alert_dialog.dart';
import 'package:app/config/config.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ItemInfoInputPage extends StatefulWidget {
  @override
  _ItemInfoInputPageState createState() => _ItemInfoInputPageState();
}

class _ItemInfoInputPageState extends State<ItemInfoInputPage> {
  GlobalKey formKey = new GlobalKey<FormState>();
  List<String> itemsName = ["输液泵", "注射泵"];
  List<String> itemsQualified = ["符合要求", "不符合要求"];
  List<String> usedProducts = ["洁瑞/50mL", "洪达/50mL", "苏云/50mL"];

  String itemName; //仪器名称
  String specification; //产品规格
  String manufacturer; //制造单位
  String factoryNumber; //出厂编号
  String itemQualified = "符合要求";
  String usedProduct; 

  @override
  Widget build(BuildContext context) {
    dynamic jsonFromPage2 = ModalRoute.of(context).settings.arguments;
    // String jsonString = jsonEncode(json);
    // print(json.decode(jsonString)['uniCode']);
    String uniCode = jsonFromPage2['uniCode'];
    String apartment = jsonFromPage2['apartment'];
    String location = jsonFromPage2['location'];

    return Scaffold(
      appBar: AppBar(
        title: Text("仪器信息录入"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    children: [
                      Container(
                        height: 64,
                        child: Text(
                          "仪器名称",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 64,
                        child: DropdownButtonFormField(
                          hint: Text("请选择"),
                          value: itemName,
                          items: itemsName.map((i) {
                            return new DropdownMenuItem(
                              child: Text(i.toString()),
                              value: i,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              itemName = value;
                            });
                          },
                          validator: (String value) {
                            return value != null ? null : "不能为空";
                          },
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
                          "型号规格",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                          autofocus: false,
                          // controller: locationController,
                          decoration: InputDecoration(
                            hintText: "输入型号规格",
                          ),
                          onSaved: (value) {
                            specification = value;
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
                          "制造单位",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                          autofocus: false,
                          // controller: locationController,
                          decoration: InputDecoration(
                            hintText: "输入制造单位",
                          ),
                          onSaved: (value) {
                            manufacturer = value;
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
                          "出厂编号",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                          autofocus: false,
                          // controller: locationController,
                          decoration: InputDecoration(
                            hintText: "输入出厂编号",
                          ),
                          onSaved: (value) {
                            factoryNumber = value;
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
                          "外观及功能性检查",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 64,
                        child: DropdownButton(
                          value: itemQualified,
                          items: itemsQualified.map((i) {
                            return new DropdownMenuItem(
                              child: Text(i.toString()),
                              value: i,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              itemQualified = value;
                            });
                          },
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
                          "本次校准所用输注管路",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 64,
                        child: DropdownButtonFormField(
                          hint: Text("请选择"),
                          value: usedProduct,
                          items: usedProducts.map((i) {
                            return new DropdownMenuItem(
                              child: Text(i.toString()),
                              value: i,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              usedProduct = value;
                            });
                          },
                          validator: (String value) {
                            return value != null ? null : "不能为空";
                          },
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ],
              ),
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    children: [
                      Container(
                        height: 64,
                        child: Text(
                          "流量",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(),
                      ),
                      child: Text(
                        "设定值",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(),
                      ),
                      child: Text(
                        "实际值",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              FlowTableWidget(),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          child: Text("增加流量行"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              FlowTableWidget.addRow();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          child: Text("减少流量行"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              FlowTableWidget.subRow();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          child: Text("提交"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if ((formKey.currentState as FormState)
                                .validate()) {
                              //验证通过提交数据
                              //
                              (formKey.currentState as FormState).save();
                              dynamic jsonObj = {
                                "uniCode": uniCode,
                                "apartment": apartment,
                                "location": location,
                                "itemName": itemName,
                                "specification": specification,
                                "manufacturer": manufacturer,
                                "factoryNumber": factoryNumber,
                                "itemQualified": itemQualified,
                                "usedProduct": usedProduct,
                              };

                              String jsonString = json.encode(jsonObj);

                              String jsonStringFlow = "";
                              for (int i = 0;
                                  i <
                                      _FlowTableWidgetState
                                          .textEditingControllerList.length;
                                  i++) {
                                String flow = _FlowTableWidgetState
                                    .textEditingControllerList[i].text;
                                jsonStringFlow += ',"flow$i":"$flow"';
                              }
                              jsonStringFlow += "}";

                              jsonString =
                                  jsonString.replaceFirst("}", jsonStringFlow);
                              dynamic jsonValue = json.decode(jsonString);

                              print(jsonValue);
                              postRequestFunction(jsonValue, context);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void postRequestFunction(Map<String, dynamic> map, BuildContext context) async {
  try {
    Response response = await MyApp.dio.post(postUrl,
        data: map, options: Options(contentType: "application/json"));

    bool data = response.data;
    if (data == true) {
      await showAlertDialog(context, "上传成功", router: UserInfoInputPage());
    } else {
      showAlertDialog(context, "上传失败");
    }
  } catch (e) {
    throw showAlertDialog(context, "网络异常");
  }
}

class FlowTableWidget extends StatefulWidget {
  static addRow() {
    _FlowTableWidgetState.addRow();
  }

  static subRow() {
    _FlowTableWidgetState.subRow();
  }

  @override
  _FlowTableWidgetState createState() => _FlowTableWidgetState();
}

class _FlowTableWidgetState extends State<FlowTableWidget> {
  static int i = 0;
  static List<TextEditingController> textEditingControllerList = [];

  static List<TableRow> list = [];
  static TableRow getTableRow(int i) {
    return new TableRow(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      children: [
        TableCell(
          child: TextFormField(
              autofocus: false,
              // controller: locationController,
              decoration: InputDecoration(
                hintText: "输入设定值",
              ),
              controller: textEditingControllerList[0 + i],
              //校验
              validator: (v) {
                if (v.trim().length <= 0) {
                  return "不能为空";
                } else if (!RegExp(r'^[1-9]\d*$').hasMatch(v)) {
                  return "请输入正整数";
                }
                return null;
              }),
        ),
        TextFormField(
            autofocus: false,
            // controller: locationController,
            decoration: InputDecoration(
              hintText: "输入实际值",
            ),
            controller: textEditingControllerList[1 + i],
            //校验
            validator: (v) {
              if (v.trim().length <= 0) {
                return "不能为空";
              } else if (!RegExp(r'^[0-9]+(.[0-9]{2})?$').hasMatch(v)) {
                return "请输入两位小数";
              }
              return null;
            }),
        TextFormField(
            autofocus: false,
            // controller: locationController,
            decoration: InputDecoration(
              hintText: "输入实际值",
            ),
            controller: textEditingControllerList[2 + i],
            //校验
            validator: (v) {
              if (v.trim().length <= 0) {
                return "不能为空";
              } else if (!RegExp(r'^[0-9]+(.[0-9]{2})?$').hasMatch(v)) {
                return "请输入两位小数";
              }
              return null;
            }),
        TextFormField(
            autofocus: false,
            // controller: locationController,
            decoration: InputDecoration(
              hintText: "输入实际值",
            ),
            controller: textEditingControllerList[3 + i],
            //校验
            validator: (v) {
              if (v.trim().length <= 0) {
                return "不能为空";
              } else if (!RegExp(r'^[0-9]+(.[0-9]{2})?$').hasMatch(v)) {
                return "请输入两位小数";
              }
              return null;
            }),
      ],
    );
  }

  static addRow() {
    i += 4;
    textEditingControllerList.add(new TextEditingController());
    textEditingControllerList.add(new TextEditingController());
    textEditingControllerList.add(new TextEditingController());
    textEditingControllerList.add(new TextEditingController());
    list.add(getTableRow(i));
  }

  static subRow() {
    if (list.length <= 1) {
      return;
    }
    i -= 4;
    list.removeLast();
    textEditingControllerList.removeLast();
    textEditingControllerList.removeLast();
    textEditingControllerList.removeLast();
    textEditingControllerList.removeLast();
  }

  @override
  void initState() {
    super.initState();
    list.clear();
    textEditingControllerList.clear();
    if (list.length == 0) {
      textEditingControllerList.add(new TextEditingController());
      textEditingControllerList.add(new TextEditingController());
      textEditingControllerList.add(new TextEditingController());
      textEditingControllerList.add(new TextEditingController());
      list.add(getTableRow(0));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: list,
    );
  }
}
