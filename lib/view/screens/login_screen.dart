import 'package:contact_demo/helpers/regex_rule.dart';
import 'package:contact_demo/providers/login.dart';
import 'package:contact_demo/view/theme/hicon_icons.dart';
import 'package:contact_demo/view/theme/snackbar.dart';
import 'package:contact_demo/view/widgets/shimmer/modal_load.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../theme/images.dart';
import '../theme/spacing.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: ModalLoad(
        loadingStatus: provider.loadingStateChange,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(spacing2x),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      logo,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: spacing5x,
                    ),
                    Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: spacing2x,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'No Account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Make Account',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: spacing2x,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        prefixIcon: Icon(
                          Hicon.profile_1,
                        ),
                      ),
                      onChanged: (val) => provider.email = val,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Field Required';
                        }
                        return RegExp(emailValidationRule).hasMatch(val)
                            ? null
                            : 'Wrong email format';
                      },
                    ),
                    const SizedBox(
                      height: spacing2x,
                    ),
                    TextFormField(
                      obscureText: provider.isObscurePassword,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        prefixIcon: const Icon(
                          Hicon.lock_1,
                        ),
                        suffixIcon: provider.isObscurePassword
                            ? IconButton(
                          onPressed: () => provider.showPassword(),
                          icon: const Icon(
                            Hicon.hide,
                          ),
                        )
                            : IconButton(
                          onPressed: () => provider.hidePassword(),
                          icon: const Icon(
                            Hicon.show,
                          ),
                        ),
                      ),
                      onChanged: (val) => provider.password = val,
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Field Required';
                        }
                        return null;
                      },
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: const Text('Forgot Password?'),
                    //   ),
                    // ),
                    const SizedBox(
                      height: spacing3x,
                    ),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () => {
                          if (Form.of(context).validate())
                            {
                              provider.submit(
                                email: provider.email!,
                                password: provider.password!,
                                onSuccess: () {},
                                onFailure: (message) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarExtend.error(
                                      context,
                                      content: Text(
                                        message ?? 'error',
                                      ),
                                    ),
                                  );
                                },
                              )
                            }
                        },
                        child: const Text('Next'),
                      );
                    }),
                    const SizedBox(
                      height: spacing2x,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () => provider.submitGoogle(
                            onSuccess: () {},
                            onFailure: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarExtend.error(
                                  context,
                                  content: Text(
                                    message ?? 'error',
                                  ),
                                ),
                              );
                            },
                          ),
                          icon: Icon(MdiIcons.google, color: Colors.redAccent),
                        ),
                        IconButton(
                          onPressed: () => provider.submitFacebook(
                            onSuccess: () {},
                            onFailure: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarExtend.error(
                                  context,
                                  content: Text(
                                    message ?? 'error',
                                  ),
                                ),
                              );
                            },
                          ),
                          icon: Icon(
                            MdiIcons.facebook,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

