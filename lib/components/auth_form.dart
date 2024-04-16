import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/model/provider/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordControlle = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.login;
  bool _isLoading = false;
  bool _isObscured = true;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
        // _controller?.forward();
      } else {
        _authMode = AuthMode.login;
        // _controller?.reverse();
      }
    });
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ocrreu um Erro"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Fechar"),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isvalid = _formKey.currentState?.validate() ?? false;
    if (!isvalid) {
      return;
    }
    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    final auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showError(error.toString());
    } catch (error) {
      _showError("Ocorreu um erro inesperado!");
    }
    setState(() => _isLoading = false);
  }

  void _toggleObscurede() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  // AnimationController? _controller;
  // Animation<Size>? _heightAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(
  //       milliseconds: 300,
  //     ),
  //   );

  //   _heightAnimation = Tween(
  //     begin: const Size(double.infinity, 340),
  //     end: const Size(double.infinity, 400),
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _controller!,
  //       curve: Curves.linear,
  //     ),
  //   );

  //   _heightAnimation?.addListener(() => setState(() {}));
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller?.dispose();
  // }

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        height: _isLogin() ? 325 : 400,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordControlle,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _toggleObscurede();
                    },
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: _isObscured,
                validator: (_password) {
                  final password = _password ?? '';
                  if (_isLogin()) {
                    return null;
                  }
                  if (password.isEmpty || password.length < 5) {
                    return 'Informe uma senha valida';
                  }
                  return null;
                },
                onSaved: (password) => _authData['password'] = password ?? '',
              ),
              if (_isSignup())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirme Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: _isObscured,
                  validator: _isLogin()
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          if (password != _passwordControlle.text) {
                            return 'Senha não confere';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                  child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                ),
              const Spacer(),
              TextButton(
                onPressed: _isLoading ? null : _switchAuthMode,
                child:
                    Text(_isLogin() ? "DESEJA REGISTRAR?" : "JÁ POSSUE CONTA?"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
