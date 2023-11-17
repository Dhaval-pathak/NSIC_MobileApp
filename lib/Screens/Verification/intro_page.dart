import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false; // Return false to prevent going back in the navigation stack
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = (size.width);
    final height = (size.height);
    final headingFontSize = height / 45;
    final subtextFontSize = height / 55;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Unit Registration Intro"),
          centerTitle: true,
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0x33dbfff0),
                Color(0xfff3e9db),
                Color(0x47f6f6b5),
              ],
              tileMode: TileMode.clamp,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 50),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 4,
                        height: height / 8,
                        child: Image.asset('assets/images/nsic.png'),
                      ),
                      Flexible(
                        child: Text(
                          "Registration under Single Point Registration Scheme",
                          style: TextStyle(
                            fontSize: height / 45,
                            fontWeight: FontWeight.bold,
                            height: 1.5
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 43,
                  ),

                  //Column 1 SPR
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SINGLE POINT REGISTRATION",
                        style: TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Subtext(
                        text:
                            "NSIC registers Micro & small Enterprises (MSEs) under Single Point "
                            "Registration scheme (SPRS) for participation in Government "
                            "Purchases. The units registered under Single Point Registration"
                            " Scheme of NSIC are eligible to get the benefits under Public "
                            "Procurement Policy for Micro & Small Enterprises (MSEs) Order "
                            "2012 as notified by the Government of India, Ministry of Micro "
                            "Small & Medium Enterprises, New Delhi vide Gazette Notification "
                            "dated 23.03.2012 and amendment vide order no. S.O. 5670(E) dated "
                            "9th November 2018.\n",
                        fontSize: subtextFontSize,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),

                  //Column 2
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BENEFITS EXTENDED TO MSEs HAVING VALID REGISTRATION",
                        style: TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Subtext(
                        text: "1. Issue of the Tender Sets free of cost.\n\n"
                            "2. Exemption from payment of Earnest Money Deposit (EMD).\n\n"
                            "3. In tender participating MSEs quoting price within price band of L1+15 per cent shall also be allowed to supply a portion upto 25% of requirement by bringing down their price to L1 Price where L1 is non MSEs.\n\n"
                            "4. Every Central Ministries/Departments/PSUs shall set an annual goal of minimum 25 per cent of the total annual purchases of the products or services produced or rendered by MSEs.Out of annual requirement of 25% procurement from MSEs,"
                            " 4% is earmarked for units owned by Schedule Caste /Schedule Tribes and 3% is earmarked for the units owned by Women entrepreneurs.SPRS registered units are integral part of the supply chain to Government.\n\n"
                            "5. In addition to the above, 358 items are also reserved for exclusive purchase from MSE Sector (List is given below in download section).\n\n"
                            "6. Provides access to many schemes & benefits.\n",
                        fontSize: subtextFontSize,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),

                  //Column 3
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTRATION CRITERIA",
                        style: TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                              text:
                                  "1. Micro and Small Enterprises (MSEs) involved in manufacturing & Services are eligible for registration.To know about new defintion of MSME, ",
                              style: TextStyle(
                                fontSize: subtextFontSize,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: subtextFontSize,
                              ),
                              text: "click here\n",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL("https://msme.gov.in/know-about-msme");
                                },
                            )
                          ])),
                      Subtext(
                        text:
                            "2. Traders are not eligible for registration under this Scheme\n\n"
                            "3. The validity of SPRS Certificateis is of 2 years from the date of registartion and there after renewed after every two years.\n\n"
                            "4. MSEs already commenced their commercial production (Start Ups) but not completed one year of existence are eligible for Provisional Registration for one year.MSEs can apply for full registartion after completion of one year.\n",
                        fontSize: subtextFontSize,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),

                  //Column 4
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTRATION PROCESS",
                        style: TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      RichText(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "1. Please visit ",
                                style: TextStyle(
                                  fontSize: subtextFontSize,
                                )),
                            TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: subtextFontSize,
                              ),
                              text: "Udyam Registration website",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL("https://udyamregistration.gov.in/");
                                },
                            ),
                            TextSpan(
                              text: " for obtaining Udyam Registartion Number.\n",
                              style: TextStyle(
                                fontSize: subtextFontSize,
                              ),
                            ),
                          ])),
                      RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: subtextFontSize,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "2. MSEs have to register themselves in ",
                              style: TextStyle(
                                fontSize: subtextFontSize,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: subtextFontSize,
                              ),
                              text: "MSMEDataBank",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL("http://www.msmedatabank.in/");
                                },
                            ),
                            TextSpan(
                                text:
                                    " using Udyam Registartion Number and PAN, to get themslves registered for Single Point Registration..\n",
                                style: TextStyle(
                                  fontSize: subtextFontSize,
                                )),
                          ],
                        ),
                      ),
                      Subtext(
                        text:
                            "3. Single Point Registration has a 7 step form,each step can be filled staggeredly.Each step has save and continue option.This way form can be refilled and reviewed at any moment using your PAN and Udyam Registartion Number combination.\n\n"
                            "4. It is requested to go through Checklist and Download section to get to know about required forms,annexure and documents.\n\n"
                            "5. It is always advisable to kindly place all required forms,annexure and documents on your desktop in a folder for fast uploading.\n\n"
                            "6. Fees will be charged on the basis of Unit Enterprise category(Micro or Small).\n\n"
                            "7. Third party inspection is also involved for store item inspection.Units are requested to kindly choose inspection agency according to their domain expertise and jurisdiction.\n\n"
                            "8. Final Certificate will be available online and respective NSIC office will send physical certificate copy by post.\n\n"
                            "9. For any communications,the registration number of certificate may be quoted.\n",
                        fontSize: subtextFontSize,
                      ),
                      RichText(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              children: [
                            TextSpan(
                              text:
                                  "10. Contact our NSIC field offices for any query by visiting ",
                              style: TextStyle(
                                fontSize: subtextFontSize,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: subtextFontSize,
                              ),
                              text:
                                  "https://nsic.co.in/Corporate/SearchBranch.aspx",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      "https://nsic.co.in/Corporate/SearchBranch.aspx");
                                },
                            )
                          ])),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),

                  //Column 5
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nCHECKLIST & DOWNLOADS",
                        style: TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/FreshRegistration.pdf");
                          },
                          child: Text(
                            "1. Check-List of Fresh Registration/ Annexure (1-13)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Check-List-15-04112020.pdf");
                          },
                          child: Text(
                            "2. Check-List of Provisional Registration (15)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Check-List-14_Updated_21032022.pdf");
                          },
                          child: Text(
                            "3. Check-List for Renewal of Registration (14)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Amendment.pdf");
                          },
                          child: Text(
                            "4. Check-List for Amendment In Registration (16A-16G)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Updated_Empanelled_Agency_Eng_21032022.pdf");
                          },
                          child: Text(
                            "5. List of Empanelled Agencies along with Inspection Fees (17A-17E)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Faqs_2020.pdf");
                          },
                          child: Text(
                            "6. Frequently Asked Questions (FAQs)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/358LIST2020.pdf");
                          },
                          child: Text(
                            "7. List of 358 reserved items (19A-19H)\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Document/pdfs/Fees_2020.pdf");
                          },
                          child: Text(
                            "8. Guidelines along with NSIC Processing Fees\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                      GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.nsicspronline.com//Fee_Calculator.aspx");
                          },
                          child: Text(
                            "9. Fee Calculator\n",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),

                  //Column 6
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Disclaimer:",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      Text(
                        "Merely submission of online form does not entitle a MSE to get Single Point Registration certificate. Those MSEs with valid documents and passed third party inspection with all fees/dues cleared, will be eligible for SPRS certificate",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 25,
                  ),

                  //Button
                  SizedBox(width: width/2,
                    height: height/15,
                    child: ElevatedButton(
                        onPressed: () async {

                            final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushNamed(context, "/verify");
                        },
                        child: Text("Accept")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Subtext extends StatelessWidget {
  final double fontSize;
  final text;

  const Subtext({Key? key, required this.fontSize, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
