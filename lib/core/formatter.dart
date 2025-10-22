import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter phoneNumberFormatter = MaskTextInputFormatter(
  mask: '+### ## ### ## ##',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.lazy,
);
