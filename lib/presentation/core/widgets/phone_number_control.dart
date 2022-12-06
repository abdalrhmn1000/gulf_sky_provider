import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberControl extends StatefulWidget {
  const PhoneNumberControl({
    Key? key,
    required TextEditingController phoneController,
    this.keyboardAction = TextInputAction.next,
  })  : _phoneController = phoneController,
        super(key: key);

  final TextEditingController _phoneController;

  final TextInputAction keyboardAction;

  @override
  State<PhoneNumberControl> createState() => _PhoneNumberControlState();
}

class _PhoneNumberControlState extends State<PhoneNumberControl> {
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      maxLength: 10,
      textFieldController: widget._phoneController,
      inputDecoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.phone,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      hintText: 'phone_number'.tr(),
      initialValue: PhoneNumber(
        isoCode: PhoneNumber.getISO2CodeByPrefix(
            '+965'),
      ),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        leadingPadding: 10.0,
      ),
      validator: (text) {
        if (text != null &&
            (!MinLengthValidator(
              7,
              errorText: 'invalid_phone_error_message'.tr(),
            ).isValid(text))) {
          return 'invalid_phone_error_message'.tr();
        }
        return null;
      },
      keyboardAction: widget.keyboardAction,
      onInputChanged: (newPhoneNumber) {

      },
    );
  }
}
