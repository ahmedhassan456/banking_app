import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../Cubits/Home Page Cubit/home_page_cubit.dart';
import '../Home Screen/home_screen.dart';

class ReceiverScreen extends StatelessWidget {
  final int senderId;
  final int transferAmount;
  const ReceiverScreen({super.key, required this.senderId, required this.transferAmount});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {
        if (state is InsertTransferSuccessState)
        {
          toastification.show(
            context: context,
            title: const Text('Transfer completed successfully'),
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomCenter,
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
          );
        }
        if(state is InsertTransferErrorState)
        {
          toastification.show(
            context: context,
            title: const Text('Error Occured'),
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomCenter,
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'choose receiver',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: HomePageCubit.get(context).usersList.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    itemBuilder: (context, index) => ConditionalBuilder(
                      builder: (context) => buildUserItem(context, index),
                      condition: index != senderId,
                      fallback: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildUserItem(BuildContext context,int index) {
    return InkWell(
      onTap: () {
        HomePageCubit.get(context).insertTransferInDatabase(senderId: senderId, receiverId: index, amount: transferAmount,);

        int senderCurrentBalance = HomePageCubit.get(context).usersList[senderId].currentBalance! - transferAmount;
        int receiverCurrentBalance = transferAmount + HomePageCubit.get(context).usersList[index].currentBalance!;
        HomePageCubit.get(context).updateCurrentBalance(
          senderId: senderId + 1,
          receiverId: index +1,
          senderCurrentBalance: senderCurrentBalance, 
          receiverCurrentBalance: receiverCurrentBalance,
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 28, 13, 71),
              radius: 25.0,
              child: Icon(
                Icons.person,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              '${HomePageCubit.get(context).usersList[index].name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
