import 'dart:developer';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_mask/easy_mask.dart';

class InputHelper {
  static MaskTextInputFormatter maskTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "+# (###) ###-##-##",
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
  }

  static TextInputMask dateTextInputFormatter() {
    return TextInputMask(mask: '99.99.9999');
  }

  static MaskTextInputFormatter bankTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "#### #### #### ####",
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
  }
}
