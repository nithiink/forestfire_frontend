import 'package:flutter/material.dart';
import 'package:forestfire_frontend/screens/product/product.dart';
import 'package:forestfire_frontend/sizeConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FireWatch",
      theme: ThemeData(
        fontFamily: "Google Sans",
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: (17),
            fontWeight: FontWeight.w300,
          ),
          subtitle1: TextStyle(
            color: Colors.black,
            fontSize: (22),
            fontWeight: FontWeight.w500,
          ),
          subtitle2: TextStyle(
            color: Colors.black,
            fontSize: (20),
            fontWeight: FontWeight.w500,
          ),
          button: TextStyle(
            color: Colors.black,
            fontSize: (20),
            fontWeight: FontWeight.w500,
          ),
          headline1: TextStyle(
            color: Colors.black,
            fontSize: (37),
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        // primaryColor: primaryColor,
        // accentColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CustomScaffold(),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({Key? key}) : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, getProportionateScreenHeight(147)),
        child: CustomAppBar(),
      ),
      body: Product(),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  double circlePointerPosition = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 78),
      child: Stack(
        children: [
          Row(
            children: [
              Text("PyrEye.",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: getProportionateScreenWidth(37))),
              SizedBox(width: getProportionateScreenWidth(817)),
              InkWell(
                onTap: () {
                  setState(() {
                    circlePointerPosition = getProportionateScreenWidth(1249);
                  });
                },
                child: Text(
                  "Home",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: getProportionateScreenWidth(20)),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(90)),
              InkWell(
                onTap: () {
                  setState(() {
                    circlePointerPosition = getProportionateScreenWidth(1339);
                  });
                },
                child: Text(
                  "Product",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: getProportionateScreenWidth(20)),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(90)),
              InkWell(
                onTap: () {
                  setState(() {
                    circlePointerPosition = getProportionateScreenWidth(1429);
                  });
                },
                child: Text(
                  "About us",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: getProportionateScreenWidth(20)),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(90)),
              InkWell(
                onTap: () {
                  setState(() {
                    circlePointerPosition = getProportionateScreenWidth(1519);
                  });
                },
                child: Text(
                  "Contact",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: getProportionateScreenWidth(20)),
                ),
              ),
            ],
          ),
          if (circlePointerPosition != 0)
            Container(
                padding: EdgeInsets.only(left: circlePointerPosition),
                child: Image(
                    image: AssetImage(
                        "assets/images/appbar/circlePointer/circlePointer.png"))),
        ],
      ),
    );
  }
}
