import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:nsic/Models/DocumentToBeUploadedModel.dart';
import 'package:nsic/Utilities/customAppbar.dart';
import 'package:nsic/Widgets/fileUploadWidget.dart';
import 'package:nsic/api_call.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Component5 extends StatefulWidget {
  final List<DocumentToBeUploadedModel> documents;
  final String companyId;

  const Component5({Key? key, required this.documents, required this.companyId}) : super(key: key);

  @override
  State<Component5> createState() => _Component5State();
}

class _Component5State extends State<Component5> {
  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<void> sendEmail(String email)async {
  //
  //   String username = "username";
  //   String password ="passwords";
  //
  //   final smtpServer = SmtpServer("host",
  //       port: 80,
  //       ignoreBadCertificate: false,
  //       ssl: false,
  //       username: username,
  //     password: password,
  //     xoauth2Token: ""
  //   );
  //
  //   final message = Message()
  //     ..from = Address(username, 'Nsic')
  //     ..recipients.add(email)
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
  //
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print(' Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  // }

  bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xfffffff5),
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/nsic.png'),
                  ),
                  Flexible(
                    child: Text(
                      "Registration under Single Point Registration Scheme",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Text("Upload Required Documents", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height:5,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Text("(Only .jpg, .jpeg, .gif, .png, .pdf are allowed)", style: TextStyle(color: Colors.red),),
              ),
              SizedBox(height: 10,),
              Center(
                child: GestureDetector(
                  onTap: (){_launchURL("https://www.nsicspronline.com/Document/pdfs/4_SPRS19052018.pdf");},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Text("Click here to Download Annexures", style: TextStyle(color: Colors.red, fontSize: 16),),),),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height:1500,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: widget.documents.length,
                    itemBuilder: (context, int index) {
                      return FileUploadWidget(
                          title: widget.documents[index].fGPtblMdDocumentName,
                          size: widget.documents[index].link,
                          sizeText: widget.documents[index].size, companyId: widget.companyId,);
                    }),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Confirmation",
                          middleTextStyle: TextStyle(color: Colors.red[700]),
                          middleText:
                              "By confirming you will allow the data entered from your side to be proceeded to our team. Do make sure your have uploaded all the documents to avoid rejection of application.",
                          actions: [
                            isSubmitting? CircularProgressIndicator() :ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isSubmitting = true;
                                  });
                                  final prefs = await SharedPreferences.getInstance();
                                  var companyId = prefs.getString("step1OutputCompanyId");
                                  var email = prefs.getString("emailController");
                                  // print(email);
                                  var cunitList = await ApiCall.loadCunitAddressList();
                                  int cunitId = cunitList[0].fGPtblCUnitId!;
                                  String reference = await ApiCall().step5Complete(companyId!, cunitId.toString());
                                  // await sendEmail(email!);
                                  // print(reference);
                                  setState(() {
                                    isSubmitting = false;
                                  });
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                      title: "Success",
                                      middleText:
                                          "Your Application is proceeded to our team, "
                                              "they will get back to you once they have checked everything. "
                                              "\n Further application will be proceeded on your website "
                                              "www.nsicspronline.com.\n"
                                              "Reference Number : $reference",
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              if (Platform.isAndroid) {
                                                SystemNavigator.pop();
                                              } else if (Platform.isIOS) {
                                                exit(0);
                                              }
                                            },
                                            child: Text("Confirm"))
                                      ]);
                                },
                                child: Text(isSubmitting? "Please Wait": "Submit"))
                          ]);
                    },
                    child: Text("Save & Continue")),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
