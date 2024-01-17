import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_cubit.dart';
import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_states.dart';
import 'package:banking_app/Modules/Receiver%20Screen/receiver_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenderScreen extends StatelessWidget {
  final int senderId;
  SenderScreen({super.key, required this.senderId});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 13, 71),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 100.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Id : ${HomePageCubit.get(context).usersList[senderId].id}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                      child: Divider(
                        color: Color.fromARGB(255, 28, 13, 71),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Name : ${HomePageCubit.get(context).usersList[senderId].name}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                      child: Divider(
                        color: Color.fromARGB(255, 28, 13, 71),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Email : ${HomePageCubit.get(context).usersList[senderId].email}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                      child: Divider(
                        color: Color.fromARGB(255, 28, 13, 71),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Current Balance : ${HomePageCubit.get(context).usersList[senderId].currentBalance}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 28, 13, 71),
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 13, 71),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            scaffoldKey.currentState?.showBottomSheet(
                              (context) => Container(
                                height: 160.0,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: amountController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text('Amount'),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if(value == null) {
                                          return 'this field should not be empty';
                                        }
                                        if(int.parse(value) > HomePageCubit.get(context).usersList[senderId].currentBalance!){
                                          return 'There is not enough money';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Container(
                                      height: 40.0,
                                      width: double.infinity,
                                      color: const Color.fromARGB(255, 28, 13, 71),
                                      child: TextButton(
                                        child: const Text(
                                          'Transfer',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: (){
                                          if(_formKey.currentState!.validate())
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReceiverScreen(senderId: senderId, transferAmount: int.parse(amountController.text),),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 20.0
                            );
                          },
                          child: const Text(
                            'Transfere Money',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
