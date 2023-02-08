class GenerateOtpResponse {
  String? otpCode;

  GenerateOtpResponse({this.otpCode});

  GenerateOtpResponse.fromJson(Map<String, dynamic> json) {
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp_code'] = otpCode;
    return data;
  }
}