import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimatex/dll.dart';
import '../api_link.dart';
import '../components/colors.dart';
import '../models/clothes.dart' show Data2, Clothes;
import '../models/customers.dart' show Data, Customers;
import 'package:http/http.dart' as http;

class ColorOrderReq extends StatefulWidget {
  const ColorOrderReq({Key? key}) : super(key: key);

  @override
  State<ColorOrderReq> createState() => _ColorOrderReqState();
}

class _ColorOrderReqState extends State<ColorOrderReq> with DLL {
  GlobalKey<FormState> formState = GlobalKey();

  String cloth = "";

  TextEditingController cusSNo = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController colorName = TextEditingController();
  TextEditingController colorNo = TextEditingController();
  TextEditingController reqWidth = TextEditingController();
  TextEditingController reqWeight = TextEditingController();
  TextEditingController notes = TextEditingController();

  Clothes? clothes;

  String pn01 = "";
  String pn02 = "";
  String pn03 = "";
  String pn04 = "";
  String pn05 = "";
  String pn06 = "";
  String pn07 = "";
  String pn08 = "";
  String pn09 = "";
  String pn10 = "";
  String pn11 = "";
  String pn12 = "";
  String pn13 = "";
  String pn14 = "";
  String pn15 = "";

  bool isLoading = false;

  bool pr01 = false;
  bool pr02 = false;
  bool pr03 = false;
  bool pr04 = false;
  bool pr05 = false;
  bool pr06 = false;
  bool pr07 = false;
  bool pr08 = false;
  bool pr09 = false;
  bool pr10 = false;
  bool pr11 = false;
  bool pr12 = false;
  bool pr13 = false;
  bool pr14 = false;
  bool pr15 = false;

  insert() async {


    try {
      if (formState.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response =
            await postRequest("$linkServerName/ColorOrderReq/InsertData.php", {
          "Cloth": cloth,
          "CusSNo": cusSNo.text,
          "Qty": qty.text,
          "ColorName": colorName.text,
          "ColorNo": colorNo.text,
          "ReqWidth": reqWidth.text,
          "ReqWeight": reqWeight.text,
          "Pr01": pn01.toString(),
          "Pr02": pn02.toString(),
          "Pr03": pn03.toString(),
          "Pr04": pn04.toString(),
          "Pr05": pn05.toString(),
          "Pr06": pn06.toString(),
          "Pr07": pn07.toString(),
          "Pr08": pn08.toString(),
          "Pr09": pn09.toString(),
          "Pr10": pn10.toString(),
          "Pr11": pn11.toString(),
          "Pr12": pn12.toString(),
          "Pr13": pn13.toString(),
          "Pr14": pn14.toString(),
          "Pr15": pn15.toString(),
          "Notes": notes.text,
        });
        isLoading = false;
        setState(() {});
        if (response['status'] == "Success") {
          AwesomeDialog(
            context: context,
            // ignore: deprecated_member_use
            dialogType: DialogType.SUCCES,
            // ignore: deprecated_member_use
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: "",
            desc: 'تم الارسال',
            descTextStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            btnCancelOnPress: () {
              cloth = "";
              cusSNo.text = "";
              qty.text = "";
              colorName.text = "";
              colorNo.text = "";
              reqWidth.text = "";
              reqWeight.text = "";
              notes.text = "";
              pr01 = false;
              pr02 = false;
              pr03 = false;
              pr04 = false;
              pr05 = false;
              pr06 = false;
              pr07 = false;
              pr08 = false;
              pr09 = false;
              pr10 = false ;
              pr11 = false;
              pr12 = false;
              pr13 = false;
              pr14 = false;
              pr15 = false ;
            },
            btnCancelText: 'تم',
            btnCancelColor: kMainColor,
          ).show();
        } else {
          AwesomeDialog(
                  context: context,
                  showCloseIcon: true,
                  title: "Alert",
                  body: const Text("تعذر ارسال البيانات"))
              .show();
        }
      }
    } catch (e) {
      AwesomeDialog(
              context: context,
              showCloseIcon: true,
              title: "Alert",
              body: Text(e.toString()))
          .show();
    }
  }

  void _getCloths() async {
    var response = await http
        .post(Uri.parse("$linkServerName/ColorOrderReq/Clothes.php"));

    setState(() {
      clothes = Clothes.fromJson(json.decode(response.body));
    });
  }

