import 'package:flutter/material.dart';

import 'components/login_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("标题保留"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            children: [
              Text(
                "陕西省计量科学研究院",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/poster_1.jpg",
                height: 200,
                width: 400,
              ),
              new Container(
                child: LoginForm(
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
