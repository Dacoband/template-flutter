import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_cart_test/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
  }) : super(
          id: id,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
        );
        factory UserModel.fromJson(Map<String, dynamic> json) =>
            _$UserModelFromJson(json); // Chuyển đổi dữ liệu từ JSON sang đối tượng UserModel
  // và trả về đối tượng UserModel
  Map<String, dynamic> toJson() => _$UserModelToJson(this); // Chuyển đổi dữ liệu từ đối tượng UserModel sang JSON
}