import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/common_widgets/form_submit_button.dart';
import 'package:sign_in/common_widgets/platform_exception_alert_dialog.dart';
import 'package:sign_in/pages/sign_in/email_sign_in_bloc.dart';
import 'package:sign_in/pages/sign_in/email_sign_in_model.dart';
import 'package:sign_in/pages/sign_in/validators.dart';
import 'package:sign_in/services/auth.dart';

class EmailSignInFormWithBlock extends StatefulWidget
    with EmailAndPasswordValidators {
  EmailSignInFormWithBlock({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
          builder: (context, bloc, _) => EmailSignInFormWithBlock(
                bloc: bloc,
              )),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormWithBlockState createState() =>
      _EmailSignInFormWithBlockState();
}

class _EmailSignInFormWithBlockState extends State<EmailSignInFormWithBlock> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  Future<void> _submit() async {
    // in stateful widget the context is always available
    try {
      await widget.bloc.submit();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }

    // As the widget is thrown off the bloc stream will also be closed
    Navigator.of(context).pop();
  }

  void _toggleFormType() {
    // updating the stream
    // UI changes accordingly
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final _newfocus = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_newfocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final primaryText = model.formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = model.formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';

    // initially !model.isLoading is true
    bool _submitEnabled = widget.emailValidator.isValid(model.email) &&
        widget.passwordValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 12.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 12.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(secondaryText),
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool _showErrorText =
        model.submitted && !widget.passwordValidator.isValid(model.password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: _showErrorText ? widget.inValidPasswordErrorText : null,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => widget.bloc.updateWith(password: password),
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool _showErrorText =
        model.submitted && !widget.emailValidator.isValid(model.email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'name@example.com',
        errorText: _showErrorText ? widget.inValidEmailErrorText : null,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: (email) => widget.bloc.updateWith(email: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
