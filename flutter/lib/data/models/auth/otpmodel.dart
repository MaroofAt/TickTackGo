class OtpResponseModel {
  final int status;
  final String message;
  final dynamic data;

  OtpResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      status: json['status'] ?? 200,
      message: json['message'] ?? 'OTP sent successfully',
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data,
  };
}