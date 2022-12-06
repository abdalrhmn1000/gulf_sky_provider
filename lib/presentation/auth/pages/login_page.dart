import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/auth/blocs/login/login_bloc.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/password_control.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ScreenLoader<LoginPage>, ScreenUtils {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailFormFieldKey =
      GlobalKey<FormFieldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late MultiValidator _passwordValidator;
  final LoginBloc _loginBloc = getIt<LoginBloc>();

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
      body: SafeArea(
        child: BlocListener<LoginBloc, BaseState<User>>(
          bloc: _loginBloc,
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Assets.images.logo.image(
                    width: 224,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AutoSizeText(
                    'login_page_message'.tr(),
                    maxFontSize: 16,
                    minFontSize: 8,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    key: _emailFormFieldKey,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'email_address'.tr(),
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
                  const SizedBox(
                    height: 20,
                  ),
                  PasswordControl(
                    labelText: 'password'.tr(),
                    controller: _passwordController,
                    validator: _passwordValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (!_formKey.currentState!.validate()) return;
                        _loginBloc.add(
                          LoginRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          ),
                        );
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ).tr(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildSignUpRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'do_not_have_an_account'.tr(),
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        InkWell(
          onTap: () {
            AutoRouter.of(context).push(const SignUpPageRoute());
          },
          child: Text(
            'sign_up'.tr(),
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
