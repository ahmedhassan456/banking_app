import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_cubit.dart';
import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_states.dart';
import 'package:banking_app/Modules/Sender%20Screen/sender_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Banking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: state is! GetDataFromDatabaseLoadingState,
              builder: (context) => ListView.separated(
                itemCount: HomePageCubit.get(context).usersList.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                itemBuilder: (context, index) => buildUserItem(context, index),
              ),
              fallback: (context) => const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildUserItem(context, index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SenderScreen(senderId: index),
        ));
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