  @override
  void initState() {
    super.initState();
        _getCloths();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              child: Image.asset(
                imageLink,
                width: 50,
                height: 50,
              ),
            ),
          ],
          title: const Center(
            child: Text(
              "طلب التشكيل",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Autocomplete<Data2>(
                          optionsMaxHeight: 300,
                          onSelected: (data2){
                            cloth = data2.cloth;
                            FocusScope.of(context).requestFocus(FocusNode());
                          } ,
                          optionsBuilder: (TextEditingValue value) {
                            return clothes!.data2
                                .where((element) => element.cloth
                                .toLowerCase()
                                .contains(value.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (Data2 d)=>d.cloth,
                          fieldViewBuilder: (context, controller, focsNode, onEditingComplete){
                            return TextField(
                              textDirection: TextDirection.rtl,
                              controller: controller,
                              focusNode: focsNode,
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: kMainColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: kMainColor)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:const BorderSide(color: kMainColor)
                                ),
                                hintText: "أختر الخام",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: kMainColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: cusSNo,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'الرساله',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  //borderSide: const BorderSide(color: kMainColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (
                                TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: qty,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'الكميه',
                                 labelStyle: const TextStyle(
                                   color: Colors.black, fontSize: 20.0),
                                 border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "برجاء ادخال الكميه";
                                    }
                                    return null;
                                  },
                            )
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: colorName,
                              decoration: InputDecoration(
                                labelText: 'اللون',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  //borderSide: const BorderSide(color: kMainColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "برجاء ادخال اللون";
                                }
                                return null;
                              },
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: colorNo,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'الكود',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                            )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: reqWidth,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'العرض المطلوب',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  //borderSide: const BorderSide(color: kMainColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: (TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: reqWeight,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'الوزن المطلوب',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  //borderSide: const BorderSide(color: kMainColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                              ),
                            )),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kMainColor,
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'التجهيز المطلوب',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr01,
                                  onChanged: (val) {
                                    setState(() {
                                      pr01 = val!;
                                      if(val = true){
                                        pn01 = "صباغه قطن";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'صباغه قطن     ',
                                ),
                                Checkbox(
                                  value: pr04,
                                  onChanged: (val) {
                                    setState(() {
                                      pr04 = val!;
                                      if(val = true){
                                        pn04 = "معالجه زيوت";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'معالجه زيوت',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr02,
                                  onChanged: (val) {
                                    setState(() {
                                      pr02 = val!;
                                      if(val = true){
                                        pn02 = "صباغه بوليستر";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'صباغه بوليستر ',
                                ),
                                Checkbox(
                                  value: pr05,
                                  onChanged: (val) {
                                    setState(() {
                                      pr05 = val!;
                                      if(val = true){
                                        pn05 = "معالجه انزيم";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'معالجه انزيم',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr03,
                                  onChanged: (val) {
                                    setState(() {
                                      pr03 = val!;
                                      if(val = true){
                                        pn03 = "صباغه مرحلتين";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'صباغه مرحلتين',
                                ),
                                Checkbox(
                                  value: pr06,
                                  onChanged: (val) {
                                    setState(() {
                                      pr06 = val!;
                                      if(val = true){
                                        pn06 = "دبل انزيم";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'دبل انزيم',
                                ),
                                // Checkbox(
                                //   value: pr09,
                                //   onChanged: (val) {
                                //     setState(() {
                                //       pr09 = val!;
                                //       if(val = true){
                                //         pn09 = "تجهيز رجالي";
                                //       }
                                //     });
                                //   },
                                //   activeColor: kMainColor,
                                // ),
                                // const Text(
                                //   'تجهيز رجالي',
                                // ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr07,
                                  onChanged: (val) {
                                    setState(() {
                                      pr07 = val!;
                                      if(val = true){
                                        pn07 = "تجهيز مفتوح";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'تجهيز مفتوح    ',
                                ),
                                Checkbox(
                                  value: pr08,
                                  onChanged: (val) {
                                    setState(() {
                                      pr08 = val!;
                                      if(val = true){
                                        pn08 = "تجهيز مقفول";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'تجهيز مقفول',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr09,
                                  onChanged: (val) {
                                    setState(() {
                                      pr09 = val!;
                                      if(val = true){
                                        pn09 = "تجهيز رجالي";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'تجهيز رجالي     ',
                                ),
                                Checkbox(
                                  value: pr12,
                                  onChanged: (val) {
                                    setState(() {
                                      pr12 = val!;
                                      if(val = true){
                                        pn12 = "كستره";
                                      }

                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'كستره',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr10,
                                  onChanged: (val) {
                                    setState(() {
                                      pr10 = val!;
                                      if(val = true){
                                        pn10 = "تثبيت حراري";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'تثبيت حراري    ',
                                ),
                                Checkbox(
                                  value: pr11,
                                  onChanged: (val) {
                                    setState(() {
                                      pr11 = val!;
                                      if(val = true){
                                        pn11 = "كاربون فنش";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'كاربون فنش',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: pr13,
                                  onChanged: (val) {
                                    setState(() {
                                      pr13 = val!;
                                      if(val = true){
                                        pn13 = "شق";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'شق                 ',
                                ),
                                Checkbox(
                                  value: pr14,
                                  onChanged: (val) {
                                    setState(() {
                                      pr14 = val!;
                                      if(val = true){
                                        pn14 = "قص براسل";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'قص براسل',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start ,
                              children: [
                                Checkbox(
                                  value: pr15,
                                  onChanged: (val) {
                                    setState(() {
                                      pr15 = val!;
                                      if(val = true){
                                        pn15 = "سخاوه خاصه";
                                      }
                                    });
                                  },
                                  activeColor: kMainColor,
                                ),
                                const Text(
                                  'سخاوه خاصه',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(7),
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 0),
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: (TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: notes,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'الملاحظات',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              //borderSide: const BorderSide(color: kMainColor)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: kMainColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: kMainColor)),
                          ),
                        )),
                      ),
                      InkWell(
                        onTap: (){
                          if(formState.currentState!.validate()){
                            qty.clear();
                            colorName.clear();
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white, padding: const EdgeInsets.all(5.0),
                              backgroundColor: kMainColor,
                              textStyle: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            child: const Text(
                              'إرسال',
                            ),
                            onPressed: () async {
                              await insert();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
