import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/back_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_app_bar.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_drop_down_widget.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/password_control.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/phone_number_control.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/present_date_picker.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with ScreenLoader<SignUpPage>, ScreenUtils {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _firstNameFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormFieldKey =
      GlobalKey<FormFieldState>();

  late MultiValidator _passwordValidator;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? dateOfBirth;
  Gender _gender = Gender.male;
  String? _genderTypeAsString;
  File? _updatedImage;
  final ImagePicker _picker = ImagePicker();
  final SignUpBloc _signUpBloc = getIt<SignUpBloc>();

  @override
  void initState() {
    _passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'field_required_message'.tr()),
      MinLengthValidator(8, errorText: 'password_length_error_message'.tr()),
    ]);
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const BackLeadingIcon(),
        title: Text(
          'sign_up'.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SignUpBloc, BaseState<User>>(
        bloc: _signUpBloc,
        listener: (BuildContext context, state) {
          if (state.isInProgress) {
            startLoading();
          } else if (state.isFailure) {
            stopLoading();
            showError(failure: state.failure, isFloating: true);
          } else if (state.isSuccess) {
            stopLoading();
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            final image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              _updatedImage = File(image.path);
                            }

                            setState(() {});
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: _updatedImage == null
                                    ? const Icon(Icons.camera)
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          _updatedImage!,
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: _firstNameFormFieldKey,
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'first_name'.tr(),
                          labelText: 'first_name'.tr(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'field_required_message'.tr();
                          }

                          return null;
                        },
                        onChanged: (text) {
                          _firstNameFormFieldKey.currentState!.validate();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          key: _lastNameFormFieldKey,
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            hintText: 'last_name'.tr(),
                            labelText: 'last_name'.tr(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'field_required_message'.tr();
                            }

                            return null;
                          },
                          onChanged: (text) {
                            _lastNameFormFieldKey.currentState!.validate();
                          },
                        ),
                      ),
                      TextFormField(
                        key: _emailFormFieldKey,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'example@email.com',
                          labelText: 'email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          _emailFormFieldKey.currentState!.validate();
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'field_required_message'.tr();
                          }
                          if (!EmailValidator(
                                  errorText: 'invalid_email_error_message'.tr())
                              .isValid(text.toLowerCase().trim())) {
                            return 'invalid_email_error_message'.tr();
                          }

                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                        ),
                        child: CustomDropDownWidget<String>(
                          label: 'gender'.tr(),
                          onChange: (val) {
                            setState(() {
                              _genderTypeAsString = val;
                              _gender = _gender
                                  .fromStringToGenderType(_genderTypeAsString!);
                            });
                          },
                          onRetry: () {},
                          options: Gender.values
                              .map((e) => e.toShortString())
                              .toList(),
                          disabled: false,
                          selectedOption: _genderTypeAsString?.split('.').last,
                          hint: 'gender'.tr(),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _dateOfBirthController,
                        decoration: InputDecoration(
                          hintText: 'date_of_birth'.tr(),
                          hintStyle: TextStyle(color: Theme.of(context)
                              .colorScheme.secondary),
                          suffixIcon: Icon(
                            Icons.calendar_month_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () async {
                          DateTime? date =
                              await presentDatePicker(context, DateTime.now());
                          if (date != null) {
                            setState(() {
                              dateOfBirth = date;
                              _dateOfBirthController.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                        ),
                        child: PasswordControl(
                          labelText: 'password'.tr(),
                          controller: _passwordController,
                          validator: _passwordValidator,
                        ),
                      ),
                      PasswordControl(
                        labelText: 'confirm_password'.tr(),
                        controller: _confirmPasswordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'field_required_message'.tr();
                          }
                          if (!MinLengthValidator(8,
                                  errorText:
                                      'password_length_error_message'.tr())
                              .isValid(text.toLowerCase())) {
                            return 'password_length_error_message'.tr();
                          }

                          if (!RequiredValidator(
                                  errorText: 'field_required_message'.tr())
                              .isValid(text.toLowerCase())) {
                            return 'field_required_message'.tr();
                          }
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return 'passwords_did_not_match'.tr();
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 12,
                        ),
                        child: Text(
                          'phone_number'.tr(),
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      PhoneNumberControl(
                        phoneController: _phoneController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            _signUpBloc.add(SignUpRequested(
              email: _emailController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              phone: _phoneController.text,
              password: _passwordController.text,
              gender: _gender,
              dateOfBirth: dateOfBirth,
              profileImage: _updatedImage,
            ));
          },
          child: const Text('sign_up').tr(),
        ),
      ),
    );
  }
}
