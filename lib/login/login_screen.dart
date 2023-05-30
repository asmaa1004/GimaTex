
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimatex/dll.dart';
import 'package:gimatex/login/companies.dart';
import 'package:gimatex/main.dart';
import 'package:store_redirect/store_redirect.dart';
import '../api_link.dart';
import '../components/colors.dart';
import '../functions.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with DLL{
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController code =  TextEditingController();
  TextEditingController password =  TextEditingController();


  bool isLoading = false;

  bool isVisible = false;

  void updateStatus() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  loginFunction() async {

    try {
      if (formState.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await postRequest(

            "$linkServerName/Login/Login.php", {
              "CusCode": code.text,
              "CusPass": password.text,
        });
        isLoading = false;
        setState(() {});
        if (response['status'] == "success") {

          sharedPref.setString("S_CusCode", response["data"][0]["CusCode"].toString());
          sharedPref.setString("S_UserType", response['data'][0]['UserType']);
          sharedPref.setString("S_LastUpdate", response['data'][0]['LastUpdate']);
          sharedPref.getString("S_LastUpdate");

          Navigator.of(context).pushNamedAndRemoveUntil("switch_screen", (route) => false);

        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'خطأ',
            desc:
            "الكود او الرقم السري غير صحيح برجاء التأكد واعاده المحاوله",
            btnCancelOnPress: () {},
            btnCancelText: 'إلغاء',
            btnCancelColor: Colors.red,
          ).show();
        }
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'خطأ',
        desc:
        "الرجاء التأكد من الاتصال بالإنترنت",
        btnCancelOnPress: () {},
        btnCancelText: 'إلغاء',
        btnCancelColor: Colors.red,
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    APIManger.GetAppInfo().then((value) =>
        checkApp()
    );
    if(sharedPref.getString("S_CusCode") != null){
      var textCode = sharedPref.getString("S_CusCode");
      code.text = textCode ?? "";
    }
  }

  void checkApp(){
    if(APIManger.appinfoIsMandory == "1"){
      if(APIManger.appVersion != APIManger.AppCurrentVerison ){
        AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'تحذير',
            desc:
            "تم إصدار تحديث جديد بالرجاء تنزيله",
            btnOkOnPress: () {
              StoreRedirect.redirect(androidAppId: "com.MousaSoft.gimatex",
                  iOSAppId: "585027354");
            },
            btnOkText: 'موافق',
            btnOkColor: kMainColor,
            dismissOnTouchOutside:false
        ).show();

      }
    }
    else{

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: kMainColor,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Companies(),
                ),
              );
            },
            icon: const Icon(Icons.double_arrow_outlined)),
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset(imageLink,width: 50,height: 50,),
          ),
        ],
        title: Center(
          child: Text
              (
              title,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
        ),
        ),

      body: isLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
      :Center(
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              Image.asset(
                imageLink,
                width: 100,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.all(50),
                child: Form(
                  key: formState,
                  child: Column(
                    children:
                    [
                      TextFormField(
                        controller: code,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {if ((val)!.isEmpty){return "الكود غير صحيح";}return null;} ,
                        enabled: true,
                        readOnly: false,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor,
                            ),
                          ),
                          labelText: 'كود العميل',
                          labelStyle: TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: kMainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: password,
                        validator: (val) {if ((val)!.isEmpty){return "الرقم السري غير صحيح";}return null;} ,
                        enabled: true,
                        readOnly: false,
                        obscureText: isVisible ? false : true,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor,
                            ),
                          ),
                          labelText: 'الرقم السري',
                          labelStyle: const TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: kMainColor,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () => updateStatus(),
                            icon:
                            Icon(
                                isVisible ? Icons.visibility : Icons.visibility_off,
                                color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: 170.0,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.white,
                            backgroundColor: kMainColor,
                            textStyle: const TextStyle(
                                fontSize: 20,
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                          ),
                          onPressed: () async {
                            await loginFunction();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
