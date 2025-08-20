class SignUpModel {
  String username;
  String email;
  String password;
  String howToUseWebsite;
  String whatDoYouDo;
  String howDidYouGetHere;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
    required this.howToUseWebsite,
    required this.whatDoYouDo,
    required this.howDidYouGetHere,

  });
  SignUpModel copyWith({
    String? username,
    String? email,
    String? password,
    String? howToUseWebsite,
    String? whatDoYouDo,
    String? howDidYouGetHere,

  }) {
    return SignUpModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      howToUseWebsite: howToUseWebsite ?? this.howToUseWebsite,
      whatDoYouDo: whatDoYouDo ?? this.whatDoYouDo,
      howDidYouGetHere: howDidYouGetHere ?? this.howDidYouGetHere,

    );
  } Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'how_to_use_website': howToUseWebsite,
      'what_do_you_do': whatDoYouDo,
      'how_did_you_get_here': howDidYouGetHere,
    };
  }
}
