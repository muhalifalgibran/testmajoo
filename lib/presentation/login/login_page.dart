import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/data/models/user.dart';
import 'package:majootestcase/presentation/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/presentation/login/register_page.dart';
import 'package:majootestcase/utils/app_style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocLoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => HomeBlocCubit()..fetchingData(),
                  child: HomeBlocScreen(),
                ),
              ),
            );
          } else if (state is AuthBlocFailedToLogginState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Login gagal'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: colorBlue,
                  ),
                ),
                Text(
                  'Silahkan login terlebih dahulu',
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
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      width: double.infinity, height: 48),
                  child: ElevatedButton(
                    style: AppStyleWidget.btnOn(context),
                    onPressed: handleLogin,
                    child: Text(
                      'Login',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _register(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
                  return pattern.hasMatch(val) ? null : 'email is invalid';
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
          Navigator.of(context).push(
            MaterialPageRoute<RegisterPage>(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<AuthBlocCubit>(context),
                child: RegisterPage(),
              ),
            ),
          );
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.text;
    final _password = _passwordController.text;
    if (formKey.currentState?.validate() == false &&
        _email != '' &&
        _password != '') {
      User user = User(
        email: _email,
        password: _password,
      );
      BlocProvider.of<AuthBlocCubit>(context).getUser();
      BlocProvider.of<AuthBlocCubit>(context).loginUser(user);
    }
  }
}
