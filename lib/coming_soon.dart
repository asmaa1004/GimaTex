import 'package:flutter/material.dart';
import 'package:gimatex/api_link.dart';
import 'package:gimatex/components/colors.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: kMainColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(Icons.double_arrow_outlined)),
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset(imageLink,width: 50,height: 50,),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/commingsoon.jpeg"),
            fit: BoxFit.fill
          )
        ),
      ),
    );
  }
}
