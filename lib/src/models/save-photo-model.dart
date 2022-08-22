import 'package:equatable/equatable.dart';

class SavePhotoModel extends Equatable {
  final String status;
  final String errorCode;
  final String errorMessage;

  SavePhotoModel(
      {this.status = '', this.errorCode = '', this.errorMessage = ''});

  factory SavePhotoModel.fromJson(Map<String, dynamic> json, int newAccount) {
    return newAccount == 1
        ? SavePhotoModel(
            status: json['status'],
            errorCode: json['errorCode'],
            errorMessage: json['errorMessage'],
          )
        : SavePhotoModel(
            status: json['status'],
            errorCode: json['errorCode'],
            errorMessage: json['errorMessage']);
  }

  @override
  List<Object?> get props => [
        status,
        errorCode,
        errorMessage,
      ];
}
