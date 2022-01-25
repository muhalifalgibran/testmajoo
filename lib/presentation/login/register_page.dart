import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/data/models/user.dart';
import 'package:majootestcase/presentation/extra/loading.dart';
import 'package:majootestcase/presentation/home_bloc/home_bloc_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _emailController = TextController();
  final _usernameController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  AuthBlocCubit authBlocCubit = AuthBlocCubit();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
        body: BlocListener<AuthBlocCubit, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthBlocLoadedState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Register Berhasil'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => HomeBlocCubit()..fetchingData(),
                      child: HomeBlocScreen(),
                    ),
                  ),
                );
              } else if (state is AuthBlocLoadingState) {
                return LoadingIndicator();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // color: colorBlue,
                      ),
                    ),
                    Text(
                      'Silahkan data kamu terlebih dahulu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    _form(),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      text: 'Daftar',
                      onPressed: () => handleRegister(context),
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    _register(context),
                  ],
                ),
              ),
            )));
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            child: CustomTextFormField(
              context: context,
              controller: _usernameController,
              hint: 'username',
              label: 'Username',
              mandatory: true,
            ),
          ),
          Container(
            child: CustomTextFormField(
              context: context,
              controller: _emailController,
              isEmail: true,
              hint: 'Example@123.com',
              label: 'Email',
              validator: (val) {
                final pattern =
                    new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
                if (val != null)
                  return pattern.hasMatch(val)
                      ? null
                      : 'Masukkan e-mail yang valid';
              },
            ),
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _register(context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
        },
        child: RichText(
          text: TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'kembali ke Login',
                ),
              ]),
        ),
      ),
    );
  }

  void handleRegister(context) async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    final _username = _usernameController.value;
    if (formKey.currentState?.validate() == true &&
        _email != null &&
        _password != null &&
        _username != null) {
      User user = User(email: _email, password: _password, userName: _username);
      BlocProvider.of<AuthBlocCubit>(context).addUser(user);
    }
  }
}
