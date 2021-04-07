import 'package:app/Screens/UserInfoInputPage/user_Info_input_page.dart';
import 'package:app/Screens/components/show_alert_dialog.dart';
import 'package:app/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
    @required this.context,
  }) : super(key: key);

  final TextEditingController unameController = new TextEditingController();
  final TextEditingController pwdController = new TextEditingController();
  final GlobalKey formKey = new GlobalKey<FormState>();
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Form(
      //设置globalKey，用于后面获取FormState
      key: formKey,
      //开启自动校验
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: false,
              // keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: unameController,
              decoration: InputDecoration(
                  labelText: "用户名或邮箱",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person)),
              // 校验用户名
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不能为空";
              }),
          TextFormField(
              autofocus: false,
              controller: pwdController,
              decoration: InputDecoration(
                  labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)),
              obscureText: true,
              //校验密码
              validator: (v) {
                return v.trim().length > 5 ? null : "密码不能少于6位";
              }),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("登录"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if ((formKey.currentState as FormState).validate()) {
                        //验证通过提交数据

                        Map<String, dynamic> map = Map();

                        map['userName'] = unameController.text;
                        map['password'] = pwdController.text;
                        postRequestFunction(map, context);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void postRequestFunction(Map<String, dynamic> map, BuildContext context) async {
  try {
    Response response = await MyApp.dio.post(loginUrl,
        data: map, options: Options(contentType: "application/json"));

    bool data = response.data;
    if (data == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoInputPage(),
        ),
      );
    } else {
      showAlertDialog(context, "用户名密码错误");
    }
  } catch (e) {
    throw showAlertDialog(context, "网络异常");
  }
}
