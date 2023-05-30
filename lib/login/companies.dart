
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gimatex/api_link.dart';
import 'package:gimatex/dll.dart';
import 'package:gimatex/login/login_screen.dart';
import '../components/colors.dart';


class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> with DLL{
  GlobalKey<FormState> formState = GlobalKey();


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              kMainColor,
              Colors.white,
            ]
        )
    ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      linkServerName = "http://161.97.165.109:1010/GimaTex";
                      imageLink = "assets/images/GimaTexLogo.png";
                      title = "جيماتكس";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Ink.image(
                      width: 140,
                      height: 140,
                      image: const AssetImage(
                        'assets/images/GimaTexLogo.png',
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Column(
              children: [
                InkWell(
                  onTap: () {
                    linkServerName = "http://161.97.165.109:1010/NewGimaTex";
                    imageLink = "assets/images/NewGima.png";
                    title = "نيوجيماتكس";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Ink.image(
                    width: 140,
                    height: 140,
                    image: const AssetImage(
                      'assets/images/NewGima.png',
                    ),
                  ),
                )
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
