import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FirstScreen());
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isCheck = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  final _valueKey = GlobalKey<FormState>();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          decoration: mainStyle(),
          child: SingleChildScrollView(
            child: Form(
              key: _valueKey,
              child: Column(
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      height: 150,
                      color: Colors.blue.shade400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/Client_Feedback.png', width: 225),
                  const SizedBox(height: 20),
                  inputsSection(),
                  checkboxListTile(),
                  const SizedBox(height: 30),
                  elevatedButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration mainStyle() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade100,
          Colors.blue.shade50,
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  ElevatedButton elevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        fixedSize: Size(MediaQuery.of(context).size.width - 20, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => btnFunc(),
      child: const Text(
        'ثبت نام',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'shabnam'),
      ),
    );
  }

  btnFunc() {
    if (_valueKey.currentState!.validate() && isCheck == true) {
    } else {
      showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: ErrorDialog(),
        ),
      );
    }
  }

  CheckboxListTile checkboxListTile() {
    return CheckboxListTile(
      value: isCheck,
      activeColor: Colors.blue.shade400,
      onChanged: (value) {
        setState(() {
          if (isCheck) {
            isCheck = false;
          } else {
            isCheck = true;
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        'با شرایط و قوانین موافقم',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'shabnam',
        ),
      ),
    );
  }

  Padding inputsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          TextFormField(
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'ایمیل نمی تواند خالی باشد';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: textFieldDecoration(
              icon: Icons.person_outlined,
              label: 'نام کاربری',
              isPassword: false,
            ),
            controller: _nameController,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: textFieldDecoration(
              icon: Icons.phone_outlined,
              label: 'شماره تماس',
              isPassword: false,
            ),
            controller: _phoneController,
            maxLength: 11,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'ایمیل نمی تواند خالی باشد';
              }
              if (value.startsWith('09')) {
                return 'شماره تماس وارد شده اشتباه است';
              }
              if (value.length < 11) {
                return 'شماره تماس وارد شده معتبر نیست';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: textFieldDecoration(
              icon: Icons.email_outlined,
              label: 'ایمیل',
              isPassword: false,
            ),
            controller: _emailController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'ایمیل نمی تواند خالی باشد';
              }
              if (value.endsWith('.com')) {
                return 'ایمیل وارد شده اشتباه است';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: textFieldDecoration(
              icon: Icons.lock_outline,
              label: 'رمز عبور',
              isPassword: true,
            ),
            controller: _passwordController,
            obscureText: isShow,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'ایمیل نمی تواند خالی باشد';
              }
              if (value.length < 6) {
                return 'رمز عبور اشتباه است';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  AlertDialog ErrorDialog() {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text(
        'خطا',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'shabnam'),
      ),
      content: const Text(
        'مقادیر ورودی دچار مشکل شدند',
        style: TextStyle(fontFamily: 'shabnam'),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade400,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'بازگشت',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'shabnam'),
          ),
        ),
      ],
    );
  }

  textFieldDecoration({required String label, required IconData icon, required bool isPassword}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      prefixIcon: Icon(icon),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: () {
                setState(() {
                  if (isShow) {
                    isShow = false;
                  } else {
                    isShow = true;
                  }
                });
              },
              icon: Icon(isShow ? Icons.visibility_outlined : Icons.visibility_off_outlined),
            )
          : null,
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      labelStyle: const TextStyle(
        fontFamily: 'shabnam',
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      counter: const SizedBox.shrink(),
      // border: InputBorder.none,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
