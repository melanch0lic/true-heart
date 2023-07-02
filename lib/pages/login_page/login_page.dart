import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(106, 102, 99, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.98,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                        width: 300,
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        )),
                  )),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Имя пользователя', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const TextField(
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Потвердить',
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
