part of 'help_center_bloc.dart';

sealed class HelpCenterEvent {}
final class HelpCenterContentLoading extends HelpCenterEvent {}
final class FaqLoading extends HelpCenterEvent {}
