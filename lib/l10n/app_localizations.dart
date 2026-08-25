import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào thế giới!'**
  String get helloWorld;

  /// No description provided for @skip.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get skip;

  /// No description provided for @loginAsResident.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với vai trò cư dân'**
  String get loginAsResident;

  /// No description provided for @loginAsManager.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với vai trò quản lý'**
  String get loginAsManager;

  /// No description provided for @hello.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào!'**
  String get hello;

  /// No description provided for @welcomeBackLogin.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đã trở lại, hãy đăng nhập'**
  String get welcomeBackLogin;

  /// No description provided for @account.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get account;

  /// No description provided for @phoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phoneNumber;

  /// No description provided for @connectionError.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi kết nối'**
  String get connectionError;

  /// No description provided for @cannotSendOtp.
  ///
  /// In vi, this message translates to:
  /// **'Không thể gửi mã OTP. Vui lòng thử lại.'**
  String get cannotSendOtp;

  /// No description provided for @ok.
  ///
  /// In vi, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không đúng định dạng'**
  String get invalidPhoneNumber;

  /// No description provided for @pleaseCheckPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại số điện thoại đã nhập'**
  String get pleaseCheckPhoneNumber;

  /// No description provided for @error.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi'**
  String get error;

  /// No description provided for @phoneNotRegisteredResident.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại của bạn chưa đăng ký cư dân'**
  String get phoneNotRegisteredResident;

  /// No description provided for @authFailed.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực thất bại'**
  String get authFailed;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @wantToExperienceApp.
  ///
  /// In vi, this message translates to:
  /// **'Bạn muốn trải nghiệm ứng dụng?'**
  String get wantToExperienceApp;

  /// No description provided for @leaveInformation.
  ///
  /// In vi, this message translates to:
  /// **'Để lại thông tin'**
  String get leaveInformation;

  /// No description provided for @changePassword.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi mật khẩu'**
  String get changePassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới'**
  String get enterNewPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get reEnterPassword;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu thành công'**
  String get changePasswordSuccess;

  /// No description provided for @changePasswordButton.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu'**
  String get changePasswordButton;

  /// No description provided for @forgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu'**
  String get forgotPassword;

  /// No description provided for @enterRegisteredPhoneToResetPassword.
  ///
  /// In vi, this message translates to:
  /// **'Hãy nhập SĐT đã đăng ký để đặt lại mật khẩu.'**
  String get enterRegisteredPhoneToResetPassword;

  /// No description provided for @verifyOtp.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh OTP'**
  String get verifyOtp;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPasswordQuestion;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In vi, this message translates to:
  /// **'Email không đúng định dạng'**
  String get invalidEmailFormat;

  /// No description provided for @pleaseCheckEmail.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại email đã nhập'**
  String get pleaseCheckEmail;

  /// No description provided for @loginFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại'**
  String get loginFailed;

  /// No description provided for @pleaseCheckAccountAndPassword.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại tài khoản và mật khẩu'**
  String get pleaseCheckAccountAndPassword;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực SĐT'**
  String get verifyPhoneNumber;

  /// No description provided for @enterOtp.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã OTP'**
  String get enterOtp;

  /// No description provided for @otpSentToRegisteredPhone.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP được gửi qua số điện thoại đã đăng kí'**
  String get otpSentToRegisteredPhone;

  /// No description provided for @verify.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh'**
  String get verify;

  /// No description provided for @pleaseEnterOtp.
  ///
  /// In vi, this message translates to:
  /// **'xin mời nhập mã otp'**
  String get pleaseEnterOtp;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng thử lại'**
  String get pleaseTryAgain;

  /// No description provided for @agree.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get agree;

  /// No description provided for @errorOccurredTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Đã có lỗi xảy ra, vui lòng thử lại.'**
  String get errorOccurredTryAgain;

  /// No description provided for @incorrectOtp.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP không chính xác.'**
  String get incorrectOtp;

  /// No description provided for @otpExpired.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP đã hết hạn, vui lòng yêu cầu mã mới.'**
  String get otpExpired;

  /// No description provided for @authError.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi xác thực'**
  String get authError;

  /// No description provided for @sendRegistrationInfoSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Gửi thông tin đăng ký thành công'**
  String get sendRegistrationInfoSuccess;

  /// No description provided for @registrationInfoSentSuccessfully.
  ///
  /// In vi, this message translates to:
  /// **'Yay! Bạn đã gửi thông tin đăng ký trải nghiệm ứng dụng thành công.'**
  String get registrationInfoSentSuccessfully;

  /// No description provided for @backToLogin.
  ///
  /// In vi, this message translates to:
  /// **'Quay về đăng nhập'**
  String get backToLogin;

  /// No description provided for @yourInformation.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin của bạn'**
  String get yourInformation;

  /// No description provided for @registerToExperienceApp.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký để trải nghiệm ứng dụng!'**
  String get registerToExperienceApp;

  /// No description provided for @fullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get fullName;

  /// No description provided for @noteContent.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung ghi chú'**
  String get noteContent;

  /// No description provided for @sendInformation.
  ///
  /// In vi, this message translates to:
  /// **'Gửi thông tin'**
  String get sendInformation;

  /// No description provided for @invoice.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn'**
  String get invoice;

  /// No description provided for @paymentHistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử thanh toán'**
  String get paymentHistory;

  /// No description provided for @noUnpaidInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Không có hoá đơn chờ thanh toán'**
  String get noUnpaidInvoice;

  /// No description provided for @noPaymentHistory.
  ///
  /// In vi, this message translates to:
  /// **'Không có lịch sử thanh toán'**
  String get noPaymentHistory;

  /// No description provided for @paid.
  ///
  /// In vi, this message translates to:
  /// **'Đã thanh toán'**
  String get paid;

  /// No description provided for @deadlineColon.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán:'**
  String get deadlineColon;

  /// No description provided for @invoiceDetail.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết hoá đơn'**
  String get invoiceDetail;

  /// No description provided for @customerNameColon.
  ///
  /// In vi, this message translates to:
  /// **'Tên khách hàng:'**
  String get customerNameColon;

  /// No description provided for @invoicePeriodColon.
  ///
  /// In vi, this message translates to:
  /// **'Kỳ hoá đơn:'**
  String get invoicePeriodColon;

  /// No description provided for @electricityInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn điện'**
  String get electricityInvoice;

  /// No description provided for @mockPrice1.
  ///
  /// In vi, this message translates to:
  /// **'298.700 đ'**
  String get mockPrice1;

  /// No description provided for @parkingInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn gửi xe'**
  String get parkingInvoice;

  /// No description provided for @vehicleOwnerColon.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe:'**
  String get vehicleOwnerColon;

  /// No description provided for @phoneNumberColon.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại:'**
  String get phoneNumberColon;

  /// No description provided for @vehicleNameColon.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện:'**
  String get vehicleNameColon;

  /// No description provided for @feeColon.
  ///
  /// In vi, this message translates to:
  /// **'Phí:'**
  String get feeColon;

  /// No description provided for @licensePlateColon.
  ///
  /// In vi, this message translates to:
  /// **'Biển số:'**
  String get licensePlateColon;

  /// No description provided for @buildingFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí toà nhà'**
  String get buildingFee;

  /// No description provided for @areaColon.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích:'**
  String get areaColon;

  /// No description provided for @additionalFeeColon.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thêm:'**
  String get additionalFeeColon;

  /// No description provided for @maintenanceFeeColon.
  ///
  /// In vi, this message translates to:
  /// **'Phí bảo trì:'**
  String get maintenanceFeeColon;

  /// No description provided for @electricFeeColon.
  ///
  /// In vi, this message translates to:
  /// **'Tiền điện:'**
  String get electricFeeColon;

  /// No description provided for @waterFeeColon.
  ///
  /// In vi, this message translates to:
  /// **'Tiền nước:'**
  String get waterFeeColon;

  /// No description provided for @paymentDeadline.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán'**
  String get paymentDeadline;

  /// No description provided for @totalFee.
  ///
  /// In vi, this message translates to:
  /// **'Tổng Phí'**
  String get totalFee;

  /// No description provided for @debtFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí Nợ'**
  String get debtFee;

  /// No description provided for @paidFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí đã thanh toán'**
  String get paidFee;

  /// No description provided for @overpaidFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thừa'**
  String get overpaidFee;

  /// No description provided for @actualPaymentFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí thanh toán thực tế'**
  String get actualPaymentFee;

  /// No description provided for @payNow.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán ngay'**
  String get payNow;

  /// No description provided for @monthlyInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn hàng tháng'**
  String get monthlyInvoice;

  /// No description provided for @totalFeeColon.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phí:'**
  String get totalFeeColon;

  /// No description provided for @monthColon.
  ///
  /// In vi, this message translates to:
  /// **'Tháng:'**
  String get monthColon;

  /// No description provided for @statusColon.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng:'**
  String get statusColon;

  /// No description provided for @unpaid.
  ///
  /// In vi, this message translates to:
  /// **'Chưa thanh toán'**
  String get unpaid;

  /// No description provided for @usageAmountColon.
  ///
  /// In vi, this message translates to:
  /// **'Số sử dụng:'**
  String get usageAmountColon;

  /// No description provided for @firstPeriodAmountColon.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ đầu:'**
  String get firstPeriodAmountColon;

  /// No description provided for @lastPeriodAmountColon.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ cuối:'**
  String get lastPeriodAmountColon;

  /// No description provided for @unitColon.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tính:'**
  String get unitColon;

  /// No description provided for @usageDetailColon.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết số sử dụng:'**
  String get usageDetailColon;

  /// No description provided for @electricTier1.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 1-50 KWh) x giá 1.950 đ:'**
  String get electricTier1;

  /// No description provided for @electricTier2.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 51-100 KWh) x giá 2.015 đ:'**
  String get electricTier2;

  /// No description provided for @electricTier3.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 101-200 KWh) x giá 2.340 đ:'**
  String get electricTier3;

  /// No description provided for @electricTier4.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 201-300 KWh) x giá 2.947 đ:'**
  String get electricTier4;

  /// No description provided for @electricTier5.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 301-400 KWh) x giá 3.294 đ:'**
  String get electricTier5;

  /// No description provided for @electricTier6.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 400 KWh trở lên) x giá 3.403 đ:'**
  String get electricTier6;

  /// No description provided for @totalAmountColon.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền:'**
  String get totalAmountColon;

  /// No description provided for @licensePlateTypoColon.
  ///
  /// In vi, this message translates to:
  /// **'Biến số:'**
  String get licensePlateTypoColon;

  /// No description provided for @waterTier1.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 1-10 m3) x giá 9.775 đ:'**
  String get waterTier1;

  /// No description provided for @waterTier2.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 11-20 m3) x giá 11.385 đ:'**
  String get waterTier2;

  /// No description provided for @waterTier3.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 21-30 m3) x giá 18.400 đ:'**
  String get waterTier3;

  /// No description provided for @waterTier4.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 31 m3 trở lên) x giá 31.050 đ:'**
  String get waterTier4;

  /// No description provided for @detail.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết'**
  String get detail;

  /// No description provided for @payment.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán'**
  String get payment;

  /// No description provided for @pleasePayQR.
  ///
  /// In vi, this message translates to:
  /// **'Cư dân vui lòng thanh toán hóa đơn theo mã QR dưới đây:'**
  String get pleasePayQR;

  /// No description provided for @amount.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền'**
  String get amount;

  /// No description provided for @transferContent.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung chuyển khoản'**
  String get transferContent;

  /// No description provided for @captureAndSaveQR.
  ///
  /// In vi, this message translates to:
  /// **'Chụp và lưu mã QR'**
  String get captureAndSaveQR;

  /// No description provided for @savedQRCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã Qr đã lưu'**
  String get savedQRCode;

  /// No description provided for @copied.
  ///
  /// In vi, this message translates to:
  /// **'Đã sao chép!'**
  String get copied;

  /// No description provided for @photoLibraryDenied.
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập thư viện ảnh bị từ chối.'**
  String get photoLibraryDenied;

  /// No description provided for @cannotCaptureWidget.
  ///
  /// In vi, this message translates to:
  /// **'Không thể chụp ảnh widget.'**
  String get cannotCaptureWidget;

  /// No description provided for @home.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get home;

  /// No description provided for @support.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ'**
  String get support;

  /// No description provided for @utility.
  ///
  /// In vi, this message translates to:
  /// **'Tiện ích'**
  String get utility;

  /// No description provided for @accountNav.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get accountNav;

  /// No description provided for @nhuThat.
  ///
  /// In vi, this message translates to:
  /// **'Như Thật'**
  String get nhuThat;

  /// No description provided for @supportRequest.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu hỗ trợ'**
  String get supportRequest;

  /// No description provided for @residentRequestsUpdatedHere.
  ///
  /// In vi, this message translates to:
  /// **'Những yêu cầu, phản ánh của cư dân sẽ được cập nhật tại đây!'**
  String get residentRequestsUpdatedHere;

  /// No description provided for @supportFeedback.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ / Phản ánh'**
  String get supportFeedback;

  /// No description provided for @changeInformation.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi thông tin'**
  String get changeInformation;

  /// No description provided for @registeredUtilityList.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách đăng ký tiện ích'**
  String get registeredUtilityList;

  /// No description provided for @apartment.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ'**
  String get apartment;

  /// No description provided for @electricityWater.
  ///
  /// In vi, this message translates to:
  /// **'Điện/Nước'**
  String get electricityWater;

  /// No description provided for @notification.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notification;

  /// No description provided for @paymentRequest.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu thanh toán'**
  String get paymentRequest;

  /// No description provided for @noPaymentRequest.
  ///
  /// In vi, this message translates to:
  /// **'Không có yêu cầu thanh toán nào'**
  String get noPaymentRequest;

  /// No description provided for @buildingNews.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin toà nhà'**
  String get buildingNews;

  /// No description provided for @apartmentProfile.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ căn hộ'**
  String get apartmentProfile;

  /// No description provided for @residencyInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cư trú'**
  String get residencyInfo;

  /// No description provided for @headOfHousehold.
  ///
  /// In vi, this message translates to:
  /// **'Chủ hộ'**
  String get headOfHousehold;

  /// No description provided for @fullNameLabel.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get fullNameLabel;

  /// No description provided for @idNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số định danh'**
  String get idNumber;

  /// No description provided for @dob.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get dob;

  /// No description provided for @phoneLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phoneLabel;

  /// No description provided for @editHeadInfo.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin Chủ hộ'**
  String get editHeadInfo;

  /// No description provided for @apartmentInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin căn hộ'**
  String get apartmentInfo;

  /// No description provided for @houseNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số nhà'**
  String get houseNumber;

  /// No description provided for @floor.
  ///
  /// In vi, this message translates to:
  /// **'Tầng'**
  String get floor;

  /// No description provided for @floorArea.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích mặt sàn'**
  String get floorArea;

  /// No description provided for @statusShort.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng'**
  String get statusShort;

  /// No description provided for @familyMembers.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên trong hộ gia đình'**
  String get familyMembers;

  /// No description provided for @enterCurrentPasswordNow.
  ///
  /// In vi, this message translates to:
  /// **'Bây giờ hãy nhập mật khẩu hiện tại của bạn'**
  String get enterCurrentPasswordNow;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu hiện tại'**
  String get enterCurrentPassword;

  /// No description provided for @confirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// No description provided for @chooseSafePassword.
  ///
  /// In vi, this message translates to:
  /// **'Hay chọn một mật khẩu an toàn chỉ mình bạn biết'**
  String get chooseSafePassword;

  /// No description provided for @enterNewPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới'**
  String get enterNewPasswordTitle;

  /// No description provided for @reEnterPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get reEnterPasswordTitle;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu thành công'**
  String get passwordChangedSuccessfully;

  /// No description provided for @addMember.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thành viên'**
  String get addMember;

  /// No description provided for @relationToHead.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ với chủ hộ'**
  String get relationToHead;

  /// No description provided for @editMemberInfo.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin thành viên'**
  String get editMemberInfo;

  /// No description provided for @spouse.
  ///
  /// In vi, this message translates to:
  /// **'Vợ/Chồng'**
  String get spouse;

  /// No description provided for @children.
  ///
  /// In vi, this message translates to:
  /// **'Con cái'**
  String get children;

  /// No description provided for @parents.
  ///
  /// In vi, this message translates to:
  /// **'Bố/Mẹ'**
  String get parents;

  /// No description provided for @siblings.
  ///
  /// In vi, this message translates to:
  /// **'Anh/Chị/Em'**
  String get siblings;

  /// No description provided for @tenant.
  ///
  /// In vi, this message translates to:
  /// **'Khách thuê'**
  String get tenant;

  /// No description provided for @accountInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản'**
  String get accountInfo;

  /// No description provided for @mockName.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thế Hoàng'**
  String get mockName;

  /// No description provided for @uploadImage.
  ///
  /// In vi, this message translates to:
  /// **'Tải ảnh lên'**
  String get uploadImage;

  /// No description provided for @takePhoto.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh'**
  String get takePhoto;

  /// No description provided for @errorTryAgainLater.
  ///
  /// In vi, this message translates to:
  /// **'Có lỗi xảy ra, thử lại sau'**
  String get errorTryAgainLater;

  /// No description provided for @registeredVehicles.
  ///
  /// In vi, this message translates to:
  /// **'Phương tiện đăng ký'**
  String get registeredVehicles;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa tài khoản của mình?'**
  String get confirmDeleteAccount;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In vi, this message translates to:
  /// **'Xóa tài khoản'**
  String get deleteAccount;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chắc chắn muốn đăng xuất?'**
  String get confirmLogout;

  /// No description provided for @notUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Chưa cập nhật'**
  String get notUpdated;

  /// No description provided for @vehicleOwner.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe'**
  String get vehicleOwner;

  /// No description provided for @owner.
  ///
  /// In vi, this message translates to:
  /// **'Chủ sở hữu'**
  String get owner;

  /// No description provided for @licensePlate.
  ///
  /// In vi, this message translates to:
  /// **'Biển số xe'**
  String get licensePlate;

  /// No description provided for @contact.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ'**
  String get contact;

  /// No description provided for @registeredFrom.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí từ'**
  String get registeredFrom;

  /// No description provided for @parkingFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi'**
  String get parkingFee;

  /// No description provided for @utilityServices.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ tiện ích'**
  String get utilityServices;

  /// No description provided for @noData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get noData;

  /// No description provided for @serviceDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả dịch vụ'**
  String get serviceDescription;

  /// No description provided for @registerService.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký dịch vụ'**
  String get registerService;

  /// No description provided for @request.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu'**
  String get request;

  /// No description provided for @processing.
  ///
  /// In vi, this message translates to:
  /// **'Đang xử lý'**
  String get processing;

  /// No description provided for @completed.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get completed;

  /// No description provided for @noCompletedRequests.
  ///
  /// In vi, this message translates to:
  /// **'Không có yêu cầu đã hoàn tất'**
  String get noCompletedRequests;

  /// No description provided for @statusTitle.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get statusTitle;

  /// No description provided for @unprocessed.
  ///
  /// In vi, this message translates to:
  /// **'chưa xử lý'**
  String get unprocessed;

  /// No description provided for @requestStatus.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái yêu cầu'**
  String get requestStatus;

  /// No description provided for @processingProgress.
  ///
  /// In vi, this message translates to:
  /// **'Tiến trình xử lý:'**
  String get processingProgress;

  /// No description provided for @createRequest.
  ///
  /// In vi, this message translates to:
  /// **'Tạo yêu cầu'**
  String get createRequest;

  /// No description provided for @requestColon.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu :'**
  String get requestColon;

  /// No description provided for @statusColonSpace.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng :'**
  String get statusColonSpace;

  /// No description provided for @supportList.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách hỗ trợ'**
  String get supportList;

  /// No description provided for @seeMore.
  ///
  /// In vi, this message translates to:
  /// **'Xem thêm ...'**
  String get seeMore;

  /// No description provided for @unprocessedStatus.
  ///
  /// In vi, this message translates to:
  /// **'Chưa xử lý'**
  String get unprocessedStatus;

  /// No description provided for @yourStatus.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng của quý khách'**
  String get yourStatus;

  /// No description provided for @pleaseSelectStatus.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn tình trạng'**
  String get pleaseSelectStatus;

  /// No description provided for @customerInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin khách hàng'**
  String get customerInfo;

  /// No description provided for @contactPerson.
  ///
  /// In vi, this message translates to:
  /// **'Người liên hệ'**
  String get contactPerson;

  /// No description provided for @note.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get note;

  /// No description provided for @enterNote.
  ///
  /// In vi, this message translates to:
  /// **'Nhập ghi chú'**
  String get enterNote;

  /// No description provided for @requiredField.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc nhập'**
  String get requiredField;

  /// No description provided for @success.
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get success;

  /// No description provided for @requestSent.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu đã được gửi!'**
  String get requestSent;

  /// No description provided for @failure.
  ///
  /// In vi, this message translates to:
  /// **'Thất bại'**
  String get failure;

  /// No description provided for @sendRequestFailed.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu thất bại!'**
  String get sendRequestFailed;

  /// No description provided for @tryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get tryAgain;

  /// No description provided for @sendRequest.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu'**
  String get sendRequest;

  /// No description provided for @bqlCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ'**
  String get bqlCanHo;

  /// No description provided for @bqlTimKiemTenCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên căn hộ'**
  String get bqlTimKiemTenCanHo;

  /// No description provided for @bqlChonToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Chọn toà nhà'**
  String get bqlChonToaNha;

  /// No description provided for @bqlChonTrangThai.
  ///
  /// In vi, this message translates to:
  /// **'Chọn trạng thái'**
  String get bqlChonTrangThai;

  /// No description provided for @bqlKhongCoCanHoNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có căn hộ nào'**
  String get bqlKhongCoCanHoNao;

  /// No description provided for @bqlCuDan.
  ///
  /// In vi, this message translates to:
  /// **'Cư dân'**
  String get bqlCuDan;

  /// No description provided for @bqlPhuongTien.
  ///
  /// In vi, this message translates to:
  /// **'Phương tiện'**
  String get bqlPhuongTien;

  /// No description provided for @bqlPhiDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Phí dịch vụ'**
  String get bqlPhiDichVu;

  /// No description provided for @bqlSms.
  ///
  /// In vi, this message translates to:
  /// **'SMS'**
  String get bqlSms;

  /// No description provided for @bqlBienLai.
  ///
  /// In vi, this message translates to:
  /// **'Biên lai'**
  String get bqlBienLai;

  /// No description provided for @bqlTenCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Tên căn hộ'**
  String get bqlTenCanHo;

  /// No description provided for @bql2h601.
  ///
  /// In vi, this message translates to:
  /// **'2H601'**
  String get bql2h601;

  /// No description provided for @bqlTang.
  ///
  /// In vi, this message translates to:
  /// **'Tầng'**
  String get bqlTang;

  /// No description provided for @bqlTang6.
  ///
  /// In vi, this message translates to:
  /// **'Tầng 6'**
  String get bqlTang6;

  /// No description provided for @bqlTinhTrang.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng'**
  String get bqlTinhTrang;

  /// No description provided for @bqlDangO.
  ///
  /// In vi, this message translates to:
  /// **'Đang ở'**
  String get bqlDangO;

  /// No description provided for @bqlHoDan.
  ///
  /// In vi, this message translates to:
  /// **'Hộ dân'**
  String get bqlHoDan;

  /// No description provided for @bqlHoTen.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên'**
  String get bqlHoTen;

  /// No description provided for @bqlEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get bqlEmail;

  /// No description provided for @bqlNgaySinh.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get bqlNgaySinh;

  /// No description provided for @bqlCccd.
  ///
  /// In vi, this message translates to:
  /// **'CCCD'**
  String get bqlCccd;

  /// No description provided for @bqlQuanHe.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ'**
  String get bqlQuanHe;

  /// No description provided for @bqlKhongCoPhuongTienNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có phương tiện nào'**
  String get bqlKhongCoPhuongTienNao;

  /// No description provided for @bqlChuSoHuu.
  ///
  /// In vi, this message translates to:
  /// **'Chủ sở hữu'**
  String get bqlChuSoHuu;

  /// No description provided for @bqlTenPhuongTien.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện'**
  String get bqlTenPhuongTien;

  /// No description provided for @bqlBienSoXe.
  ///
  /// In vi, this message translates to:
  /// **'Biển số xe'**
  String get bqlBienSoXe;

  /// No description provided for @bqlPhiGuiXe.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi xe'**
  String get bqlPhiGuiXe;

  /// No description provided for @bqlKhongCoPhiDichVuNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có phí dịch vụ nào'**
  String get bqlKhongCoPhiDichVuNao;

  /// No description provided for @bqlVivn.
  ///
  /// In vi, this message translates to:
  /// **'vi_VN'**
  String get bqlVivn;

  /// No description provided for @bqlTrangThai.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get bqlTrangThai;

  /// No description provided for @bqlChuaCoSmsNao.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có SMS nào'**
  String get bqlChuaCoSmsNao;

  /// No description provided for @bqlYyyymmddKkmm.
  ///
  /// In vi, this message translates to:
  /// **'yyyy-MM-dd / kk:mm'**
  String get bqlYyyymmddKkmm;

  /// No description provided for @bqlNoiDung.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung'**
  String get bqlNoiDung;

  /// No description provided for @bqlLoaiTin.
  ///
  /// In vi, this message translates to:
  /// **'Loại tin'**
  String get bqlLoaiTin;

  /// No description provided for @bqlNguoiGui.
  ///
  /// In vi, this message translates to:
  /// **'Người gửi'**
  String get bqlNguoiGui;

  /// No description provided for @bqlChuaCoBienLaiNao.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có biên lai nào'**
  String get bqlChuaCoBienLaiNao;

  /// No description provided for @bqlChiTietPhieuThu.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết phiếu thu'**
  String get bqlChiTietPhieuThu;

  /// No description provided for @bqlPhong.
  ///
  /// In vi, this message translates to:
  /// **'Phòng'**
  String get bqlPhong;

  /// No description provided for @bqlTongTien.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền'**
  String get bqlTongTien;

  /// No description provided for @bqlHttt.
  ///
  /// In vi, this message translates to:
  /// **'HTTT'**
  String get bqlHttt;

  /// No description provided for @bqlTenKhachHang.
  ///
  /// In vi, this message translates to:
  /// **'Tên khách hàng:'**
  String get bqlTenKhachHang;

  /// No description provided for @bqlChuXe.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe:'**
  String get bqlChuXe;

  /// No description provided for @bqlTenPhuongTien1.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện:'**
  String get bqlTenPhuongTien1;

  /// No description provided for @bqlPhi.
  ///
  /// In vi, this message translates to:
  /// **'Phí:'**
  String get bqlPhi;

  /// No description provided for @bqlBienSo.
  ///
  /// In vi, this message translates to:
  /// **'Biển số:'**
  String get bqlBienSo;

  /// No description provided for @bqlPhiToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Phí toà nhà'**
  String get bqlPhiToaNha;

  /// No description provided for @bqlDienTich.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích:'**
  String get bqlDienTich;

  /// No description provided for @bqlPhiThuThem.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thêm:'**
  String get bqlPhiThuThem;

  /// No description provided for @bqlPhiBaoTri.
  ///
  /// In vi, this message translates to:
  /// **'Phí bảo trì:'**
  String get bqlPhiBaoTri;

  /// No description provided for @bqlTienNuoc.
  ///
  /// In vi, this message translates to:
  /// **'Tiền nước:'**
  String get bqlTienNuoc;

  /// No description provided for @bqlChuaThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Chưa thanh toán'**
  String get bqlChuaThanhToan;

  /// No description provided for @bqlHanThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán'**
  String get bqlHanThanhToan;

  /// No description provided for @bqlTongPhi.
  ///
  /// In vi, this message translates to:
  /// **'Tổng Phí'**
  String get bqlTongPhi;

  /// No description provided for @bqlPhiNo.
  ///
  /// In vi, this message translates to:
  /// **'Phí Nợ'**
  String get bqlPhiNo;

  /// No description provided for @bqlPhiThuThua.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thừa'**
  String get bqlPhiThuThua;

  /// No description provided for @bqlPhiThanhToanThucTe.
  ///
  /// In vi, this message translates to:
  /// **'Phí thanh toán thực tế'**
  String get bqlPhiThanhToanThucTe;

  /// No description provided for @bqlTongPhi1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phí: '**
  String get bqlTongPhi1;

  /// No description provided for @bqlThang.
  ///
  /// In vi, this message translates to:
  /// **'Tháng: '**
  String get bqlThang;

  /// No description provided for @bqlTinhTrang1.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng: '**
  String get bqlTinhTrang1;

  /// No description provided for @bqlSoSuDung.
  ///
  /// In vi, this message translates to:
  /// **'Số sử dụng:'**
  String get bqlSoSuDung;

  /// No description provided for @bqlSoKyCuoi.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ cuối:'**
  String get bqlSoKyCuoi;

  /// No description provided for @bqlDonViTinh.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tính:'**
  String get bqlDonViTinh;

  /// No description provided for @bqlChiTietSoSuDung.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết số sử dụng:'**
  String get bqlChiTietSoSuDung;

  /// No description provided for @bqlTongTien1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền:'**
  String get bqlTongTien1;

  /// No description provided for @bqlBienSo1.
  ///
  /// In vi, this message translates to:
  /// **'Biến số:'**
  String get bqlBienSo1;

  /// No description provided for @bqlChiTiet.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết'**
  String get bqlChiTiet;

  /// No description provided for @bqlChonThang.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tháng'**
  String get bqlChonThang;

  /// No description provided for @bqlThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get bqlThanhCong;

  /// No description provided for @bqlOk.
  ///
  /// In vi, this message translates to:
  /// **'OK'**
  String get bqlOk;

  /// No description provided for @bqlTuChoiYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối yêu cầu'**
  String get bqlTuChoiYeuCau;

  /// No description provided for @bqlHoVaTen.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get bqlHoVaTen;

  /// No description provided for @bqlQuanHeVoiChuHo.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ với chủ hộ'**
  String get bqlQuanHeVoiChuHo;

  /// No description provided for @bqlAnhXacMinhThongTin.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh xác minh thông tin'**
  String get bqlAnhXacMinhThongTin;

  /// No description provided for @bqlChuHo.
  ///
  /// In vi, this message translates to:
  /// **'Chủ hộ'**
  String get bqlChuHo;

  /// No description provided for @bqlVo.
  ///
  /// In vi, this message translates to:
  /// **'Vợ'**
  String get bqlVo;

  /// No description provided for @bqlChong.
  ///
  /// In vi, this message translates to:
  /// **'Chồng'**
  String get bqlChong;

  /// No description provided for @bqlCon.
  ///
  /// In vi, this message translates to:
  /// **'Con'**
  String get bqlCon;

  /// No description provided for @bqlBangTin.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin'**
  String get bqlBangTin;

  /// No description provided for @bqlXinChao.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào,'**
  String get bqlXinChao;

  /// No description provided for @bqlTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get bqlTaiKhoan;

  /// No description provided for @bqlBanCo.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có '**
  String get bqlBanCo;

  /// No description provided for @bqlHoTroMoiTrongNgay.
  ///
  /// In vi, this message translates to:
  /// **' hỗ trợ mới trong ngày'**
  String get bqlHoTroMoiTrongNgay;

  /// No description provided for @bqlXemTatCa.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả >'**
  String get bqlXemTatCa;

  /// No description provided for @bqlBangTinToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin toà nhà'**
  String get bqlBangTinToaNha;

  /// No description provided for @bqlTinhTrang2.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng : '**
  String get bqlTinhTrang2;

  /// No description provided for @bqlDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ'**
  String get bqlDichVu;

  /// No description provided for @bqlSdt.
  ///
  /// In vi, this message translates to:
  /// **'SDT'**
  String get bqlSdt;

  /// No description provided for @bqlThoiGian.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get bqlThoiGian;

  /// No description provided for @bqlNote.
  ///
  /// In vi, this message translates to:
  /// **'Note'**
  String get bqlNote;

  /// No description provided for @bqlChupAnhThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh thành công'**
  String get bqlChupAnhThanhCong;

  /// No description provided for @bqlChiTietYeuCauHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết yêu cầu hỗ trợ'**
  String get bqlChiTietYeuCauHoTro;

  /// No description provided for @bqlThemHinhAnh.
  ///
  /// In vi, this message translates to:
  /// **'Thêm hình ảnh'**
  String get bqlThemHinhAnh;

  /// No description provided for @bqlThemNote.
  ///
  /// In vi, this message translates to:
  /// **'Thêm note'**
  String get bqlThemNote;

  /// No description provided for @bqlTaoYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Tạo yêu cầu'**
  String get bqlTaoYeuCau;

  /// No description provided for @bqlNhapTinhTrangXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tình trạng xử lý'**
  String get bqlNhapTinhTrangXuLy;

  /// No description provided for @bqlDdmmyyyy.
  ///
  /// In vi, this message translates to:
  /// **'dd/MM/yyyy'**
  String get bqlDdmmyyyy;

  /// No description provided for @bqlHhmm.
  ///
  /// In vi, this message translates to:
  /// **'HH:mm'**
  String get bqlHhmm;

  /// No description provided for @bqlCapNhatThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thành công'**
  String get bqlCapNhatThanhCong;

  /// No description provided for @bqlVuiLongChonTrangThaiXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn trạng thái xử lý'**
  String get bqlVuiLongChonTrangThaiXuLy;

  /// No description provided for @bqlBayGioHayNhapMatKhauHienTaiCuaBan.
  ///
  /// In vi, this message translates to:
  /// **'Bây giờ hãy nhập mật khẩu hiện tại của bạn'**
  String get bqlBayGioHayNhapMatKhauHienTaiCuaBan;

  /// No description provided for @bqlNhapMatKhauHienTai.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu hiện tại'**
  String get bqlNhapMatKhauHienTai;

  /// No description provided for @bqlXacNhan.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get bqlXacNhan;

  /// No description provided for @bqlHayChonMotMatKhauAnToanChiMinhBanBiet.
  ///
  /// In vi, this message translates to:
  /// **'Hay chọn một mật khẩu an toàn chỉ mình bạn biết'**
  String get bqlHayChonMotMatKhauAnToanChiMinhBanBiet;

  /// No description provided for @bqlNhapMatKhauMoi.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới'**
  String get bqlNhapMatKhauMoi;

  /// No description provided for @bqlNhapLaiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get bqlNhapLaiMatKhau;

  /// No description provided for @bqlDoiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu'**
  String get bqlDoiMatKhau;

  /// No description provided for @bqlNguyenThuHuong.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thu Hương '**
  String get bqlNguyenThuHuong;

  /// No description provided for @bqlAbcxyzgmailcom.
  ///
  /// In vi, this message translates to:
  /// **'Abcxyz@gmail.com'**
  String get bqlAbcxyzgmailcom;

  /// No description provided for @bqlChinhSuaThongTinThanhVien.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin thành viên'**
  String get bqlChinhSuaThongTinThanhVien;

  /// No description provided for @bqlThemThanhVien.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thành viên'**
  String get bqlThemThanhVien;

  /// No description provided for @bqlThongTinTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản'**
  String get bqlThongTinTaiKhoan;

  /// No description provided for @bqlChucVu.
  ///
  /// In vi, this message translates to:
  /// **'Chức vụ'**
  String get bqlChucVu;

  /// No description provided for @bqlSoHieu.
  ///
  /// In vi, this message translates to:
  /// **'Số hiệu'**
  String get bqlSoHieu;

  /// No description provided for @bqlCapNhat.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật'**
  String get bqlCapNhat;

  /// No description provided for @bqlHome.
  ///
  /// In vi, this message translates to:
  /// **'Home'**
  String get bqlHome;

  /// No description provided for @bqlDangXuat.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get bqlDangXuat;

  /// No description provided for @bqlXeMay.
  ///
  /// In vi, this message translates to:
  /// **'Xe máy'**
  String get bqlXeMay;

  /// No description provided for @bqlChuXe1.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe'**
  String get bqlChuXe1;

  /// No description provided for @bqlPhamTuanKhang.
  ///
  /// In vi, this message translates to:
  /// **'PHẠM TUẤN KHANG'**
  String get bqlPhamTuanKhang;

  /// No description provided for @bql29be01919.
  ///
  /// In vi, this message translates to:
  /// **'29BE-019.19'**
  String get bql29be01919;

  /// No description provided for @bqlLienHe.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ'**
  String get bqlLienHe;

  /// No description provided for @bqlDangKiTu.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí từ'**
  String get bqlDangKiTu;

  /// No description provided for @bqlPhiGui.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi'**
  String get bqlPhiGui;

  /// No description provided for @bqlTaoThongBaoMoi.
  ///
  /// In vi, this message translates to:
  /// **'Tạo thông báo mới'**
  String get bqlTaoThongBaoMoi;

  /// No description provided for @bqlChonToaNha1.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tòa nhà'**
  String get bqlChonToaNha1;

  /// No description provided for @bqlNoiDungThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung thông báo'**
  String get bqlNoiDungThongBao;

  /// No description provided for @bqlSelect.
  ///
  /// In vi, this message translates to:
  /// **'Select...'**
  String get bqlSelect;

  /// No description provided for @bqlChonMuc.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mục'**
  String get bqlChonMuc;

  /// No description provided for @bqlTimKiem.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm...'**
  String get bqlTimKiem;

  /// No description provided for @bqlKhongCoKetQua.
  ///
  /// In vi, this message translates to:
  /// **'Không có kết quả'**
  String get bqlKhongCoKetQua;

  /// No description provided for @bqlHuy.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get bqlHuy;

  /// No description provided for @bqlLuu.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get bqlLuu;

  /// No description provided for @bqlGuiTatCa.
  ///
  /// In vi, this message translates to:
  /// **'Gửi tất cả'**
  String get bqlGuiTatCa;

  /// No description provided for @bqlGuiRieng.
  ///
  /// In vi, this message translates to:
  /// **'Gửi riêng'**
  String get bqlGuiRieng;

  /// No description provided for @bqlChiTietThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thông báo'**
  String get bqlChiTietThongBao;

  /// No description provided for @bqlThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get bqlThongBao;

  /// No description provided for @bqlKhongCoThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Không có thông báo'**
  String get bqlKhongCoThongBao;

  /// No description provided for @bqlDdmmHhmm.
  ///
  /// In vi, this message translates to:
  /// **'dd/MM HH:mm'**
  String get bqlDdmmHhmm;

  /// No description provided for @txtHaDuongHousing.
  ///
  /// In vi, this message translates to:
  /// **'Hà Dương Housing'**
  String get txtHaDuongHousing;

  /// No description provided for @txtXinChaoTheGioi.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào thế giới!'**
  String get txtXinChaoTheGioi;

  /// No description provided for @txtBoQua.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get txtBoQua;

  /// No description provided for @txtDangNhapVoiVaiTroCuDan.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với vai trò cư dân'**
  String get txtDangNhapVoiVaiTroCuDan;

  /// No description provided for @txtDangNhapVoiVaiTroQuanLy.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với vai trò quản lý'**
  String get txtDangNhapVoiVaiTroQuanLy;

  /// No description provided for @txtXinChao.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào!'**
  String get txtXinChao;

  /// No description provided for @txtChaoMungDaTroLaiHayDangNhap.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đã trở lại, hãy đăng nhập'**
  String get txtChaoMungDaTroLaiHayDangNhap;

  /// No description provided for @txtTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get txtTaiKhoan;

  /// No description provided for @txtSoDienThoai.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get txtSoDienThoai;

  /// No description provided for @txtLoiKetNoi.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi kết nối'**
  String get txtLoiKetNoi;

  /// No description provided for @txtKhongTheGuiMaOtpVuiLongThuLai.
  ///
  /// In vi, this message translates to:
  /// **'Không thể gửi mã OTP. Vui lòng thử lại.'**
  String get txtKhongTheGuiMaOtpVuiLongThuLai;

  /// No description provided for @txtSoDienThoaiKhongDungDinhDang.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không đúng định dạng'**
  String get txtSoDienThoaiKhongDungDinhDang;

  /// No description provided for @txtVuiLongKiemTraLaiSoDienThoaiDaNhap.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại số điện thoại đã nhập'**
  String get txtVuiLongKiemTraLaiSoDienThoaiDaNhap;

  /// No description provided for @txtLoi.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi'**
  String get txtLoi;

  /// No description provided for @txtSoDienThoaiCuaBanChuaDangKyCuDan.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại của bạn chưa đăng ký cư dân'**
  String get txtSoDienThoaiCuaBanChuaDangKyCuDan;

  /// No description provided for @txtXacThucThatBai.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực thất bại'**
  String get txtXacThucThatBai;

  /// No description provided for @txtDangNhap.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get txtDangNhap;

  /// No description provided for @txtBanMuonTraiNghiemUngDung.
  ///
  /// In vi, this message translates to:
  /// **'Bạn muốn trải nghiệm ứng dụng?'**
  String get txtBanMuonTraiNghiemUngDung;

  /// No description provided for @txtDeLaiThongTin.
  ///
  /// In vi, this message translates to:
  /// **'Để lại thông tin'**
  String get txtDeLaiThongTin;

  /// No description provided for @txtThayDoiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi mật khẩu'**
  String get txtThayDoiMatKhau;

  /// No description provided for @txtNhapMatKhauMoi.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới'**
  String get txtNhapMatKhauMoi;

  /// No description provided for @txtNhapLaiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get txtNhapLaiMatKhau;

  /// No description provided for @txtDoiMatKhauThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu thành công'**
  String get txtDoiMatKhauThanhCong;

  /// No description provided for @txtDoiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu'**
  String get txtDoiMatKhau;

  /// No description provided for @txtQuenMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu'**
  String get txtQuenMatKhau;

  /// No description provided for @txtHayNhapSdtDaDangKyDeDatLaiMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Hãy nhập SĐT đã đăng ký để đặt lại mật khẩu.'**
  String get txtHayNhapSdtDaDangKyDeDatLaiMatKhau;

  /// No description provided for @txtXacMinhOtp.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh OTP'**
  String get txtXacMinhOtp;

  /// No description provided for @txtMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get txtMatKhau;

  /// No description provided for @txtQuenMatKhau1.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get txtQuenMatKhau1;

  /// No description provided for @txtEmailKhongDungDinhDang.
  ///
  /// In vi, this message translates to:
  /// **'Email không đúng định dạng'**
  String get txtEmailKhongDungDinhDang;

  /// No description provided for @txtVuiLongKiemTraLaiEmailDaNhap.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại email đã nhập'**
  String get txtVuiLongKiemTraLaiEmailDaNhap;

  /// No description provided for @txtDangNhapThatBai.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại'**
  String get txtDangNhapThatBai;

  /// No description provided for @txtVuiLongKiemTraLaiTaiKhoanVaMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại tài khoản và mật khẩu'**
  String get txtVuiLongKiemTraLaiTaiKhoanVaMatKhau;

  /// No description provided for @txtXacThucSdt.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực SĐT'**
  String get txtXacThucSdt;

  /// No description provided for @txtNhapMaOtp.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã OTP'**
  String get txtNhapMaOtp;

  /// No description provided for @txtMaOtpDuocGuiQuaSoDienThoaiDaDangKi.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP được gửi qua số điện thoại đã đăng kí'**
  String get txtMaOtpDuocGuiQuaSoDienThoaiDaDangKi;

  /// No description provided for @txtXacMinh.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh'**
  String get txtXacMinh;

  /// No description provided for @txtXinMoiNhapMaOtp.
  ///
  /// In vi, this message translates to:
  /// **'xin mời nhập mã otp'**
  String get txtXinMoiNhapMaOtp;

  /// No description provided for @txtVuiLongThuLai.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng thử lại'**
  String get txtVuiLongThuLai;

  /// No description provided for @txtDongY.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get txtDongY;

  /// No description provided for @txtDaCoLoiXayRaVuiLongThuLai.
  ///
  /// In vi, this message translates to:
  /// **'Đã có lỗi xảy ra, vui lòng thử lại.'**
  String get txtDaCoLoiXayRaVuiLongThuLai;

  /// No description provided for @txtMaOtpKhongChinhXac.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP không chính xác.'**
  String get txtMaOtpKhongChinhXac;

  /// No description provided for @txtMaOtpDaHetHanVuiLongYeuCauMaMoi.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP đã hết hạn, vui lòng yêu cầu mã mới.'**
  String get txtMaOtpDaHetHanVuiLongYeuCauMaMoi;

  /// No description provided for @txtLoiXacThuc.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi xác thực'**
  String get txtLoiXacThuc;

  /// No description provided for @txtGuiThongTinDangKyThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Gửi thông tin đăng ký thành công'**
  String get txtGuiThongTinDangKyThanhCong;

  /// No description provided for @txtYayBanDaGuiThongTinDangKyTraiNghiemUngDungThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Yay! Bạn đã gửi thông tin đăng ký trải nghiệm ứng dụng thành công.'**
  String get txtYayBanDaGuiThongTinDangKyTraiNghiemUngDungThanhCong;

  /// No description provided for @txtQuayVeDangNhap.
  ///
  /// In vi, this message translates to:
  /// **'Quay về đăng nhập'**
  String get txtQuayVeDangNhap;

  /// No description provided for @txtThongTinCuaBan.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin của bạn'**
  String get txtThongTinCuaBan;

  /// No description provided for @txtDangKyDeTraiNghiemUngDung.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký để trải nghiệm ứng dụng!'**
  String get txtDangKyDeTraiNghiemUngDung;

  /// No description provided for @txtHoVaTen.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get txtHoVaTen;

  /// No description provided for @txtNoiDungGhiChu.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung ghi chú'**
  String get txtNoiDungGhiChu;

  /// No description provided for @txtGuiThongTin.
  ///
  /// In vi, this message translates to:
  /// **'Gửi thông tin'**
  String get txtGuiThongTin;

  /// No description provided for @txtHoaDon.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn'**
  String get txtHoaDon;

  /// No description provided for @txtLichSuThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử thanh toán'**
  String get txtLichSuThanhToan;

  /// No description provided for @txtKhongCoHoaDonChoThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Không có hoá đơn chờ thanh toán'**
  String get txtKhongCoHoaDonChoThanhToan;

  /// No description provided for @txtKhongCoLichSuThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Không có lịch sử thanh toán'**
  String get txtKhongCoLichSuThanhToan;

  /// No description provided for @txtDaThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Đã thanh toán'**
  String get txtDaThanhToan;

  /// No description provided for @txtHanThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán:'**
  String get txtHanThanhToan;

  /// No description provided for @txtChiTietHoaDon.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết hoá đơn'**
  String get txtChiTietHoaDon;

  /// No description provided for @txtTenKhachHang.
  ///
  /// In vi, this message translates to:
  /// **'Tên khách hàng:'**
  String get txtTenKhachHang;

  /// No description provided for @txtKyHoaDon.
  ///
  /// In vi, this message translates to:
  /// **'Kỳ hoá đơn:'**
  String get txtKyHoaDon;

  /// No description provided for @txtHoaDonDien.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn điện'**
  String get txtHoaDonDien;

  /// No description provided for @txt298700D.
  ///
  /// In vi, this message translates to:
  /// **'298.700 đ'**
  String get txt298700D;

  /// No description provided for @txtHoaDonGuiXe.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn gửi xe'**
  String get txtHoaDonGuiXe;

  /// No description provided for @txtChuXe.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe:'**
  String get txtChuXe;

  /// No description provided for @txtSoDienThoai1.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại:'**
  String get txtSoDienThoai1;

  /// No description provided for @txtTenPhuongTien.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện:'**
  String get txtTenPhuongTien;

  /// No description provided for @txtPhi.
  ///
  /// In vi, this message translates to:
  /// **'Phí:'**
  String get txtPhi;

  /// No description provided for @txtBienSo.
  ///
  /// In vi, this message translates to:
  /// **'Biển số:'**
  String get txtBienSo;

  /// No description provided for @txtPhiToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Phí toà nhà'**
  String get txtPhiToaNha;

  /// No description provided for @txtDienTich.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích:'**
  String get txtDienTich;

  /// No description provided for @txtPhiThuThem.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thêm:'**
  String get txtPhiThuThem;

  /// No description provided for @txtPhiBaoTri.
  ///
  /// In vi, this message translates to:
  /// **'Phí bảo trì:'**
  String get txtPhiBaoTri;

  /// No description provided for @txtTienDien.
  ///
  /// In vi, this message translates to:
  /// **'Tiền điện:'**
  String get txtTienDien;

  /// No description provided for @txtTienNuoc.
  ///
  /// In vi, this message translates to:
  /// **'Tiền nước:'**
  String get txtTienNuoc;

  /// No description provided for @txtHanThanhToan1.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán'**
  String get txtHanThanhToan1;

  /// No description provided for @txtTongPhi.
  ///
  /// In vi, this message translates to:
  /// **'Tổng Phí'**
  String get txtTongPhi;

  /// No description provided for @txtPhiNo.
  ///
  /// In vi, this message translates to:
  /// **'Phí Nợ'**
  String get txtPhiNo;

  /// No description provided for @txtPhiDaThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Phí đã thanh toán'**
  String get txtPhiDaThanhToan;

  /// No description provided for @txtPhiThuThua.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thừa'**
  String get txtPhiThuThua;

  /// No description provided for @txtPhiThanhToanThucTe.
  ///
  /// In vi, this message translates to:
  /// **'Phí thanh toán thực tế'**
  String get txtPhiThanhToanThucTe;

  /// No description provided for @txtThanhToanNgay.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán ngay'**
  String get txtThanhToanNgay;

  /// No description provided for @txtHoaDonHangThang.
  ///
  /// In vi, this message translates to:
  /// **'Hoá đơn hàng tháng'**
  String get txtHoaDonHangThang;

  /// No description provided for @txtTongPhi1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phí:'**
  String get txtTongPhi1;

  /// No description provided for @txtThang.
  ///
  /// In vi, this message translates to:
  /// **'Tháng:'**
  String get txtThang;

  /// No description provided for @txtTinhTrang.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng:'**
  String get txtTinhTrang;

  /// No description provided for @txtChuaThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Chưa thanh toán'**
  String get txtChuaThanhToan;

  /// No description provided for @txtSoSuDung.
  ///
  /// In vi, this message translates to:
  /// **'Số sử dụng:'**
  String get txtSoSuDung;

  /// No description provided for @txtSoKyDau.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ đầu:'**
  String get txtSoKyDau;

  /// No description provided for @txtSoKyCuoi.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ cuối:'**
  String get txtSoKyCuoi;

  /// No description provided for @txtDonViTinh.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tính:'**
  String get txtDonViTinh;

  /// No description provided for @txtChiTietSoSuDung.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết số sử dụng:'**
  String get txtChiTietSoSuDung;

  /// No description provided for @txtTu150KwhXGia1950D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 1-50 KWh) x giá 1.950 đ:'**
  String get txtTu150KwhXGia1950D;

  /// No description provided for @txtTu51100KwhXGia2015D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 51-100 KWh) x giá 2.015 đ:'**
  String get txtTu51100KwhXGia2015D;

  /// No description provided for @txtTu101200KwhXGia2340D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 101-200 KWh) x giá 2.340 đ:'**
  String get txtTu101200KwhXGia2340D;

  /// No description provided for @txtTu201300KwhXGia2947D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 201-300 KWh) x giá 2.947 đ:'**
  String get txtTu201300KwhXGia2947D;

  /// No description provided for @txtTu301400KwhXGia3294D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 301-400 KWh) x giá 3.294 đ:'**
  String get txtTu301400KwhXGia3294D;

  /// No description provided for @txtTu400KwhTroLenXGia3403D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 400 KWh trở lên) x giá 3.403 đ:'**
  String get txtTu400KwhTroLenXGia3403D;

  /// No description provided for @txtTongTien.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền:'**
  String get txtTongTien;

  /// No description provided for @txtBienSo1.
  ///
  /// In vi, this message translates to:
  /// **'Biến số:'**
  String get txtBienSo1;

  /// No description provided for @txtTu110M3XGia9775D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 1-10 m3) x giá 9.775 đ:'**
  String get txtTu110M3XGia9775D;

  /// No description provided for @txtTu1120M3XGia11385D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 11-20 m3) x giá 11.385 đ:'**
  String get txtTu1120M3XGia11385D;

  /// No description provided for @txtTu2130M3XGia18400D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 21-30 m3) x giá 18.400 đ:'**
  String get txtTu2130M3XGia18400D;

  /// No description provided for @txtTu31M3TroLenXGia31050D.
  ///
  /// In vi, this message translates to:
  /// **'(Từ 31 m3 trở lên) x giá 31.050 đ:'**
  String get txtTu31M3TroLenXGia31050D;

  /// No description provided for @txtChiTiet.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết'**
  String get txtChiTiet;

  /// No description provided for @txtThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán'**
  String get txtThanhToan;

  /// No description provided for @txtCuDanVuiLongThanhToanHoaDonTheoMaQrDuoiDay.
  ///
  /// In vi, this message translates to:
  /// **'Cư dân vui lòng thanh toán hóa đơn theo mã QR dưới đây:'**
  String get txtCuDanVuiLongThanhToanHoaDonTheoMaQrDuoiDay;

  /// No description provided for @txtSoTien.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền'**
  String get txtSoTien;

  /// No description provided for @txtNoiDungChuyenKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung chuyển khoản'**
  String get txtNoiDungChuyenKhoan;

  /// No description provided for @txtChupVaLuuMaQr.
  ///
  /// In vi, this message translates to:
  /// **'Chụp và lưu mã QR'**
  String get txtChupVaLuuMaQr;

  /// No description provided for @txtMaQrDaLuu.
  ///
  /// In vi, this message translates to:
  /// **'Mã Qr đã lưu'**
  String get txtMaQrDaLuu;

  /// No description provided for @txtDaSaoChep.
  ///
  /// In vi, this message translates to:
  /// **'Đã sao chép!'**
  String get txtDaSaoChep;

  /// No description provided for @txtQuyenTruyCapThuVienAnhBiTuChoi.
  ///
  /// In vi, this message translates to:
  /// **'Quyền truy cập thư viện ảnh bị từ chối.'**
  String get txtQuyenTruyCapThuVienAnhBiTuChoi;

  /// No description provided for @txtKhongTheChupAnhWidget.
  ///
  /// In vi, this message translates to:
  /// **'Không thể chụp ảnh widget.'**
  String get txtKhongTheChupAnhWidget;

  /// No description provided for @txtTrangChu.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get txtTrangChu;

  /// No description provided for @txtHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ'**
  String get txtHoTro;

  /// No description provided for @txtTienIch.
  ///
  /// In vi, this message translates to:
  /// **'Tiện ích'**
  String get txtTienIch;

  /// No description provided for @txtNhuThat.
  ///
  /// In vi, this message translates to:
  /// **'Như Thật'**
  String get txtNhuThat;

  /// No description provided for @txtYeuCauHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu hỗ trợ'**
  String get txtYeuCauHoTro;

  /// No description provided for @txtNhungYeuCauPhanAnhCuaCuDanSeDuocCapNhatTaiDay.
  ///
  /// In vi, this message translates to:
  /// **'Những yêu cầu, phản ánh của cư dân sẽ được cập nhật tại đây!'**
  String get txtNhungYeuCauPhanAnhCuaCuDanSeDuocCapNhatTaiDay;

  /// No description provided for @txtHoTroPhanAnh.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ / Phản ánh'**
  String get txtHoTroPhanAnh;

  /// No description provided for @txtThayDoiThongTin.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi thông tin'**
  String get txtThayDoiThongTin;

  /// No description provided for @txtDanhSachDangKyTienIch.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách đăng ký tiện ích'**
  String get txtDanhSachDangKyTienIch;

  /// No description provided for @txtCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ'**
  String get txtCanHo;

  /// No description provided for @txtDiennuoc.
  ///
  /// In vi, this message translates to:
  /// **'Điện/Nước'**
  String get txtDiennuoc;

  /// No description provided for @txtThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get txtThongBao;

  /// No description provided for @txtYeuCauThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu thanh toán'**
  String get txtYeuCauThanhToan;

  /// No description provided for @txtKhongCoYeuCauThanhToanNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có yêu cầu thanh toán nào'**
  String get txtKhongCoYeuCauThanhToanNao;

  /// No description provided for @txtBangTinToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin toà nhà'**
  String get txtBangTinToaNha;

  /// No description provided for @txtHoSoCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ căn hộ'**
  String get txtHoSoCanHo;

  /// No description provided for @txtThongTinCuTru.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cư trú'**
  String get txtThongTinCuTru;

  /// No description provided for @txtChuHo.
  ///
  /// In vi, this message translates to:
  /// **'Chủ hộ'**
  String get txtChuHo;

  /// No description provided for @txtSoDinhDanh.
  ///
  /// In vi, this message translates to:
  /// **'Số định danh'**
  String get txtSoDinhDanh;

  /// No description provided for @txtNgaySinh.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get txtNgaySinh;

  /// No description provided for @txtChinhSuaThongTinChuHo.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin Chủ hộ'**
  String get txtChinhSuaThongTinChuHo;

  /// No description provided for @txtThongTinCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin căn hộ'**
  String get txtThongTinCanHo;

  /// No description provided for @txtSoNha.
  ///
  /// In vi, this message translates to:
  /// **'Số nhà'**
  String get txtSoNha;

  /// No description provided for @txtTang.
  ///
  /// In vi, this message translates to:
  /// **'Tầng'**
  String get txtTang;

  /// No description provided for @txtDienTichMatSan.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích mặt sàn'**
  String get txtDienTichMatSan;

  /// No description provided for @txtTinhTrang1.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng'**
  String get txtTinhTrang1;

  /// No description provided for @txtThanhVienTrongHoGiaDinh.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên trong hộ gia đình'**
  String get txtThanhVienTrongHoGiaDinh;

  /// No description provided for @txtBayGioHayNhapMatKhauHienTaiCuaBan.
  ///
  /// In vi, this message translates to:
  /// **'Bây giờ hãy nhập mật khẩu hiện tại của bạn'**
  String get txtBayGioHayNhapMatKhauHienTaiCuaBan;

  /// No description provided for @txtNhapMatKhauHienTai.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu hiện tại'**
  String get txtNhapMatKhauHienTai;

  /// No description provided for @txtXacNhan.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get txtXacNhan;

  /// No description provided for @txtHayChonMotMatKhauAnToanChiMinhBanBiet.
  ///
  /// In vi, this message translates to:
  /// **'Hay chọn một mật khẩu an toàn chỉ mình bạn biết'**
  String get txtHayChonMotMatKhauAnToanChiMinhBanBiet;

  /// No description provided for @txtThemThanhVien.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thành viên'**
  String get txtThemThanhVien;

  /// No description provided for @txtQuanHeVoiChuHo.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ với chủ hộ'**
  String get txtQuanHeVoiChuHo;

  /// No description provided for @txtChinhSuaThongTinThanhVien.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin thành viên'**
  String get txtChinhSuaThongTinThanhVien;

  /// No description provided for @txtVochong.
  ///
  /// In vi, this message translates to:
  /// **'Vợ/Chồng'**
  String get txtVochong;

  /// No description provided for @txtConCai.
  ///
  /// In vi, this message translates to:
  /// **'Con cái'**
  String get txtConCai;

  /// No description provided for @txtBome.
  ///
  /// In vi, this message translates to:
  /// **'Bố/Mẹ'**
  String get txtBome;

  /// No description provided for @txtAnhchiem.
  ///
  /// In vi, this message translates to:
  /// **'Anh/Chị/Em'**
  String get txtAnhchiem;

  /// No description provided for @txtKhachThue.
  ///
  /// In vi, this message translates to:
  /// **'Khách thuê'**
  String get txtKhachThue;

  /// No description provided for @txtThongTinTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản'**
  String get txtThongTinTaiKhoan;

  /// No description provided for @txtNguyenTheHoang.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thế Hoàng'**
  String get txtNguyenTheHoang;

  /// No description provided for @txtTaiAnhLen.
  ///
  /// In vi, this message translates to:
  /// **'Tải ảnh lên'**
  String get txtTaiAnhLen;

  /// No description provided for @txtChupAnh.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh'**
  String get txtChupAnh;

  /// No description provided for @txtCoLoiXayRaThuLaiSau.
  ///
  /// In vi, this message translates to:
  /// **'Có lỗi xảy ra, thử lại sau'**
  String get txtCoLoiXayRaThuLaiSau;

  /// No description provided for @txtPhuongTienDangKy.
  ///
  /// In vi, this message translates to:
  /// **'Phương tiện đăng ký'**
  String get txtPhuongTienDangKy;

  /// No description provided for @txtBanCoChacChanMuonXoaTaiKhoanCuaMinh.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa tài khoản của mình?'**
  String get txtBanCoChacChanMuonXoaTaiKhoanCuaMinh;

  /// No description provided for @txtHuy.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get txtHuy;

  /// No description provided for @txtXoa.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get txtXoa;

  /// No description provided for @txtXoaTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Xóa tài khoản'**
  String get txtXoaTaiKhoan;

  /// No description provided for @txtDangXuat.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get txtDangXuat;

  /// No description provided for @txtBanChacChanMuonDangXuat.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chắc chắn muốn đăng xuất?'**
  String get txtBanChacChanMuonDangXuat;

  /// No description provided for @txtChuaCapNhat.
  ///
  /// In vi, this message translates to:
  /// **'Chưa cập nhật'**
  String get txtChuaCapNhat;

  /// No description provided for @txtChuXe1.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe'**
  String get txtChuXe1;

  /// No description provided for @txtChuSoHuu.
  ///
  /// In vi, this message translates to:
  /// **'Chủ sở hữu'**
  String get txtChuSoHuu;

  /// No description provided for @txtBienSoXe.
  ///
  /// In vi, this message translates to:
  /// **'Biển số xe'**
  String get txtBienSoXe;

  /// No description provided for @txtLienHe.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ'**
  String get txtLienHe;

  /// No description provided for @txtDangKiTu.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí từ'**
  String get txtDangKiTu;

  /// No description provided for @txtPhiGui.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi'**
  String get txtPhiGui;

  /// No description provided for @txtDichVuTienIch.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ tiện ích'**
  String get txtDichVuTienIch;

  /// No description provided for @txtKhongCoDuLieu.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get txtKhongCoDuLieu;

  /// No description provided for @txtMoTaDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả dịch vụ'**
  String get txtMoTaDichVu;

  /// No description provided for @txtDangKyDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký dịch vụ'**
  String get txtDangKyDichVu;

  /// No description provided for @txtYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu'**
  String get txtYeuCau;

  /// No description provided for @txtDangXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Đang xử lý'**
  String get txtDangXuLy;

  /// No description provided for @txtHoanTat.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get txtHoanTat;

  /// No description provided for @txtKhongCoYeuCauDaHoanTat.
  ///
  /// In vi, this message translates to:
  /// **'Không có yêu cầu đã hoàn tất'**
  String get txtKhongCoYeuCauDaHoanTat;

  /// No description provided for @txtTrangThai.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get txtTrangThai;

  /// No description provided for @txtChuaXuLy.
  ///
  /// In vi, this message translates to:
  /// **'chưa xử lý'**
  String get txtChuaXuLy;

  /// No description provided for @txtTrangThaiYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái yêu cầu'**
  String get txtTrangThaiYeuCau;

  /// No description provided for @txtTienTrinhXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Tiến trình xử lý:'**
  String get txtTienTrinhXuLy;

  /// No description provided for @txtTaoYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Tạo yêu cầu'**
  String get txtTaoYeuCau;

  /// No description provided for @txtYeuCau1.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu :'**
  String get txtYeuCau1;

  /// No description provided for @txtTinhTrang2.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng :'**
  String get txtTinhTrang2;

  /// No description provided for @txtDanhSachHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách hỗ trợ'**
  String get txtDanhSachHoTro;

  /// No description provided for @txtXemThem.
  ///
  /// In vi, this message translates to:
  /// **'Xem thêm ...'**
  String get txtXemThem;

  /// No description provided for @txtChuaXuLy1.
  ///
  /// In vi, this message translates to:
  /// **'Chưa xử lý'**
  String get txtChuaXuLy1;

  /// No description provided for @txtTinhTrangCuaQuyKhach.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng của quý khách'**
  String get txtTinhTrangCuaQuyKhach;

  /// No description provided for @txtVuiLongChonTinhTrang.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn tình trạng'**
  String get txtVuiLongChonTinhTrang;

  /// No description provided for @txtThongTinKhachHang.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin khách hàng'**
  String get txtThongTinKhachHang;

  /// No description provided for @txtNguoiLienHe.
  ///
  /// In vi, this message translates to:
  /// **'Người liên hệ'**
  String get txtNguoiLienHe;

  /// No description provided for @txtGhiChu.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get txtGhiChu;

  /// No description provided for @txtNhapGhiChu.
  ///
  /// In vi, this message translates to:
  /// **'Nhập ghi chú'**
  String get txtNhapGhiChu;

  /// No description provided for @txtBatBuocNhap.
  ///
  /// In vi, this message translates to:
  /// **'Bắt buộc nhập'**
  String get txtBatBuocNhap;

  /// No description provided for @txtThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get txtThanhCong;

  /// No description provided for @txtYeuCauDaDuocGui.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu đã được gửi!'**
  String get txtYeuCauDaDuocGui;

  /// No description provided for @txtThatBai.
  ///
  /// In vi, this message translates to:
  /// **'Thất bại'**
  String get txtThatBai;

  /// No description provided for @txtGuiYeuCauThatBai.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu thất bại!'**
  String get txtGuiYeuCauThatBai;

  /// No description provided for @txtThuLai.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get txtThuLai;

  /// No description provided for @txtGuiYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu'**
  String get txtGuiYeuCau;

  /// No description provided for @txtTimKiemTenCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên căn hộ'**
  String get txtTimKiemTenCanHo;

  /// No description provided for @txtChonToaNha.
  ///
  /// In vi, this message translates to:
  /// **'Chọn toà nhà'**
  String get txtChonToaNha;

  /// No description provided for @txtChonTrangThai.
  ///
  /// In vi, this message translates to:
  /// **'Chọn trạng thái'**
  String get txtChonTrangThai;

  /// No description provided for @txtKhongCoCanHoNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có căn hộ nào'**
  String get txtKhongCoCanHoNao;

  /// No description provided for @txtCuDan.
  ///
  /// In vi, this message translates to:
  /// **'Cư dân'**
  String get txtCuDan;

  /// No description provided for @txtPhuongTien.
  ///
  /// In vi, this message translates to:
  /// **'Phương tiện'**
  String get txtPhuongTien;

  /// No description provided for @txtPhiDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Phí dịch vụ'**
  String get txtPhiDichVu;

  /// No description provided for @txtBienLai.
  ///
  /// In vi, this message translates to:
  /// **'Biên lai'**
  String get txtBienLai;

  /// No description provided for @txtTenCanHo.
  ///
  /// In vi, this message translates to:
  /// **'Tên căn hộ'**
  String get txtTenCanHo;

  /// No description provided for @txtTang6.
  ///
  /// In vi, this message translates to:
  /// **'Tầng 6'**
  String get txtTang6;

  /// No description provided for @txtDangO.
  ///
  /// In vi, this message translates to:
  /// **'Đang ở'**
  String get txtDangO;

  /// No description provided for @txtHoDan.
  ///
  /// In vi, this message translates to:
  /// **'Hộ dân'**
  String get txtHoDan;

  /// No description provided for @txtHoTen.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên'**
  String get txtHoTen;

  /// No description provided for @txtQuanHe.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ'**
  String get txtQuanHe;

  /// No description provided for @txtKhongCoPhuongTienNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có phương tiện nào'**
  String get txtKhongCoPhuongTienNao;

  /// No description provided for @txtTenPhuongTien1.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện'**
  String get txtTenPhuongTien1;

  /// No description provided for @txtPhiGuiXe.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi xe'**
  String get txtPhiGuiXe;

  /// No description provided for @txtKhongCoPhiDichVuNao.
  ///
  /// In vi, this message translates to:
  /// **'Không có phí dịch vụ nào'**
  String get txtKhongCoPhiDichVuNao;

  /// No description provided for @txtChuaCoSmsNao.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có SMS nào'**
  String get txtChuaCoSmsNao;

  /// No description provided for @txtNoiDung.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung'**
  String get txtNoiDung;

  /// No description provided for @txtLoaiTin.
  ///
  /// In vi, this message translates to:
  /// **'Loại tin'**
  String get txtLoaiTin;

  /// No description provided for @txtNguoiGui.
  ///
  /// In vi, this message translates to:
  /// **'Người gửi'**
  String get txtNguoiGui;

  /// No description provided for @txtChuaCoBienLaiNao.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có biên lai nào'**
  String get txtChuaCoBienLaiNao;

  /// No description provided for @txtChiTietPhieuThu.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết phiếu thu'**
  String get txtChiTietPhieuThu;

  /// No description provided for @txtPhong.
  ///
  /// In vi, this message translates to:
  /// **'Phòng'**
  String get txtPhong;

  /// No description provided for @txtTongTien1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền'**
  String get txtTongTien1;

  /// No description provided for @txtTongPhi2.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phí: '**
  String get txtTongPhi2;

  /// No description provided for @txtThang1.
  ///
  /// In vi, this message translates to:
  /// **'Tháng: '**
  String get txtThang1;

  /// No description provided for @txtTinhTrang3.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng: '**
  String get txtTinhTrang3;

  /// No description provided for @txtChonThang.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tháng'**
  String get txtChonThang;

  /// No description provided for @txtTuChoiYeuCau.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối yêu cầu'**
  String get txtTuChoiYeuCau;

  /// No description provided for @txtAnhXacMinhThongTin.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh xác minh thông tin'**
  String get txtAnhXacMinhThongTin;

  /// No description provided for @txtVo.
  ///
  /// In vi, this message translates to:
  /// **'Vợ'**
  String get txtVo;

  /// No description provided for @txtChong.
  ///
  /// In vi, this message translates to:
  /// **'Chồng'**
  String get txtChong;

  /// No description provided for @txtBangTin.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin'**
  String get txtBangTin;

  /// No description provided for @txtXinChao1.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào,'**
  String get txtXinChao1;

  /// No description provided for @txtBanCo.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có '**
  String get txtBanCo;

  /// No description provided for @txtHoTroMoiTrongNgay.
  ///
  /// In vi, this message translates to:
  /// **' hỗ trợ mới trong ngày'**
  String get txtHoTroMoiTrongNgay;

  /// No description provided for @txtXemTatCa.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả >'**
  String get txtXemTatCa;

  /// No description provided for @txtTinhTrang4.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng : '**
  String get txtTinhTrang4;

  /// No description provided for @txtDichVu.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ'**
  String get txtDichVu;

  /// No description provided for @txtThoiGian.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get txtThoiGian;

  /// No description provided for @txtChupAnhThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh thành công'**
  String get txtChupAnhThanhCong;

  /// No description provided for @txtChiTietYeuCauHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết yêu cầu hỗ trợ'**
  String get txtChiTietYeuCauHoTro;

  /// No description provided for @txtThemHinhAnh.
  ///
  /// In vi, this message translates to:
  /// **'Thêm hình ảnh'**
  String get txtThemHinhAnh;

  /// No description provided for @txtThemNote.
  ///
  /// In vi, this message translates to:
  /// **'Thêm note'**
  String get txtThemNote;

  /// No description provided for @txtNhapTinhTrangXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tình trạng xử lý'**
  String get txtNhapTinhTrangXuLy;

  /// No description provided for @txtCapNhatThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thành công'**
  String get txtCapNhatThanhCong;

  /// No description provided for @txtVuiLongChonTrangThaiXuLy.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn trạng thái xử lý'**
  String get txtVuiLongChonTrangThaiXuLy;

  /// No description provided for @txtNguyenThuHuong.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thu Hương '**
  String get txtNguyenThuHuong;

  /// No description provided for @txtChucVu.
  ///
  /// In vi, this message translates to:
  /// **'Chức vụ'**
  String get txtChucVu;

  /// No description provided for @txtSoHieu.
  ///
  /// In vi, this message translates to:
  /// **'Số hiệu'**
  String get txtSoHieu;

  /// No description provided for @txtCapNhat.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật'**
  String get txtCapNhat;

  /// No description provided for @txtXeMay.
  ///
  /// In vi, this message translates to:
  /// **'Xe máy'**
  String get txtXeMay;

  /// No description provided for @txtTaoThongBaoMoi.
  ///
  /// In vi, this message translates to:
  /// **'Tạo thông báo mới'**
  String get txtTaoThongBaoMoi;

  /// No description provided for @txtChonToaNha1.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tòa nhà'**
  String get txtChonToaNha1;

  /// No description provided for @txtNoiDungThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung thông báo'**
  String get txtNoiDungThongBao;

  /// No description provided for @txtChonMuc.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mục'**
  String get txtChonMuc;

  /// No description provided for @txtTimKiem.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm...'**
  String get txtTimKiem;

  /// No description provided for @txtKhongCoKetQua.
  ///
  /// In vi, this message translates to:
  /// **'Không có kết quả'**
  String get txtKhongCoKetQua;

  /// No description provided for @txtLuu.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get txtLuu;

  /// No description provided for @txtGuiTatCa.
  ///
  /// In vi, this message translates to:
  /// **'Gửi tất cả'**
  String get txtGuiTatCa;

  /// No description provided for @txtGuiRieng.
  ///
  /// In vi, this message translates to:
  /// **'Gửi riêng'**
  String get txtGuiRieng;

  /// No description provided for @txtChiTietThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thông báo'**
  String get txtChiTietThongBao;

  /// No description provided for @txtKhongCoThongBao.
  ///
  /// In vi, this message translates to:
  /// **'Không có thông báo'**
  String get txtKhongCoThongBao;

  /// No description provided for @txtHelloWorld.
  ///
  /// In vi, this message translates to:
  /// **'Hello World!'**
  String get txtHelloWorld;

  /// No description provided for @txtLoginAsResident.
  ///
  /// In vi, this message translates to:
  /// **'Login as resident'**
  String get txtLoginAsResident;

  /// No description provided for @txtLoginAsManager.
  ///
  /// In vi, this message translates to:
  /// **'Login as manager'**
  String get txtLoginAsManager;

  /// No description provided for @txtWelcomeBackPleaseLogin.
  ///
  /// In vi, this message translates to:
  /// **'Welcome back, please login'**
  String get txtWelcomeBackPleaseLogin;

  /// No description provided for @txtPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Phone number'**
  String get txtPhoneNumber;

  /// No description provided for @txtConnectionError.
  ///
  /// In vi, this message translates to:
  /// **'Connection error'**
  String get txtConnectionError;

  /// No description provided for @txtCannotSendOtpPleaseTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Cannot send OTP. Please try again.'**
  String get txtCannotSendOtpPleaseTryAgain;

  /// No description provided for @txtInvalidPhoneNumberFormat.
  ///
  /// In vi, this message translates to:
  /// **'Invalid phone number format'**
  String get txtInvalidPhoneNumberFormat;

  /// No description provided for @txtPleaseCheckThePhoneNumberEntered.
  ///
  /// In vi, this message translates to:
  /// **'Please check the phone number entered'**
  String get txtPleaseCheckThePhoneNumberEntered;

  /// No description provided for @txtYourPhoneNumberIsNotRegisteredAsAResident.
  ///
  /// In vi, this message translates to:
  /// **'Your phone number is not registered as a resident'**
  String get txtYourPhoneNumberIsNotRegisteredAsAResident;

  /// No description provided for @txtAuthenticationFailed.
  ///
  /// In vi, this message translates to:
  /// **'Authentication failed'**
  String get txtAuthenticationFailed;

  /// No description provided for @txtWantToExperienceTheApp.
  ///
  /// In vi, this message translates to:
  /// **'Want to experience the app?'**
  String get txtWantToExperienceTheApp;

  /// No description provided for @txtLeaveInformation.
  ///
  /// In vi, this message translates to:
  /// **'Leave information'**
  String get txtLeaveInformation;

  /// No description provided for @txtChangePassword.
  ///
  /// In vi, this message translates to:
  /// **'Change password'**
  String get txtChangePassword;

  /// No description provided for @txtEnterNewPassword.
  ///
  /// In vi, this message translates to:
  /// **'Enter new password'**
  String get txtEnterNewPassword;

  /// No description provided for @txtPasswordChangedSuccessfully.
  ///
  /// In vi, this message translates to:
  /// **'Password changed successfully'**
  String get txtPasswordChangedSuccessfully;

  /// No description provided for @txtForgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Forgot password'**
  String get txtForgotPassword;

  /// No description provided for @txtPleaseEnterRegisteredPhoneNumberToResetPassword.
  ///
  /// In vi, this message translates to:
  /// **'Please enter registered phone number to reset password.'**
  String get txtPleaseEnterRegisteredPhoneNumberToResetPassword;

  /// No description provided for @txtVerifyOtp.
  ///
  /// In vi, this message translates to:
  /// **'Verify OTP'**
  String get txtVerifyOtp;

  /// No description provided for @txtForgotPassword1.
  ///
  /// In vi, this message translates to:
  /// **'Forgot password?'**
  String get txtForgotPassword1;

  /// No description provided for @txtInvalidEmailFormat.
  ///
  /// In vi, this message translates to:
  /// **'Invalid email format'**
  String get txtInvalidEmailFormat;

  /// No description provided for @txtPleaseCheckTheEnteredEmail.
  ///
  /// In vi, this message translates to:
  /// **'Please check the entered email'**
  String get txtPleaseCheckTheEnteredEmail;

  /// No description provided for @txtLoginFailed.
  ///
  /// In vi, this message translates to:
  /// **'Login failed'**
  String get txtLoginFailed;

  /// No description provided for @txtPleaseCheckYourAccountAndPassword.
  ///
  /// In vi, this message translates to:
  /// **'Please check your account and password'**
  String get txtPleaseCheckYourAccountAndPassword;

  /// No description provided for @txtVerifyPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Verify phone number'**
  String get txtVerifyPhoneNumber;

  /// No description provided for @txtEnterOtp.
  ///
  /// In vi, this message translates to:
  /// **'Enter OTP'**
  String get txtEnterOtp;

  /// No description provided for @txtPleaseEnterOtpCode.
  ///
  /// In vi, this message translates to:
  /// **'Please enter OTP code'**
  String get txtPleaseEnterOtpCode;

  /// No description provided for @txtPleaseTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Please try again'**
  String get txtPleaseTryAgain;

  /// No description provided for @txtAnErrorOccurredPleaseTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'An error occurred, please try again.'**
  String get txtAnErrorOccurredPleaseTryAgain;

  /// No description provided for @txtIncorrectOtpCode.
  ///
  /// In vi, this message translates to:
  /// **'Incorrect OTP code.'**
  String get txtIncorrectOtpCode;

  /// No description provided for @txtAuthenticationError.
  ///
  /// In vi, this message translates to:
  /// **'Authentication error'**
  String get txtAuthenticationError;

  /// No description provided for @txtSendRegistrationInfoSuccessfully.
  ///
  /// In vi, this message translates to:
  /// **'Send registration info successfully'**
  String get txtSendRegistrationInfoSuccessfully;

  /// No description provided for @txtBackToLogin.
  ///
  /// In vi, this message translates to:
  /// **'Back to login'**
  String get txtBackToLogin;

  /// No description provided for @txtYourInformation.
  ///
  /// In vi, this message translates to:
  /// **'Your information'**
  String get txtYourInformation;

  /// No description provided for @txtRegisterToExperienceTheApp.
  ///
  /// In vi, this message translates to:
  /// **'Register to experience the app!'**
  String get txtRegisterToExperienceTheApp;

  /// No description provided for @txtFullName.
  ///
  /// In vi, this message translates to:
  /// **'Full name'**
  String get txtFullName;

  /// No description provided for @txtNoteContent.
  ///
  /// In vi, this message translates to:
  /// **'Note content'**
  String get txtNoteContent;

  /// No description provided for @txtSendInformation.
  ///
  /// In vi, this message translates to:
  /// **'Send information'**
  String get txtSendInformation;

  /// No description provided for @txtPaymentHistory.
  ///
  /// In vi, this message translates to:
  /// **'Payment history'**
  String get txtPaymentHistory;

  /// No description provided for @txtNoUnpaidInvoice.
  ///
  /// In vi, this message translates to:
  /// **'No unpaid invoice'**
  String get txtNoUnpaidInvoice;

  /// No description provided for @txtNoPaymentHistory.
  ///
  /// In vi, this message translates to:
  /// **'No payment history'**
  String get txtNoPaymentHistory;

  /// No description provided for @txtInvoiceDetail.
  ///
  /// In vi, this message translates to:
  /// **'Invoice detail'**
  String get txtInvoiceDetail;

  /// No description provided for @txtCustomerName.
  ///
  /// In vi, this message translates to:
  /// **'Customer name:'**
  String get txtCustomerName;

  /// No description provided for @txtInvoicePeriod.
  ///
  /// In vi, this message translates to:
  /// **'Invoice period:'**
  String get txtInvoicePeriod;

  /// No description provided for @txtElectricityInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Electricity invoice'**
  String get txtElectricityInvoice;

  /// No description provided for @txt298700D1.
  ///
  /// In vi, this message translates to:
  /// **'298,700 đ'**
  String get txt298700D1;

  /// No description provided for @txtParkingInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Parking invoice'**
  String get txtParkingInvoice;

  /// No description provided for @txtVehicleOwner.
  ///
  /// In vi, this message translates to:
  /// **'Vehicle owner:'**
  String get txtVehicleOwner;

  /// No description provided for @txtPhoneNumber1.
  ///
  /// In vi, this message translates to:
  /// **'Phone number:'**
  String get txtPhoneNumber1;

  /// No description provided for @txtVehicleName.
  ///
  /// In vi, this message translates to:
  /// **'Vehicle name:'**
  String get txtVehicleName;

  /// No description provided for @txtLicensePlate.
  ///
  /// In vi, this message translates to:
  /// **'License plate:'**
  String get txtLicensePlate;

  /// No description provided for @txtBuildingFee.
  ///
  /// In vi, this message translates to:
  /// **'Building fee'**
  String get txtBuildingFee;

  /// No description provided for @txtAdditionalFee.
  ///
  /// In vi, this message translates to:
  /// **'Additional fee:'**
  String get txtAdditionalFee;

  /// No description provided for @txtMaintenanceFee.
  ///
  /// In vi, this message translates to:
  /// **'Maintenance fee:'**
  String get txtMaintenanceFee;

  /// No description provided for @txtElectricityFee.
  ///
  /// In vi, this message translates to:
  /// **'Electricity fee:'**
  String get txtElectricityFee;

  /// No description provided for @txtWaterFee.
  ///
  /// In vi, this message translates to:
  /// **'Water fee:'**
  String get txtWaterFee;

  /// No description provided for @txtPaymentDeadline.
  ///
  /// In vi, this message translates to:
  /// **'Payment deadline'**
  String get txtPaymentDeadline;

  /// No description provided for @txtTotalFee.
  ///
  /// In vi, this message translates to:
  /// **'Total fee'**
  String get txtTotalFee;

  /// No description provided for @txtDebtFee.
  ///
  /// In vi, this message translates to:
  /// **'Debt fee'**
  String get txtDebtFee;

  /// No description provided for @txtPaidFee.
  ///
  /// In vi, this message translates to:
  /// **'Paid fee'**
  String get txtPaidFee;

  /// No description provided for @txtOverpaidFee.
  ///
  /// In vi, this message translates to:
  /// **'Overpaid fee'**
  String get txtOverpaidFee;

  /// No description provided for @txtActualPaymentFee.
  ///
  /// In vi, this message translates to:
  /// **'Actual payment fee'**
  String get txtActualPaymentFee;

  /// No description provided for @txtPayNow.
  ///
  /// In vi, this message translates to:
  /// **'Pay now'**
  String get txtPayNow;

  /// No description provided for @txtMonthlyInvoice.
  ///
  /// In vi, this message translates to:
  /// **'Monthly invoice'**
  String get txtMonthlyInvoice;

  /// No description provided for @txtTotalFee1.
  ///
  /// In vi, this message translates to:
  /// **'Total fee:'**
  String get txtTotalFee1;

  /// No description provided for @txtUsageAmount.
  ///
  /// In vi, this message translates to:
  /// **'Usage amount:'**
  String get txtUsageAmount;

  /// No description provided for @txtFirstPeriodAmount.
  ///
  /// In vi, this message translates to:
  /// **'First period amount:'**
  String get txtFirstPeriodAmount;

  /// No description provided for @txtLastPeriodAmount.
  ///
  /// In vi, this message translates to:
  /// **'Last period amount:'**
  String get txtLastPeriodAmount;

  /// No description provided for @txtUsageDetail.
  ///
  /// In vi, this message translates to:
  /// **'Usage detail:'**
  String get txtUsageDetail;

  /// No description provided for @txtFrom150KwhX1950D.
  ///
  /// In vi, this message translates to:
  /// **'(From 1-50 KWh) x 1.950 đ:'**
  String get txtFrom150KwhX1950D;

  /// No description provided for @txtFrom51100KwhX2015D.
  ///
  /// In vi, this message translates to:
  /// **'(From 51-100 KWh) x 2.015 đ:'**
  String get txtFrom51100KwhX2015D;

  /// No description provided for @txtFrom101200KwhX2340D.
  ///
  /// In vi, this message translates to:
  /// **'(From 101-200 KWh) x 2.340 đ:'**
  String get txtFrom101200KwhX2340D;

  /// No description provided for @txtFrom201300KwhX2947D.
  ///
  /// In vi, this message translates to:
  /// **'(From 201-300 KWh) x 2.947 đ:'**
  String get txtFrom201300KwhX2947D;

  /// No description provided for @txtFrom301400KwhX3294D.
  ///
  /// In vi, this message translates to:
  /// **'(From 301-400 KWh) x 3.294 đ:'**
  String get txtFrom301400KwhX3294D;

  /// No description provided for @txtFrom400KwhAndAboveX3403D.
  ///
  /// In vi, this message translates to:
  /// **'(From 400 KWh and above) x 3.403 đ:'**
  String get txtFrom400KwhAndAboveX3403D;

  /// No description provided for @txtTotalAmount.
  ///
  /// In vi, this message translates to:
  /// **'Total amount:'**
  String get txtTotalAmount;

  /// No description provided for @txtFrom110M3X9775D.
  ///
  /// In vi, this message translates to:
  /// **'(From 1-10 m3) x 9.775 đ:'**
  String get txtFrom110M3X9775D;

  /// No description provided for @txtFrom1120M3X11385D.
  ///
  /// In vi, this message translates to:
  /// **'(From 11-20 m3) x 11.385 đ:'**
  String get txtFrom1120M3X11385D;

  /// No description provided for @txtFrom2130M3X18400D.
  ///
  /// In vi, this message translates to:
  /// **'(From 21-30 m3) x 18.400 đ:'**
  String get txtFrom2130M3X18400D;

  /// No description provided for @txtFrom31M3AndAboveX31050D.
  ///
  /// In vi, this message translates to:
  /// **'(From 31 m3 and above) x 31.050 đ:'**
  String get txtFrom31M3AndAboveX31050D;

  /// No description provided for @txtResidentsPleasePayTheInvoiceUsingTheQrCodeBelow.
  ///
  /// In vi, this message translates to:
  /// **'Residents please pay the invoice using the QR code below:'**
  String get txtResidentsPleasePayTheInvoiceUsingTheQrCodeBelow;

  /// No description provided for @txtTransferContent.
  ///
  /// In vi, this message translates to:
  /// **'Transfer content'**
  String get txtTransferContent;

  /// No description provided for @txtCaptureAndSaveQr.
  ///
  /// In vi, this message translates to:
  /// **'Capture and save QR'**
  String get txtCaptureAndSaveQr;

  /// No description provided for @txtSavedQrCode.
  ///
  /// In vi, this message translates to:
  /// **'Saved QR Code'**
  String get txtSavedQrCode;

  /// No description provided for @txtPhotoLibraryAccessDenied.
  ///
  /// In vi, this message translates to:
  /// **'Photo library access denied.'**
  String get txtPhotoLibraryAccessDenied;

  /// No description provided for @txtCannotCaptureWidget.
  ///
  /// In vi, this message translates to:
  /// **'Cannot capture widget.'**
  String get txtCannotCaptureWidget;

  /// No description provided for @txtNhuThat1.
  ///
  /// In vi, this message translates to:
  /// **'Nhu That'**
  String get txtNhuThat1;

  /// No description provided for @txtSupportRequest.
  ///
  /// In vi, this message translates to:
  /// **'Support request'**
  String get txtSupportRequest;

  /// No description provided for @txtChangeInformation.
  ///
  /// In vi, this message translates to:
  /// **'Change information'**
  String get txtChangeInformation;

  /// No description provided for @txtRegisteredUtilityList.
  ///
  /// In vi, this message translates to:
  /// **'Registered utility list'**
  String get txtRegisteredUtilityList;

  /// No description provided for @txtPaymentRequest.
  ///
  /// In vi, this message translates to:
  /// **'Payment request'**
  String get txtPaymentRequest;

  /// No description provided for @txtNoPaymentRequests.
  ///
  /// In vi, this message translates to:
  /// **'No payment requests'**
  String get txtNoPaymentRequests;

  /// No description provided for @txtBuildingNews.
  ///
  /// In vi, this message translates to:
  /// **'Building news'**
  String get txtBuildingNews;

  /// No description provided for @txtApartmentProfile.
  ///
  /// In vi, this message translates to:
  /// **'Apartment profile'**
  String get txtApartmentProfile;

  /// No description provided for @txtResidencyInfo.
  ///
  /// In vi, this message translates to:
  /// **'Residency info'**
  String get txtResidencyInfo;

  /// No description provided for @txtHeadOfHousehold.
  ///
  /// In vi, this message translates to:
  /// **'Head of household'**
  String get txtHeadOfHousehold;

  /// No description provided for @txtDateOfBirth.
  ///
  /// In vi, this message translates to:
  /// **'Date of birth'**
  String get txtDateOfBirth;

  /// No description provided for @txtEditHeadOfHouseholdInfo.
  ///
  /// In vi, this message translates to:
  /// **'Edit head of household info'**
  String get txtEditHeadOfHouseholdInfo;

  /// No description provided for @txtApartmentInfo.
  ///
  /// In vi, this message translates to:
  /// **'Apartment info'**
  String get txtApartmentInfo;

  /// No description provided for @txtHouseNumber.
  ///
  /// In vi, this message translates to:
  /// **'House number'**
  String get txtHouseNumber;

  /// No description provided for @txtFloorArea.
  ///
  /// In vi, this message translates to:
  /// **'Floor area'**
  String get txtFloorArea;

  /// No description provided for @txtFamilyMembers.
  ///
  /// In vi, this message translates to:
  /// **'Family members'**
  String get txtFamilyMembers;

  /// No description provided for @txtNowEnterYourCurrentPassword.
  ///
  /// In vi, this message translates to:
  /// **'Now enter your current password'**
  String get txtNowEnterYourCurrentPassword;

  /// No description provided for @txtEnterCurrentPassword.
  ///
  /// In vi, this message translates to:
  /// **'Enter current password'**
  String get txtEnterCurrentPassword;

  /// No description provided for @txtOrChooseASafePasswordOnlyYouKnow.
  ///
  /// In vi, this message translates to:
  /// **'Or choose a safe password only you know'**
  String get txtOrChooseASafePasswordOnlyYouKnow;

  /// No description provided for @txtAddMember.
  ///
  /// In vi, this message translates to:
  /// **'Add member'**
  String get txtAddMember;

  /// No description provided for @txtRelationToHead.
  ///
  /// In vi, this message translates to:
  /// **'Relation to head'**
  String get txtRelationToHead;

  /// No description provided for @txtEditMemberInfo.
  ///
  /// In vi, this message translates to:
  /// **'Edit member info'**
  String get txtEditMemberInfo;

  /// No description provided for @txtAccountInformation.
  ///
  /// In vi, this message translates to:
  /// **'Account information'**
  String get txtAccountInformation;

  /// No description provided for @txtNguyenTheHoang1.
  ///
  /// In vi, this message translates to:
  /// **'Nguyen The Hoang'**
  String get txtNguyenTheHoang1;

  /// No description provided for @txtUploadImage.
  ///
  /// In vi, this message translates to:
  /// **'Upload image'**
  String get txtUploadImage;

  /// No description provided for @txtTakePhoto.
  ///
  /// In vi, this message translates to:
  /// **'Take photo'**
  String get txtTakePhoto;

  /// No description provided for @txtAnErrorOccurredTryAgainLater.
  ///
  /// In vi, this message translates to:
  /// **'An error occurred, try again later'**
  String get txtAnErrorOccurredTryAgainLater;

  /// No description provided for @txtRegisteredVehicles.
  ///
  /// In vi, this message translates to:
  /// **'Registered vehicles'**
  String get txtRegisteredVehicles;

  /// No description provided for @txtAreYouSureYouWantToDeleteYourAccount.
  ///
  /// In vi, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get txtAreYouSureYouWantToDeleteYourAccount;

  /// No description provided for @txtDeleteAccount.
  ///
  /// In vi, this message translates to:
  /// **'Delete account'**
  String get txtDeleteAccount;

  /// No description provided for @txtAreYouSureYouWantToLogout.
  ///
  /// In vi, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get txtAreYouSureYouWantToLogout;

  /// No description provided for @txtNotUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Not updated'**
  String get txtNotUpdated;

  /// No description provided for @txtVehicleOwner1.
  ///
  /// In vi, this message translates to:
  /// **'Vehicle owner'**
  String get txtVehicleOwner1;

  /// No description provided for @txtLicensePlate1.
  ///
  /// In vi, this message translates to:
  /// **'License plate'**
  String get txtLicensePlate1;

  /// No description provided for @txtRegisteredFrom.
  ///
  /// In vi, this message translates to:
  /// **'Registered from'**
  String get txtRegisteredFrom;

  /// No description provided for @txtParkingFee.
  ///
  /// In vi, this message translates to:
  /// **'Parking fee'**
  String get txtParkingFee;

  /// No description provided for @txtUtilityServices.
  ///
  /// In vi, this message translates to:
  /// **'Utility services'**
  String get txtUtilityServices;

  /// No description provided for @txtNoData.
  ///
  /// In vi, this message translates to:
  /// **'No data'**
  String get txtNoData;

  /// No description provided for @txtServiceDescription.
  ///
  /// In vi, this message translates to:
  /// **'Service description'**
  String get txtServiceDescription;

  /// No description provided for @txtRegisterService.
  ///
  /// In vi, this message translates to:
  /// **'Register service'**
  String get txtRegisterService;

  /// No description provided for @txtNoCompletedRequests.
  ///
  /// In vi, this message translates to:
  /// **'No completed requests'**
  String get txtNoCompletedRequests;

  /// No description provided for @txtRequestStatus.
  ///
  /// In vi, this message translates to:
  /// **'Request status'**
  String get txtRequestStatus;

  /// No description provided for @txtProcessingProgress.
  ///
  /// In vi, this message translates to:
  /// **'Processing progress:'**
  String get txtProcessingProgress;

  /// No description provided for @txtCreateRequest.
  ///
  /// In vi, this message translates to:
  /// **'Create request'**
  String get txtCreateRequest;

  /// No description provided for @txtSupportList.
  ///
  /// In vi, this message translates to:
  /// **'Support list'**
  String get txtSupportList;

  /// No description provided for @txtSeeMore.
  ///
  /// In vi, this message translates to:
  /// **'See more ...'**
  String get txtSeeMore;

  /// No description provided for @txtYourStatus.
  ///
  /// In vi, this message translates to:
  /// **'Your status'**
  String get txtYourStatus;

  /// No description provided for @txtPleaseSelectStatus.
  ///
  /// In vi, this message translates to:
  /// **'Please select status'**
  String get txtPleaseSelectStatus;

  /// No description provided for @txtCustomerInfo.
  ///
  /// In vi, this message translates to:
  /// **'Customer info'**
  String get txtCustomerInfo;

  /// No description provided for @txtContactPerson.
  ///
  /// In vi, this message translates to:
  /// **'Contact person'**
  String get txtContactPerson;

  /// No description provided for @txtEnterNote.
  ///
  /// In vi, this message translates to:
  /// **'Enter note'**
  String get txtEnterNote;

  /// No description provided for @txtRequiredField.
  ///
  /// In vi, this message translates to:
  /// **'Required field'**
  String get txtRequiredField;

  /// No description provided for @txtRequestSent.
  ///
  /// In vi, this message translates to:
  /// **'Request sent!'**
  String get txtRequestSent;

  /// No description provided for @txtSendRequestFailed.
  ///
  /// In vi, this message translates to:
  /// **'Send request failed!'**
  String get txtSendRequestFailed;

  /// No description provided for @txtTryAgain.
  ///
  /// In vi, this message translates to:
  /// **'Try again'**
  String get txtTryAgain;

  /// No description provided for @txtSendRequest.
  ///
  /// In vi, this message translates to:
  /// **'Send request'**
  String get txtSendRequest;

  /// No description provided for @txtCanHoEn.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ [EN]'**
  String get txtCanHoEn;

  /// No description provided for @txtTimKiemTenCanHoEn.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm tên căn hộ [EN]'**
  String get txtTimKiemTenCanHoEn;

  /// No description provided for @txtChonToaNhaEn.
  ///
  /// In vi, this message translates to:
  /// **'Chọn toà nhà [EN]'**
  String get txtChonToaNhaEn;

  /// No description provided for @txtChonTrangThaiEn.
  ///
  /// In vi, this message translates to:
  /// **'Chọn trạng thái [EN]'**
  String get txtChonTrangThaiEn;

  /// No description provided for @txtKhongCoCanHoNaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Không có căn hộ nào [EN]'**
  String get txtKhongCoCanHoNaoEn;

  /// No description provided for @txtCuDanEn.
  ///
  /// In vi, this message translates to:
  /// **'Cư dân [EN]'**
  String get txtCuDanEn;

  /// No description provided for @txtPhuongTienEn.
  ///
  /// In vi, this message translates to:
  /// **'Phương tiện [EN]'**
  String get txtPhuongTienEn;

  /// No description provided for @txtPhiDichVuEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí dịch vụ [EN]'**
  String get txtPhiDichVuEn;

  /// No description provided for @txtBienLaiEn.
  ///
  /// In vi, this message translates to:
  /// **'Biên lai [EN]'**
  String get txtBienLaiEn;

  /// No description provided for @txtTenCanHoEn.
  ///
  /// In vi, this message translates to:
  /// **'Tên căn hộ [EN]'**
  String get txtTenCanHoEn;

  /// No description provided for @txtTangEn.
  ///
  /// In vi, this message translates to:
  /// **'Tầng [EN]'**
  String get txtTangEn;

  /// No description provided for @txtTang6En.
  ///
  /// In vi, this message translates to:
  /// **'Tầng 6 [EN]'**
  String get txtTang6En;

  /// No description provided for @txtTinhTrangEn.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng [EN]'**
  String get txtTinhTrangEn;

  /// No description provided for @txtDangOEn.
  ///
  /// In vi, this message translates to:
  /// **'Đang ở [EN]'**
  String get txtDangOEn;

  /// No description provided for @txtHoDanEn.
  ///
  /// In vi, this message translates to:
  /// **'Hộ dân [EN]'**
  String get txtHoDanEn;

  /// No description provided for @txtHoTenEn.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên [EN]'**
  String get txtHoTenEn;

  /// No description provided for @txtNgaySinhEn.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh [EN]'**
  String get txtNgaySinhEn;

  /// No description provided for @txtQuanHeEn.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ [EN]'**
  String get txtQuanHeEn;

  /// No description provided for @txtKhongCoPhuongTienNaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Không có phương tiện nào [EN]'**
  String get txtKhongCoPhuongTienNaoEn;

  /// No description provided for @txtChuSoHuuEn.
  ///
  /// In vi, this message translates to:
  /// **'Chủ sở hữu [EN]'**
  String get txtChuSoHuuEn;

  /// No description provided for @txtTenPhuongTienEn.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện [EN]'**
  String get txtTenPhuongTienEn;

  /// No description provided for @txtBienSoXeEn.
  ///
  /// In vi, this message translates to:
  /// **'Biển số xe [EN]'**
  String get txtBienSoXeEn;

  /// No description provided for @txtPhiGuiXeEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi xe [EN]'**
  String get txtPhiGuiXeEn;

  /// No description provided for @txtKhongCoPhiDichVuNaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Không có phí dịch vụ nào [EN]'**
  String get txtKhongCoPhiDichVuNaoEn;

  /// No description provided for @txtTrangThaiEn.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái [EN]'**
  String get txtTrangThaiEn;

  /// No description provided for @txtChuaCoSmsNaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có SMS nào [EN]'**
  String get txtChuaCoSmsNaoEn;

  /// No description provided for @txtNoiDungEn.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung [EN]'**
  String get txtNoiDungEn;

  /// No description provided for @txtLoaiTinEn.
  ///
  /// In vi, this message translates to:
  /// **'Loại tin [EN]'**
  String get txtLoaiTinEn;

  /// No description provided for @txtNguoiGuiEn.
  ///
  /// In vi, this message translates to:
  /// **'Người gửi [EN]'**
  String get txtNguoiGuiEn;

  /// No description provided for @txtChuaCoBienLaiNaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có biên lai nào [EN]'**
  String get txtChuaCoBienLaiNaoEn;

  /// No description provided for @txtChiTietPhieuThuEn.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết phiếu thu [EN]'**
  String get txtChiTietPhieuThuEn;

  /// No description provided for @txtPhongEn.
  ///
  /// In vi, this message translates to:
  /// **'Phòng [EN]'**
  String get txtPhongEn;

  /// No description provided for @txtTongTienEn.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền [EN]'**
  String get txtTongTienEn;

  /// No description provided for @txtTenKhachHangEn.
  ///
  /// In vi, this message translates to:
  /// **'Tên khách hàng: [EN]'**
  String get txtTenKhachHangEn;

  /// No description provided for @txtChuXeEn.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe: [EN]'**
  String get txtChuXeEn;

  /// No description provided for @txtTenPhuongTienEn1.
  ///
  /// In vi, this message translates to:
  /// **'Tên phương tiện: [EN]'**
  String get txtTenPhuongTienEn1;

  /// No description provided for @txtPhiEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí: [EN]'**
  String get txtPhiEn;

  /// No description provided for @txtBienSoEn.
  ///
  /// In vi, this message translates to:
  /// **'Biển số: [EN]'**
  String get txtBienSoEn;

  /// No description provided for @txtPhiToaNhaEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí toà nhà [EN]'**
  String get txtPhiToaNhaEn;

  /// No description provided for @txtDienTichEn.
  ///
  /// In vi, this message translates to:
  /// **'Diện tích: [EN]'**
  String get txtDienTichEn;

  /// No description provided for @txtPhiThuThemEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thêm: [EN]'**
  String get txtPhiThuThemEn;

  /// No description provided for @txtPhiBaoTriEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí bảo trì: [EN]'**
  String get txtPhiBaoTriEn;

  /// No description provided for @txtTienNuocEn.
  ///
  /// In vi, this message translates to:
  /// **'Tiền nước: [EN]'**
  String get txtTienNuocEn;

  /// No description provided for @txtChuaThanhToanEn.
  ///
  /// In vi, this message translates to:
  /// **'Chưa thanh toán [EN]'**
  String get txtChuaThanhToanEn;

  /// No description provided for @txtHanThanhToanEn.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán [EN]'**
  String get txtHanThanhToanEn;

  /// No description provided for @txtTongPhiEn.
  ///
  /// In vi, this message translates to:
  /// **'Tổng Phí [EN]'**
  String get txtTongPhiEn;

  /// No description provided for @txtPhiNoEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí Nợ [EN]'**
  String get txtPhiNoEn;

  /// No description provided for @txtPhiThuThuaEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí thu thừa [EN]'**
  String get txtPhiThuThuaEn;

  /// No description provided for @txtPhiThanhToanThucTeEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí thanh toán thực tế [EN]'**
  String get txtPhiThanhToanThucTeEn;

  /// No description provided for @txtTongPhiEn1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng phí:  [EN]'**
  String get txtTongPhiEn1;

  /// No description provided for @txtThangEn.
  ///
  /// In vi, this message translates to:
  /// **'Tháng:  [EN]'**
  String get txtThangEn;

  /// No description provided for @txtTinhTrangEn1.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng:  [EN]'**
  String get txtTinhTrangEn1;

  /// No description provided for @txtSoSuDungEn.
  ///
  /// In vi, this message translates to:
  /// **'Số sử dụng: [EN]'**
  String get txtSoSuDungEn;

  /// No description provided for @txtSoKyCuoiEn.
  ///
  /// In vi, this message translates to:
  /// **'Số kỳ cuối: [EN]'**
  String get txtSoKyCuoiEn;

  /// No description provided for @txtDonViTinhEn.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tính: [EN]'**
  String get txtDonViTinhEn;

  /// No description provided for @txtChiTietSoSuDungEn.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết số sử dụng: [EN]'**
  String get txtChiTietSoSuDungEn;

  /// No description provided for @txtTongTienEn1.
  ///
  /// In vi, this message translates to:
  /// **'Tổng tiền: [EN]'**
  String get txtTongTienEn1;

  /// No description provided for @txtBienSoEn1.
  ///
  /// In vi, this message translates to:
  /// **'Biến số: [EN]'**
  String get txtBienSoEn1;

  /// No description provided for @txtChiTietEn.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết [EN]'**
  String get txtChiTietEn;

  /// No description provided for @txtChonThangEn.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tháng [EN]'**
  String get txtChonThangEn;

  /// No description provided for @txtThanhCongEn.
  ///
  /// In vi, this message translates to:
  /// **'Thành công [EN]'**
  String get txtThanhCongEn;

  /// No description provided for @txtTuChoiYeuCauEn.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối yêu cầu [EN]'**
  String get txtTuChoiYeuCauEn;

  /// No description provided for @txtHoVaTenEn.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên [EN]'**
  String get txtHoVaTenEn;

  /// No description provided for @txtQuanHeVoiChuHoEn.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ với chủ hộ [EN]'**
  String get txtQuanHeVoiChuHoEn;

  /// No description provided for @txtAnhXacMinhThongTinEn.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh xác minh thông tin [EN]'**
  String get txtAnhXacMinhThongTinEn;

  /// No description provided for @txtChuHoEn.
  ///
  /// In vi, this message translates to:
  /// **'Chủ hộ [EN]'**
  String get txtChuHoEn;

  /// No description provided for @txtVoEn.
  ///
  /// In vi, this message translates to:
  /// **'Vợ [EN]'**
  String get txtVoEn;

  /// No description provided for @txtChongEn.
  ///
  /// In vi, this message translates to:
  /// **'Chồng [EN]'**
  String get txtChongEn;

  /// No description provided for @txtBangTinEn.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin [EN]'**
  String get txtBangTinEn;

  /// No description provided for @txtXinChaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào, [EN]'**
  String get txtXinChaoEn;

  /// No description provided for @txtTaiKhoanEn.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản [EN]'**
  String get txtTaiKhoanEn;

  /// No description provided for @txtBanCoEn.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có  [EN]'**
  String get txtBanCoEn;

  /// No description provided for @txtHoTroMoiTrongNgayEn.
  ///
  /// In vi, this message translates to:
  /// **' hỗ trợ mới trong ngày [EN]'**
  String get txtHoTroMoiTrongNgayEn;

  /// No description provided for @txtXemTatCaEn.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả > [EN]'**
  String get txtXemTatCaEn;

  /// No description provided for @txtBangTinToaNhaEn.
  ///
  /// In vi, this message translates to:
  /// **'Bảng tin toà nhà [EN]'**
  String get txtBangTinToaNhaEn;

  /// No description provided for @txtTinhTrangEn2.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng :  [EN]'**
  String get txtTinhTrangEn2;

  /// No description provided for @txtDichVuEn.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ [EN]'**
  String get txtDichVuEn;

  /// No description provided for @txtThoiGianEn.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian [EN]'**
  String get txtThoiGianEn;

  /// No description provided for @txtChupAnhThanhCongEn.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh thành công [EN]'**
  String get txtChupAnhThanhCongEn;

  /// No description provided for @txtChiTietYeuCauHoTroEn.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết yêu cầu hỗ trợ [EN]'**
  String get txtChiTietYeuCauHoTroEn;

  /// No description provided for @txtThemHinhAnhEn.
  ///
  /// In vi, this message translates to:
  /// **'Thêm hình ảnh [EN]'**
  String get txtThemHinhAnhEn;

  /// No description provided for @txtThemNoteEn.
  ///
  /// In vi, this message translates to:
  /// **'Thêm note [EN]'**
  String get txtThemNoteEn;

  /// No description provided for @txtTaoYeuCauEn.
  ///
  /// In vi, this message translates to:
  /// **'Tạo yêu cầu [EN]'**
  String get txtTaoYeuCauEn;

  /// No description provided for @txtNhapTinhTrangXuLyEn.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tình trạng xử lý [EN]'**
  String get txtNhapTinhTrangXuLyEn;

  /// No description provided for @txtCapNhatThanhCongEn.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thành công [EN]'**
  String get txtCapNhatThanhCongEn;

  /// No description provided for @txtVuiLongChonTrangThaiXuLyEn.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn trạng thái xử lý [EN]'**
  String get txtVuiLongChonTrangThaiXuLyEn;

  /// No description provided for @txtBayGioHayNhapMatKhauHienTaiCuaBanEn.
  ///
  /// In vi, this message translates to:
  /// **'Bây giờ hãy nhập mật khẩu hiện tại của bạn [EN]'**
  String get txtBayGioHayNhapMatKhauHienTaiCuaBanEn;

  /// No description provided for @txtNhapMatKhauHienTaiEn.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu hiện tại [EN]'**
  String get txtNhapMatKhauHienTaiEn;

  /// No description provided for @txtXacNhanEn.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận [EN]'**
  String get txtXacNhanEn;

  /// No description provided for @txtHayChonMotMatKhauAnToanChiMinhBanBietEn.
  ///
  /// In vi, this message translates to:
  /// **'Hay chọn một mật khẩu an toàn chỉ mình bạn biết [EN]'**
  String get txtHayChonMotMatKhauAnToanChiMinhBanBietEn;

  /// No description provided for @txtNhapMatKhauMoiEn.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới [EN]'**
  String get txtNhapMatKhauMoiEn;

  /// No description provided for @txtNhapLaiMatKhauEn.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu [EN]'**
  String get txtNhapLaiMatKhauEn;

  /// No description provided for @txtDoiMatKhauEn.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu [EN]'**
  String get txtDoiMatKhauEn;

  /// No description provided for @txtNguyenThuHuongEn.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thu Hương  [EN]'**
  String get txtNguyenThuHuongEn;

  /// No description provided for @txtChinhSuaThongTinThanhVienEn.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin thành viên [EN]'**
  String get txtChinhSuaThongTinThanhVienEn;

  /// No description provided for @txtThemThanhVienEn.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thành viên [EN]'**
  String get txtThemThanhVienEn;

  /// No description provided for @txtThongTinTaiKhoanEn.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản [EN]'**
  String get txtThongTinTaiKhoanEn;

  /// No description provided for @txtChucVuEn.
  ///
  /// In vi, this message translates to:
  /// **'Chức vụ [EN]'**
  String get txtChucVuEn;

  /// No description provided for @txtSoHieuEn.
  ///
  /// In vi, this message translates to:
  /// **'Số hiệu [EN]'**
  String get txtSoHieuEn;

  /// No description provided for @txtCapNhatEn.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật [EN]'**
  String get txtCapNhatEn;

  /// No description provided for @txtDangXuatEn.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất [EN]'**
  String get txtDangXuatEn;

  /// No description provided for @txtXeMayEn.
  ///
  /// In vi, this message translates to:
  /// **'Xe máy [EN]'**
  String get txtXeMayEn;

  /// No description provided for @txtChuXeEn1.
  ///
  /// In vi, this message translates to:
  /// **'Chủ xe [EN]'**
  String get txtChuXeEn1;

  /// No description provided for @txtLienHeEn.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ [EN]'**
  String get txtLienHeEn;

  /// No description provided for @txtDangKiTuEn.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí từ [EN]'**
  String get txtDangKiTuEn;

  /// No description provided for @txtPhiGuiEn.
  ///
  /// In vi, this message translates to:
  /// **'Phí gửi [EN]'**
  String get txtPhiGuiEn;

  /// No description provided for @txtTaoThongBaoMoiEn.
  ///
  /// In vi, this message translates to:
  /// **'Tạo thông báo mới [EN]'**
  String get txtTaoThongBaoMoiEn;

  /// No description provided for @txtChonToaNhaEn1.
  ///
  /// In vi, this message translates to:
  /// **'Chọn tòa nhà [EN]'**
  String get txtChonToaNhaEn1;

  /// No description provided for @txtNoiDungThongBaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung thông báo [EN]'**
  String get txtNoiDungThongBaoEn;

  /// No description provided for @txtChonMucEn.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mục [EN]'**
  String get txtChonMucEn;

  /// No description provided for @txtTimKiemEn.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm... [EN]'**
  String get txtTimKiemEn;

  /// No description provided for @txtKhongCoKetQuaEn.
  ///
  /// In vi, this message translates to:
  /// **'Không có kết quả [EN]'**
  String get txtKhongCoKetQuaEn;

  /// No description provided for @txtHuyEn.
  ///
  /// In vi, this message translates to:
  /// **'Hủy [EN]'**
  String get txtHuyEn;

  /// No description provided for @txtLuuEn.
  ///
  /// In vi, this message translates to:
  /// **'Lưu [EN]'**
  String get txtLuuEn;

  /// No description provided for @txtGuiTatCaEn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi tất cả [EN]'**
  String get txtGuiTatCaEn;

  /// No description provided for @txtGuiRiengEn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi riêng [EN]'**
  String get txtGuiRiengEn;

  /// No description provided for @txtChiTietThongBaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thông báo [EN]'**
  String get txtChiTietThongBaoEn;

  /// No description provided for @txtThongBaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo [EN]'**
  String get txtThongBaoEn;

  /// No description provided for @txtKhongCoThongBaoEn.
  ///
  /// In vi, this message translates to:
  /// **'Không có thông báo [EN]'**
  String get txtKhongCoThongBaoEn;

  /// No description provided for @txtKhongXacDinh.
  ///
  /// In vi, this message translates to:
  /// **'không xác định'**
  String get txtKhongXacDinh;

  /// No description provided for @txtHanThanhToan2.
  ///
  /// In vi, this message translates to:
  /// **'Hạn thanh toán: '**
  String get txtHanThanhToan2;

  /// No description provided for @txtD.
  ///
  /// In vi, this message translates to:
  /// **')) đ'**
  String get txtD;

  /// No description provided for @txtTu150KwhXGia1950D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 1-50 KWh) x giá 1.950 đ:'**
  String get txtTu150KwhXGia1950D1;

  /// No description provided for @txtTu51100KwhXGia2015D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 51-100 KWh) x giá 2.015 đ:'**
  String get txtTu51100KwhXGia2015D1;

  /// No description provided for @txtTu101200KwhXGia2340D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 101-200 KWh) x giá 2.340 đ:'**
  String get txtTu101200KwhXGia2340D1;

  /// No description provided for @txtTu201300KwhXGia2947D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 201-300 KWh) x giá 2.947 đ:'**
  String get txtTu201300KwhXGia2947D1;

  /// No description provided for @txtTu301400KwhXGia3294D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 301-400 KWh) x giá 3.294 đ:'**
  String get txtTu301400KwhXGia3294D1;

  /// No description provided for @txtTu400KwhTroLenXGia3403D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 400 KWh trở lên) x giá 3.403 đ:'**
  String get txtTu400KwhTroLenXGia3403D1;

  /// No description provided for @txtTu110M3XGia9775D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 1-10 m3) x giá 9.775 đ:'**
  String get txtTu110M3XGia9775D1;

  /// No description provided for @txtTu1120M3XGia11385D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 11-20 m3) x giá 11.385 đ:'**
  String get txtTu1120M3XGia11385D1;

  /// No description provided for @txtTu2130M3XGia18400D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 21-30 m3) x giá 18.400 đ:'**
  String get txtTu2130M3XGia18400D1;

  /// No description provided for @txtTu31M3TroLenXGia31050D1.
  ///
  /// In vi, this message translates to:
  /// **' (Từ 31 m3 trở lên) x giá 31.050 đ:'**
  String get txtTu31M3TroLenXGia31050D1;

  /// No description provided for @txtSoTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Số tài khoản'**
  String get txtSoTaiKhoan;

  /// No description provided for @txtDaLuuAnhMaQrVaoThuVienAnh.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu ảnh mã QR vào thư viện ảnh!'**
  String get txtDaLuuAnhMaQrVaoThuVienAnh;

  /// No description provided for @txtDanhSachDangKyTienIch1.
  ///
  /// In vi, this message translates to:
  /// **'  Danh sách đăng ký tiện ích  '**
  String get txtDanhSachDangKyTienIch1;

  /// No description provided for @txtSoNha1.
  ///
  /// In vi, this message translates to:
  /// **'Số nhà '**
  String get txtSoNha1;

  /// No description provided for @txtThongTinTaiKhoan1.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản    '**
  String get txtThongTinTaiKhoan1;

  /// No description provided for @txtTrangThai1.
  ///
  /// In vi, this message translates to:
  /// **' Trạng thái'**
  String get txtTrangThai1;

  /// No description provided for @txtNguoiGui1.
  ///
  /// In vi, this message translates to:
  /// **'Người gửi : '**
  String get txtNguoiGui1;

  /// No description provided for @txtYeuCau2.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu : '**
  String get txtYeuCau2;

  /// No description provided for @txtTrungTamHoTro.
  ///
  /// In vi, this message translates to:
  /// **'Trung tâm hỗ trợ'**
  String get txtTrungTamHoTro;

  /// No description provided for @txtTinhTrang5.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng '**
  String get txtTinhTrang5;

  /// No description provided for @txtNguoiLienHe1.
  ///
  /// In vi, this message translates to:
  /// **'Người liên hệ '**
  String get txtNguoiLienHe1;

  /// No description provided for @txtNguoiLienHe2.
  ///
  /// In vi, this message translates to:
  /// **'Người liên hệ *'**
  String get txtNguoiLienHe2;

  /// No description provided for @txtSoDienThoai2.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại '**
  String get txtSoDienThoai2;

  /// No description provided for @txtCanHo1.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ '**
  String get txtCanHo1;

  /// No description provided for @txtChatVoiBanQuanLy.
  ///
  /// In vi, this message translates to:
  /// **'Chat với ban quản lý'**
  String get txtChatVoiBanQuanLy;

  /// No description provided for @txtShowSnackbar.
  ///
  /// In vi, this message translates to:
  /// **'Show Snackbar'**
  String get txtShowSnackbar;

  /// No description provided for @txtNhapTinNhan.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tin nhắn...'**
  String get txtNhapTinNhan;

  /// No description provided for @txtTinNhanDaDuocGui.
  ///
  /// In vi, this message translates to:
  /// **'Tin nhắn đã được gửi'**
  String get txtTinNhanDaDuocGui;

  /// No description provided for @txtTinNhanChuaDuocGui.
  ///
  /// In vi, this message translates to:
  /// **'Tin nhắn chưa được gửi'**
  String get txtTinNhanChuaDuocGui;

  /// No description provided for @txtLeThanhHai.
  ///
  /// In vi, this message translates to:
  /// **'Lê Thanh Hải'**
  String get txtLeThanhHai;

  /// No description provided for @txtXinChaoMinhLaLeThanhHai.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào! Mình là Lê Thanh Hải'**
  String get txtXinChaoMinhLaLeThanhHai;

  /// No description provided for @txtNguyenThanhHuyen.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thanh Huyền'**
  String get txtNguyenThanhHuyen;

  /// No description provided for @txtXinChaoMinhLaNguyenThanhHuyenRatVuiKhiDuoc.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào! Mình là Nguyễn Thanh Huyền, rất vui khi được...'**
  String get txtXinChaoMinhLaNguyenThanhHuyenRatVuiKhiDuoc;

  /// No description provided for @txtAutoRetiveralTimeout.
  ///
  /// In vi, this message translates to:
  /// **'Auto Retiveral timeout'**
  String get txtAutoRetiveralTimeout;

  /// No description provided for @txtVuiLongKiemTraLaiSdtVaMatKhauCuaBan.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng kiểm tra lại SDT và mật khẩu của bạn'**
  String get txtVuiLongKiemTraLaiSdtVaMatKhauCuaBan;

  /// No description provided for @txtAutoRetrievalTimeout.
  ///
  /// In vi, this message translates to:
  /// **'Auto Retrieval timeout'**
  String get txtAutoRetrievalTimeout;

  /// No description provided for @txtInvalidCode.
  ///
  /// In vi, this message translates to:
  /// **'Invalid Code'**
  String get txtInvalidCode;

  /// No description provided for @txtFileDinhKem.
  ///
  /// In vi, this message translates to:
  /// **'File đính kèm'**
  String get txtFileDinhKem;

  /// No description provided for @txtFileDinhKem1.
  ///
  /// In vi, this message translates to:
  /// **'file đính kèm'**
  String get txtFileDinhKem1;

  /// No description provided for @txtHomNay.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get txtHomNay;

  /// No description provided for @txtHomQua.
  ///
  /// In vi, this message translates to:
  /// **'Hôm qua'**
  String get txtHomQua;

  /// No description provided for @txtChuNhat.
  ///
  /// In vi, this message translates to:
  /// **'Chủ nhật'**
  String get txtChuNhat;

  /// No description provided for @txtThuHai.
  ///
  /// In vi, this message translates to:
  /// **'Thứ hai'**
  String get txtThuHai;

  /// No description provided for @txtThuBa.
  ///
  /// In vi, this message translates to:
  /// **'Thứ ba'**
  String get txtThuBa;

  /// No description provided for @txtThuTu.
  ///
  /// In vi, this message translates to:
  /// **'Thứ tư'**
  String get txtThuTu;

  /// No description provided for @txtThuNam.
  ///
  /// In vi, this message translates to:
  /// **'Thứ năm'**
  String get txtThuNam;

  /// No description provided for @txtThuSau.
  ///
  /// In vi, this message translates to:
  /// **'Thứ sáu'**
  String get txtThuSau;

  /// No description provided for @txtThuBay.
  ///
  /// In vi, this message translates to:
  /// **'Thứ bảy'**
  String get txtThuBay;

  /// No description provided for @txtBaiGiang.
  ///
  /// In vi, this message translates to:
  /// **'Bài Giảng'**
  String get txtBaiGiang;

  /// No description provided for @txtBaiTruoc.
  ///
  /// In vi, this message translates to:
  /// **'Bài trước'**
  String get txtBaiTruoc;

  /// No description provided for @txtBaiSau.
  ///
  /// In vi, this message translates to:
  /// **'Bài sau'**
  String get txtBaiSau;

  /// No description provided for @txtTocDoPhat.
  ///
  /// In vi, this message translates to:
  /// **'Tốc độ phát'**
  String get txtTocDoPhat;

  /// No description provided for @txtDoNotPassValueToBlocvalueBlocprovidersAtTheSameTime.
  ///
  /// In vi, this message translates to:
  /// **'Do not pass value to [blocValue] & [blocProviders] at the same time.'**
  String get txtDoNotPassValueToBlocvalueBlocprovidersAtTheSameTime;

  /// No description provided for @txtBai1.
  ///
  /// In vi, this message translates to:
  /// **'Bài 1'**
  String get txtBai1;

  /// No description provided for @txtBai2.
  ///
  /// In vi, this message translates to:
  /// **'Bài 2'**
  String get txtBai2;

  /// No description provided for @txtBai3.
  ///
  /// In vi, this message translates to:
  /// **'bài 3'**
  String get txtBai3;

  /// No description provided for @txtBai4.
  ///
  /// In vi, this message translates to:
  /// **'Bài 4'**
  String get txtBai4;

  /// No description provided for @txtGiaiPhapToanDien.
  ///
  /// In vi, this message translates to:
  /// **'Giải pháp toàn diện'**
  String get txtGiaiPhapToanDien;

  /// No description provided for @txtDuBanOBatCuDauCungCoTheTheoDoiViecHocCuaConMotCachDeDangVoiUngDung.
  ///
  /// In vi, this message translates to:
  /// **'Dù bạn ở bất cứ đâu cũng có thể theo dõi việc học của con một cách dễ dàng với ứng dụng'**
  String
      get txtDuBanOBatCuDauCungCoTheTheoDoiViecHocCuaConMotCachDeDangVoiUngDung;

  /// No description provided for @txtNangTamHocTap.
  ///
  /// In vi, this message translates to:
  /// **'Nâng tầm học tập'**
  String get txtNangTamHocTap;

  /// No description provided for @txtThuVien500BaiTapVaTaiLieuCaoCapGiupBanDeChinhPhucMoiMucTieu.
  ///
  /// In vi, this message translates to:
  /// **'Thư viện 500+ bài tập và tài liệu cao cấp, giúp bạn dễ chinh phục mọi mục tiêu'**
  String get txtThuVien500BaiTapVaTaiLieuCaoCapGiupBanDeChinhPhucMoiMucTieu;

  /// No description provided for @txtThongBaoKipThoi.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo kịp thời'**
  String get txtThongBaoKipThoi;

  /// No description provided for @txtThemCauHoi.
  ///
  /// In vi, this message translates to:
  /// **'Thêm câu hỏi'**
  String get txtThemCauHoi;

  /// No description provided for @txtCompleteStock.
  ///
  /// In vi, this message translates to:
  /// **'Complete Stock'**
  String get txtCompleteStock;

  /// No description provided for @txtKhoaHocPhoBien.
  ///
  /// In vi, this message translates to:
  /// **'Khóa học phổ biến'**
  String get txtKhoaHocPhoBien;

  /// No description provided for @txtThongTinKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin khóa học'**
  String get txtThongTinKhoaHoc;

  /// No description provided for @txtCoAnhThu.
  ///
  /// In vi, this message translates to:
  /// **'cô Anh Thư'**
  String get txtCoAnhThu;

  /// No description provided for @txtCoHoangMai.
  ///
  /// In vi, this message translates to:
  /// **'cô Hoàng Mai'**
  String get txtCoHoangMai;

  /// No description provided for @txtCoThaoNguyen.
  ///
  /// In vi, this message translates to:
  /// **'cô Thảo Nguyên'**
  String get txtCoThaoNguyen;

  /// No description provided for @txtFlutterApps.
  ///
  /// In vi, this message translates to:
  /// **'Flutter Apps'**
  String get txtFlutterApps;

  /// No description provided for @txtTomTat.
  ///
  /// In vi, this message translates to:
  /// **'Tóm tắt'**
  String get txtTomTat;

  /// No description provided for @txtCoMinhNguyet.
  ///
  /// In vi, this message translates to:
  /// **'cô Minh Nguyệt'**
  String get txtCoMinhNguyet;

  /// No description provided for @txtMaGiamGia.
  ///
  /// In vi, this message translates to:
  /// **'Mã giảm giá'**
  String get txtMaGiamGia;

  /// No description provided for @txtMuaKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Mua khóa học'**
  String get txtMuaKhoaHoc;

  /// No description provided for @txtPhuongThucThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get txtPhuongThucThanhToan;

  /// No description provided for @txtCauHoi.
  ///
  /// In vi, this message translates to:
  /// **'Câu hỏi'**
  String get txtCauHoi;

  /// No description provided for @txtApplyCode.
  ///
  /// In vi, this message translates to:
  /// **'Apply Code'**
  String get txtApplyCode;

  /// No description provided for @txtProWebDesigner.
  ///
  /// In vi, this message translates to:
  /// **'Pro Web Designer'**
  String get txtProWebDesigner;

  /// No description provided for @txtCustomerService.
  ///
  /// In vi, this message translates to:
  /// **'Customer Service'**
  String get txtCustomerService;

  /// No description provided for @txtBatDauLai.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu lại'**
  String get txtBatDauLai;

  /// No description provided for @txtChungChi.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ'**
  String get txtChungChi;

  /// No description provided for @txtGui.
  ///
  /// In vi, this message translates to:
  /// **'Gửi'**
  String get txtGui;

  /// No description provided for @txtTaiChungChi.
  ///
  /// In vi, this message translates to:
  /// **'Tải chứng chỉ'**
  String get txtTaiChungChi;

  /// No description provided for @txtSeniorProductManager.
  ///
  /// In vi, this message translates to:
  /// **'Senior Product Manager'**
  String get txtSeniorProductManager;

  /// No description provided for @txtProductDesigner.
  ///
  /// In vi, this message translates to:
  /// **'Product Designer'**
  String get txtProductDesigner;

  /// No description provided for @txtLearnAnimation.
  ///
  /// In vi, this message translates to:
  /// **'Learn Animation'**
  String get txtLearnAnimation;

  /// No description provided for @txtCyndyLillibridge.
  ///
  /// In vi, this message translates to:
  /// **'Cyndy Lillibridge'**
  String get txtCyndyLillibridge;

  /// No description provided for @txtTopMentors.
  ///
  /// In vi, this message translates to:
  /// **'Top Mentors'**
  String get txtTopMentors;

  /// No description provided for @txtJacobKulikowski.
  ///
  /// In vi, this message translates to:
  /// **'Jacob Kulikowski'**
  String get txtJacobKulikowski;

  /// No description provided for @txtMarketingAnalyst.
  ///
  /// In vi, this message translates to:
  /// **'Marketing Analyst'**
  String get txtMarketingAnalyst;

  /// No description provided for @txtClaireOrdonez.
  ///
  /// In vi, this message translates to:
  /// **'Claire Ordonez'**
  String get txtClaireOrdonez;

  /// No description provided for @txtPriscillaEhrman.
  ///
  /// In vi, this message translates to:
  /// **'Priscilla Ehrman'**
  String get txtPriscillaEhrman;

  /// No description provided for @txtWadeChenail.
  ///
  /// In vi, this message translates to:
  /// **'Wade Chenail'**
  String get txtWadeChenail;

  /// No description provided for @txtKathrynPera.
  ///
  /// In vi, this message translates to:
  /// **'Kathryn Pera'**
  String get txtKathrynPera;

  /// No description provided for @txtProductManager.
  ///
  /// In vi, this message translates to:
  /// **'Product Manager'**
  String get txtProductManager;

  /// No description provided for @txtBanChacChanMuonDangXuat1.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chắc chắn muốn đăng xuất ?'**
  String get txtBanChacChanMuonDangXuat1;

  /// No description provided for @txtLoremIpsumDolorSitAmetConsecteturAdipiscingElitSedDoEiusmodTemporIncididuntUtLaboreEtDoloreMagnaAliquaUtEnimAdMinimVeniamQuisNostrudExercitationUllamcoLaborisNisiUtAliquipExEaCommodoConsequatDuisAuteIrureDolorInReprehenderitInVoluptateVelitEsseCillumDoloreEuFugiatNullaPariaturExcepteurSintOccaecatCupidatatNonProidentSuntInCulpaQuiOfficialsDeseruntMollitAnimIdEstLaborum.
  ///
  /// In vi, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officials deserunt mollit anim id est laborum.'**
  String
      get txtLoremIpsumDolorSitAmetConsecteturAdipiscingElitSedDoEiusmodTemporIncididuntUtLaboreEtDoloreMagnaAliquaUtEnimAdMinimVeniamQuisNostrudExercitationUllamcoLaborisNisiUtAliquipExEaCommodoConsequatDuisAuteIrureDolorInReprehenderitInVoluptateVelitEsseCillumDoloreEuFugiatNullaPariaturExcepteurSintOccaecatCupidatatNonProidentSuntInCulpaQuiOfficialsDeseruntMollitAnimIdEstLaborum;

  /// No description provided for @txtCaNhan.
  ///
  /// In vi, this message translates to:
  /// **'Cá nhân'**
  String get txtCaNhan;

  /// No description provided for @txtGhiNhoTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhớ tài khoản'**
  String get txtGhiNhoTaiKhoan;

  /// No description provided for @txtFaceId.
  ///
  /// In vi, this message translates to:
  /// **'Face ID'**
  String get txtFaceId;

  /// No description provided for @txtSinhTracHocId.
  ///
  /// In vi, this message translates to:
  /// **'Sinh trắc học ID'**
  String get txtSinhTracHocId;

  /// No description provided for @txtGoogleAuthenticator.
  ///
  /// In vi, this message translates to:
  /// **'Google Authenticator'**
  String get txtGoogleAuthenticator;

  /// No description provided for @txtDangKi.
  ///
  /// In vi, this message translates to:
  /// **'Đăng kí'**
  String get txtDangKi;

  /// No description provided for @txtDoiMaPin.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mã PIN'**
  String get txtDoiMaPin;

  /// No description provided for @txtChonPhuongThucThanhToanBanMuonSuDung.
  ///
  /// In vi, this message translates to:
  /// **'Chọn phương thức thanh toán bạn muốn sử dụng'**
  String get txtChonPhuongThucThanhToanBanMuonSuDung;

  /// No description provided for @txtChon.
  ///
  /// In vi, this message translates to:
  /// **'Chọn'**
  String get txtChon;

  /// No description provided for @txtGeneralNotification.
  ///
  /// In vi, this message translates to:
  /// **'General Notification'**
  String get txtGeneralNotification;

  /// No description provided for @txtTiepTuc.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get txtTiepTuc;

  /// No description provided for @txtDanhSachMongMuonCuaBan.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách mong muốn của bạn'**
  String get txtDanhSachMongMuonCuaBan;

  /// No description provided for @txtTatCaKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả khóa học'**
  String get txtTatCaKhoaHoc;

  /// No description provided for @txtPhotographyAdded.
  ///
  /// In vi, this message translates to:
  /// **'Photography added'**
  String get txtPhotographyAdded;

  /// No description provided for @txtKhoaHocCuaToi.
  ///
  /// In vi, this message translates to:
  /// **'Khóa học của tôi'**
  String get txtKhoaHocCuaToi;

  /// No description provided for @txtJaneCooper.
  ///
  /// In vi, this message translates to:
  /// **'Jane Cooper'**
  String get txtJaneCooper;

  /// No description provided for @txtBasicFitnessWorkout.
  ///
  /// In vi, this message translates to:
  /// **'Basic Fitness Workout'**
  String get txtBasicFitnessWorkout;

  /// No description provided for @txtUsing3dAnimation.
  ///
  /// In vi, this message translates to:
  /// **'Using 3D Animation'**
  String get txtUsing3dAnimation;

  /// No description provided for @txtEstherHoward.
  ///
  /// In vi, this message translates to:
  /// **'Esther Howard'**
  String get txtEstherHoward;

  /// No description provided for @txtHoanThanh.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get txtHoanThanh;

  /// No description provided for @txtAdvanceTstockTraning.
  ///
  /// In vi, this message translates to:
  /// **'Advance TStock Traning'**
  String get txtAdvanceTstockTraning;

  /// No description provided for @txtCourtneyHenry.
  ///
  /// In vi, this message translates to:
  /// **'Courtney Henry'**
  String get txtCourtneyHenry;

  /// No description provided for @txtDevonLane.
  ///
  /// In vi, this message translates to:
  /// **'Devon Lane'**
  String get txtDevonLane;

  /// No description provided for @txtSpecialOffers.
  ///
  /// In vi, this message translates to:
  /// **'Special Offers'**
  String get txtSpecialOffers;

  /// No description provided for @txtUuDai.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi'**
  String get txtUuDai;

  /// No description provided for @txtHoanTien.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tiền'**
  String get txtHoanTien;

  /// No description provided for @txtCapNhatPhienBanMoi.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật phiên bản mới'**
  String get txtCapNhatPhienBanMoi;

  /// No description provided for @txtCardNumber.
  ///
  /// In vi, this message translates to:
  /// **'Card Number'**
  String get txtCardNumber;

  /// No description provided for @txtExpiryDate.
  ///
  /// In vi, this message translates to:
  /// **'Expiry Date'**
  String get txtExpiryDate;

  /// No description provided for @txtDichVuMoi.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ mới'**
  String get txtDichVuMoi;

  /// No description provided for @txtTransactionId.
  ///
  /// In vi, this message translates to:
  /// **'Transaction ID'**
  String get txtTransactionId;

  /// No description provided for @txtMeoMoi.
  ///
  /// In vi, this message translates to:
  /// **'Mẹo mới'**
  String get txtMeoMoi;

  /// No description provided for @txtCardName.
  ///
  /// In vi, this message translates to:
  /// **'Card Name'**
  String get txtCardName;

  /// No description provided for @txtDangKyThanhCong.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thành công'**
  String get txtDangKyThanhCong;

  /// No description provided for @txtYouHaveSuccessfullyMadePaymentAndEnrolledTheCourse.
  ///
  /// In vi, this message translates to:
  /// **'You have successfully made payment and enrolled the course.'**
  String get txtYouHaveSuccessfullyMadePaymentAndEnrolledTheCourse;

  /// No description provided for @txtNhapMaPinCuaBanDeXacNhanThanhToan.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã PIN của bạn để xác nhận thanh toán'**
  String get txtNhapMaPinCuaBanDeXacNhanThanhToan;

  /// No description provided for @txtXemKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Xem khóa học'**
  String get txtXemKhoaHoc;

  /// No description provided for @txtXemBienNhan.
  ///
  /// In vi, this message translates to:
  /// **'Xem biên nhận'**
  String get txtXemBienNhan;

  /// No description provided for @txtGooglePay.
  ///
  /// In vi, this message translates to:
  /// **'Google Pay'**
  String get txtGooglePay;

  /// No description provided for @txtApplePay.
  ///
  /// In vi, this message translates to:
  /// **'Apple Pay'**
  String get txtApplePay;

  /// No description provided for @txtThemTheMoi.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thẻ mới'**
  String get txtThemTheMoi;

  /// No description provided for @txtXinChaoChaoMungDenVoiHve.
  ///
  /// In vi, this message translates to:
  /// **'Xin Chào, Chào mừng đến với HVE'**
  String get txtXinChaoChaoMungDenVoiHve;

  /// No description provided for @txtQuocGia.
  ///
  /// In vi, this message translates to:
  /// **'Quốc gia'**
  String get txtQuocGia;

  /// No description provided for @txtBeginnerDesigner.
  ///
  /// In vi, this message translates to:
  /// **'Beginner Designer'**
  String get txtBeginnerDesigner;

  /// No description provided for @txtGuiMa.
  ///
  /// In vi, this message translates to:
  /// **'Gửi mã'**
  String get txtGuiMa;

  /// No description provided for @txtGia.
  ///
  /// In vi, this message translates to:
  /// **'Giá'**
  String get txtGia;

  /// No description provided for @txtVietNam.
  ///
  /// In vi, this message translates to:
  /// **'Việt Nam'**
  String get txtVietNam;

  /// No description provided for @txtCreditCard.
  ///
  /// In vi, this message translates to:
  /// **'Credit Card'**
  String get txtCreditCard;

  /// No description provided for @txtLearnUxDesign.
  ///
  /// In vi, this message translates to:
  /// **'Learn UX Design'**
  String get txtLearnUxDesign;

  /// No description provided for @txtHoacDangNhapVoiGoogleHoacFacebook.
  ///
  /// In vi, this message translates to:
  /// **'Hoặc đăng nhập với google hoặc facebook'**
  String get txtHoacDangNhapVoiGoogleHoacFacebook;

  /// No description provided for @txtTechFigmaDesign.
  ///
  /// In vi, this message translates to:
  /// **'Tech Figma Design'**
  String get txtTechFigmaDesign;

  /// No description provided for @txtLearnUiBasic.
  ///
  /// In vi, this message translates to:
  /// **'Learn UI Basic'**
  String get txtLearnUiBasic;

  /// No description provided for @txtChuaCoTaiKhoan.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản ?'**
  String get txtChuaCoTaiKhoan;

  /// No description provided for @txtDangKy.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get txtDangKy;

  /// No description provided for @txtNhapEmail.
  ///
  /// In vi, this message translates to:
  /// **'Nhập Email '**
  String get txtNhapEmail;

  /// No description provided for @txtNhapMatKhau.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu'**
  String get txtNhapMatKhau;

  /// No description provided for @txtXacThuc.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực'**
  String get txtXacThuc;

  /// No description provided for @txtMaXacThuc.
  ///
  /// In vi, this message translates to:
  /// **'Mã xác thực'**
  String get txtMaXacThuc;

  /// No description provided for @txtGuiLai.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại'**
  String get txtGuiLai;

  /// No description provided for @txtXinChao2.
  ///
  /// In vi, this message translates to:
  /// **'Xin Chào'**
  String get txtXinChao2;

  /// No description provided for @txtMyLam.
  ///
  /// In vi, this message translates to:
  /// **'Mỹ Lâm'**
  String get txtMyLam;

  /// No description provided for @txtSuaThongTinCaNhan.
  ///
  /// In vi, this message translates to:
  /// **'Sửa thông tin cá nhân'**
  String get txtSuaThongTinCaNhan;

  /// No description provided for @txtThongBao1.
  ///
  /// In vi, this message translates to:
  /// **'Thông Báo'**
  String get txtThongBao1;

  /// No description provided for @txtThanhToan1.
  ///
  /// In vi, this message translates to:
  /// **'Thanh Toán'**
  String get txtThanhToan1;

  /// No description provided for @txtBaoMat.
  ///
  /// In vi, this message translates to:
  /// **'Bảo mật'**
  String get txtBaoMat;

  /// No description provided for @txtNgonNgu.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn Ngữ'**
  String get txtNgonNgu;

  /// No description provided for @txtDuocDeXuat.
  ///
  /// In vi, this message translates to:
  /// **'Được đề xuất'**
  String get txtDuocDeXuat;

  /// No description provided for @txtCheDoToi.
  ///
  /// In vi, this message translates to:
  /// **'Chế độ tối'**
  String get txtCheDoToi;

  /// No description provided for @txtChinhSachBaoMat.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách bảo mật'**
  String get txtChinhSachBaoMat;

  /// No description provided for @txtContactUs.
  ///
  /// In vi, this message translates to:
  /// **'Contact us'**
  String get txtContactUs;

  /// No description provided for @txtTongQuan.
  ///
  /// In vi, this message translates to:
  /// **'Tổng quan'**
  String get txtTongQuan;

  /// No description provided for @txtKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Khóa học'**
  String get txtKhoaHoc;

  /// No description provided for @txtMoiBanBe.
  ///
  /// In vi, this message translates to:
  /// **'Mời bạn bè'**
  String get txtMoiBanBe;

  /// No description provided for @txtTishaSmith.
  ///
  /// In vi, this message translates to:
  /// **'Tisha Smith'**
  String get txtTishaSmith;

  /// No description provided for @txtSirgioTaylor.
  ///
  /// In vi, this message translates to:
  /// **'Sirgio Taylor'**
  String get txtSirgioTaylor;

  /// No description provided for @txtTapsyWilson.
  ///
  /// In vi, this message translates to:
  /// **'Tapsy Wilson'**
  String get txtTapsyWilson;

  /// No description provided for @txtVihaDavies.
  ///
  /// In vi, this message translates to:
  /// **'Viha Davies'**
  String get txtVihaDavies;

  /// No description provided for @txtShroudEvans.
  ///
  /// In vi, this message translates to:
  /// **'Shroud Evans'**
  String get txtShroudEvans;

  /// No description provided for @txtKiyaraEdwards.
  ///
  /// In vi, this message translates to:
  /// **'Kiyara Edwards'**
  String get txtKiyaraEdwards;

  /// No description provided for @txtRutanClarke.
  ///
  /// In vi, this message translates to:
  /// **'Rutan Clarke'**
  String get txtRutanClarke;

  /// No description provided for @txtMilanshDavis.
  ///
  /// In vi, this message translates to:
  /// **'Milansh Davis'**
  String get txtMilanshDavis;

  /// No description provided for @txtGiaoVienDeXuat.
  ///
  /// In vi, this message translates to:
  /// **'Giáo viên đề xuất'**
  String get txtGiaoVienDeXuat;

  /// No description provided for @txtTatCa.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get txtTatCa;

  /// No description provided for @txtKhoaHocDeXuat.
  ///
  /// In vi, this message translates to:
  /// **'Khóa học đề xuất'**
  String get txtKhoaHocDeXuat;

  /// No description provided for @txtRiyanshAgrawal.
  ///
  /// In vi, this message translates to:
  /// **'Riyansh Agrawal'**
  String get txtRiyanshAgrawal;

  /// No description provided for @txtSeniorUiDesigner.
  ///
  /// In vi, this message translates to:
  /// **'Senior UI Designer'**
  String get txtSeniorUiDesigner;

  /// No description provided for @txtChiTietKhoaHoc.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết khóa học'**
  String get txtChiTietKhoaHoc;

  /// No description provided for @txtLoremIpsumIsSimplyDummyTextOfThePrintingAndTypesettingIndustryLoremIpsumHasBeenTheIndustrysStandardDummyTextEverSinceThe1500sWhenAnUnknownPrinterTookAGalleyOfTypeAndScrambledItToMakeATypeSpecimenBookitHasSurvivedNotOnlyFiveCenturiesButAlsoTheLeapIntoElectronicTypesettingRemainingEssentiallyUnchangedItWasPopularisedInThe1960sWithTheReleaseOfLettresSheetsContainingLoremIpsumPassagesAndMoreRecentlyWithDesktopPublishingSoftwareLikeAldusPagemakerIncludingVersionsOfLoremIpsum.
  ///
  /// In vi, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Lettres sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'**
  String
      get txtLoremIpsumIsSimplyDummyTextOfThePrintingAndTypesettingIndustryLoremIpsumHasBeenTheIndustrysStandardDummyTextEverSinceThe1500sWhenAnUnknownPrinterTookAGalleyOfTypeAndScrambledItToMakeATypeSpecimenBookitHasSurvivedNotOnlyFiveCenturiesButAlsoTheLeapIntoElectronicTypesettingRemainingEssentiallyUnchangedItWasPopularisedInThe1960sWithTheReleaseOfLettresSheetsContainingLoremIpsumPassagesAndMoreRecentlyWithDesktopPublishingSoftwareLikeAldusPagemakerIncludingVersionsOfLoremIpsum;

  /// No description provided for @txtWhyUsingFigma.
  ///
  /// In vi, this message translates to:
  /// **'Why Using Figma'**
  String get txtWhyUsingFigma;

  /// No description provided for @txtSetUpYourFigmaAccount.
  ///
  /// In vi, this message translates to:
  /// **'Set up Your Figma Account'**
  String get txtSetUpYourFigmaAccount;

  /// No description provided for @txtTakeALookFigmaInterface.
  ///
  /// In vi, this message translates to:
  /// **'Take a Look Figma Interface'**
  String get txtTakeALookFigmaInterface;

  /// No description provided for @txtWorkingWithFrameLayer.
  ///
  /// In vi, this message translates to:
  /// **'Working with Frame & Layer'**
  String get txtWorkingWithFrameLayer;

  /// No description provided for @txtWorkingWithTextGrids.
  ///
  /// In vi, this message translates to:
  /// **'Working with Text & Grids'**
  String get txtWorkingWithTextGrids;

  /// No description provided for @txtUsingFigmaPlugins.
  ///
  /// In vi, this message translates to:
  /// **'Using Figma Plugins'**
  String get txtUsingFigmaPlugins;

  /// No description provided for @txtGoodScientist.
  ///
  /// In vi, this message translates to:
  /// **'Good Scientist'**
  String get txtGoodScientist;

  /// No description provided for @txtKinilBaker.
  ///
  /// In vi, this message translates to:
  /// **'Kinil Baker'**
  String get txtKinilBaker;

  /// No description provided for @txtHocSinh.
  ///
  /// In vi, this message translates to:
  /// **'Học sinh'**
  String get txtHocSinh;

  /// No description provided for @txtFreidaVarnes.
  ///
  /// In vi, this message translates to:
  /// **'Freida Varnes'**
  String get txtFreidaVarnes;

  /// No description provided for @txtJuniorDesigner.
  ///
  /// In vi, this message translates to:
  /// **'Junior Designer'**
  String get txtJuniorDesigner;

  /// No description provided for @txtSharingWorkWithTeam.
  ///
  /// In vi, this message translates to:
  /// **'Sharing Work with Team'**
  String get txtSharingWorkWithTeam;

  /// No description provided for @txtExportingAssets.
  ///
  /// In vi, this message translates to:
  /// **'Exporting Assets'**
  String get txtExportingAssets;

  /// No description provided for @txtTanuMishra.
  ///
  /// In vi, this message translates to:
  /// **'Tanu Mishra'**
  String get txtTanuMishra;

  /// No description provided for @txtTannerStafford.
  ///
  /// In vi, this message translates to:
  /// **'Tanner Stafford'**
  String get txtTannerStafford;

  /// No description provided for @txtBittuTrivedi.
  ///
  /// In vi, this message translates to:
  /// **'Bittu Trivedi'**
  String get txtBittuTrivedi;

  /// No description provided for @txtLaraChopra.
  ///
  /// In vi, this message translates to:
  /// **'Lara Chopra'**
  String get txtLaraChopra;

  /// No description provided for @txtChiekoChute.
  ///
  /// In vi, this message translates to:
  /// **'Chieko Chute'**
  String get txtChiekoChute;

  /// No description provided for @txtMalinaShahid.
  ///
  /// In vi, this message translates to:
  /// **'Malina Shahid'**
  String get txtMalinaShahid;

  /// No description provided for @txtChatLuongCuaKhoaHocVaGiaoVienRatTotBaiGiangRatDeHieu.
  ///
  /// In vi, this message translates to:
  /// **'CHất lượng của khóa học và giáo viên rất tốt, bài giảng rất dễ hiểu💯💯💯'**
  String get txtChatLuongCuaKhoaHocVaGiaoVienRatTotBaiGiangRatDeHieu;

  /// No description provided for @txtFranceneVandyne.
  ///
  /// In vi, this message translates to:
  /// **'Francene Vandyne'**
  String get txtFranceneVandyne;

  /// No description provided for @txtKhoaHocDuocXayDungRatRoRangRanhMachGiupToiBoSungKienThuc1CachNhanhChong.
  ///
  /// In vi, this message translates to:
  /// **'Khóa học được xây dựng rất rõ ràng rành mạch, giúp tôi bổ sung kiến thức 1 cách nhanh chóng 😎😎'**
  String
      get txtKhoaHocDuocXayDungRatRoRangRanhMachGiupToiBoSungKienThuc1CachNhanhChong;

  /// No description provided for @txtRachelFoose.
  ///
  /// In vi, this message translates to:
  /// **'Rachel Foose'**
  String get txtRachelFoose;

  /// No description provided for @txtInThisProgramIveLearnedHowToImproveTheWayIReactToCertainThings.
  ///
  /// In vi, this message translates to:
  /// **'In this program I’ve learned how to improve the way I react to certain things.'**
  String get txtInThisProgramIveLearnedHowToImproveTheWayIReactToCertainThings;

  /// No description provided for @txtTaiSaoNenThiIelts.
  ///
  /// In vi, this message translates to:
  /// **'Tại sao nên thi IELTS'**
  String get txtTaiSaoNenThiIelts;

  /// No description provided for @txtChiaSeKienThuc.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ kiến thức'**
  String get txtChiaSeKienThuc;

  /// No description provided for @txtThongBaoLichHocMoiMo.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo lịch học mới mở'**
  String get txtThongBaoLichHocMoiMo;

  /// No description provided for @txtThaycoPhanChanhDaiDaGiaoChoBan1BaiTapVeNha.
  ///
  /// In vi, this message translates to:
  /// **'Thầy/cô Phan Chánh Đại đã giao cho bạn 1 bài tập về nhà'**
  String get txtThaycoPhanChanhDaiDaGiaoChoBan1BaiTapVeNha;

  /// No description provided for @txtBaiTapHomeworkListeningWeek4.
  ///
  /// In vi, this message translates to:
  /// **'Bài tập Homework Listening Week 4'**
  String get txtBaiTapHomeworkListeningWeek4;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
