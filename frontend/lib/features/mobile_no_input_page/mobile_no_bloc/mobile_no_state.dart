import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MobileNoInputState extends Equatable {}

class MobileNoState extends MobileNoInputState {
  final String mobileNo;
  MobileNoState({required this.mobileNo});

  factory MobileNoState.initialState() {
    return MobileNoState(mobileNo: '');
  }

  Mobile
  @override
  List<Object?> get props => [mobileNo];
}
