import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../utils/constants/color.dart';
import 'forgot_pass2.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  bool _isInit = true;
  final String contact;
  final String verificationId;
  OtpScreen({super.key, required this.contact, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? smsOTP;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  //this is method is used to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      //generateOtp(widget.contact);
      widget._isInit = false;
    }
  }

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
  }

  //build method for UI
  @override
  Widget build(BuildContext context) {
    //Getting screen height width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("Xác thực SĐT"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              'Nhập mã OTP',
              style: TextStyle(
                fontSize: 20.sp,
                color: key1Color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              'Mã OTP được gửi qua số điện thoại đã đăng kí',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.025),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: OtpPinField(
                    key: _otpPinFieldKey,
                    textInputAction: TextInputAction.done,
                    maxLength: 6,
                    fieldWidth: 40.dg,
                    fieldHeight: 50.dg,
                    onSubmit: (text) {
                      smsOTP = text;
                    },
                    otpPinFieldStyle: OtpPinFieldStyle(
                        defaultFieldBorderColor: main1Color,
                        activeFieldBorderColor: main1Color,
                        filledFieldBackgroundColor: const Color(0xffE6EDFF)),
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    onChange: (text) {},
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    verifyOtp();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: main1Color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Xác minh',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Method for generate otp from firebase
  // Future<void> generateOtp(String contact) async {
  //   // smsOTPSent(verId, forceResendingToken) {
  //   //   verificationId = verId;
  //   // }

  //   try {
  //     final cred = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsOTP);
  //   } catch (e) {
  //     handleError(e as PlatformException);
  //   }
  // }

  //Method for verify otp entered by user
  Future<void> verifyOtp() async {
    // try {
    //   final cred = PhoneAuthProvider.credential(
    //       verificationId: verificationId, smsCode: smsOTP,);
    // } catch (e) {
    //   handleError(e as PlatformException);
    // }
    if (smsOTP == null || smsOTP == '') {
      showAlertDialog(context, 'xin mời nhập mã otp');
      return;
    }
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsOTP ?? '',
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User? currentUser = _auth.currentUser;
      assert(user.user?.uid == currentUser?.uid);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => ForgotPass2(
                contact: widget.contact,
              )),
        ),
      );
    } on PlatformException catch (e) {
      handleError(e);
    } catch (e) {
      log(e.toString());
    }
  }

  //Method for handle the errors
  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message ?? 'Error');
        break;
    }
  }

  //Basic alert dialogue for alert errors and confirmations
  void showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
