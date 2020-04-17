import 'package:equatable/equatable.dart';

abstract class CommonEquatable extends Equatable {
  @override
  String toString() {
    return '$runtimeType ${super.toString()}';
  }
}
