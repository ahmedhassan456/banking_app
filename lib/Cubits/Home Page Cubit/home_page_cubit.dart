import 'dart:developer';
import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_states.dart';
import 'package:banking_app/Models/Transfers%20Model/transfers_model.dart';
import 'package:banking_app/Models/Users%20Model/users_model.dart';
import 'package:banking_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  Database? database;
  Future<void> createDatabase() async {
    emit(CreateDatabaseLoadingState());
    await openDatabase(
      'Banking.db',
      version: 1,
      onCreate: (db, version) async {
        // Create user table
        await db.execute(
          '''
          CREATE TABLE Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            current_balance DECIMAL(10, 2) DEFAULT 0.00
          );
          ''',
        ).then((value) {
          emit(CreateUsersTableSuccessState());
        }).catchError((error) {
          log('Create users table error: ${error.toString()}');
          emit(CreateUsersTableErrorState());
        });

        // create Transfers table
        await db.execute(
          '''
          CREATE TABLE Transfers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sender_id INTEGER,
            receiver_id INTEGER,
            amount DECIMAL(10, 2),
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (sender_id) REFERENCES User(id),
            FOREIGN KEY (receiver_id) REFERENCES User(id)
          );
          ''',
        ).then((value) {
          emit(CreateTransfersTableSuccessState());
        }).catchError((error) {
          log('Create transfers table error: ${error.toString()}');
          emit(CreateTransfersTableErrorState());
        });

        // insert some recoreds into user table
        await db.transaction((txn) async {
          await txn.rawInsert(
            '''
            INSERT INTO Users (name, email, current_balance) VALUES
            ('Ethan Johnson', 'ethanjohnson@example.com', 1000.00),
            ('Olivia Parker', 'oliviaparker@example.com', 1500.00),
            ('Liam Mitchell', 'liammitchell@example.com', 2000.00),
            ('Ava Bennett', 'avabennett@example.com', 7500.00),
            ('Noah Thompson', 'noahthompson@example.com', 1200.00),
            ('Emma Turner', 'emmaturner@example.com', 250000.00),
            ('Lucas Brooks', 'lucasbrooks@example.com', 1800000.00),
            ('Sophia Hayes', 'sophiahayes@example.com', 9000.00),
            ('Jackson Foster', 'jacksonfoster@example.com', 30000.00),
            ('Isabella Cooper', 'isabellacooper@example.com', 50000.00);
            ''',
          ).then((value) {
            emit(InsertSomeUsersSuccessState());
          }).catchError((error) {
            log('Insert Some Users error: ${error.toString()}');
            emit(InsertSomeUsersErrorState());
          });
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      myDb = database;
      emit(CreateDatabaseSuccessState());
    }).catchError((error) {
      log('Create Database error: ${error.toString()}');
      emit(CreateDatabaseErrorState());
    });
  }

  List<UsersModel> usersList = [];
  List<TransfersModel> transformsList = [];
  Future<void> getDataFromDatabase(Database db) async {
    emit(GetDataFromDatabaseLoadingState());
    await db.rawQuery('SELECT * FROM Users').then((value) {
      usersList = [];
      value.forEach((element) {
        usersList.add(UsersModel.fromJson(element));
      });
      log(usersList[0].currentBalance.toString());
      emit(GetDataFromUsersTableSuccessState());
    }).catchError((error) {
      log('Get data from database error: ${error.toString()}');
      emit(GetDataFromUsersTableErrorState());
    });

    await db.rawQuery('SELECT * FROM Transfers').then((value) {
      transformsList = [];
      value.forEach((element) {
        transformsList.add(TransfersModel.fromJson(element));
      });
      log(transformsList[0].timestamp.toString());
      emit(GetDataFromTransfersTableSuccessState());
    }).catchError((error) {
      log('Get data from database error: ${error.toString()}');
      emit(GetDataFromTransfersTableErrorState());
    });
  }

  Future<void> insertTransferInDatabase({
    required int senderId,
    required int receiverId,
    required int amount,
  }) async {
    emit(InsertTransferLoadingState());
    await myDb?.transaction((txn) async {
      await txn.rawInsert(
        '''
        INSERT INTO Transfers (sender_id, receiver_id, amount) VALUES
        ($senderId, $receiverId, $amount);
        ''',
        ).then((value) {
        log('insert Transfer successfully');
        emit(InsertTransferSuccessState());
      }).catchError((error) {
        log('insert Transfer failed: ${error.toString()}');
        emit(InsertTransferErrorState(error.toString()));
      });
    });
  }

  Future<void> updateCurrentBalance({
    required int senderId,
    required int receiverId,
    required int senderCurrentBalance,
    required int receiverCurrentBalance
  }) async 
  {
    emit(UpdateCurrentBalanceLoadingstate());
    await database?.update(
      'Users', 
      {'current_balance': double.parse(senderCurrentBalance.toStringAsFixed(2))},
      where: 'id = ?',
      whereArgs: [senderId],
      ).then((value) {
      emit(UpdateSnderCurrentBalanceSuccessstate());
    }).catchError((error){
      log('updateCurrentBalance failed: ${error.toString()}');
      emit(UpdateSnderCurrentBalanceErrorstate());
    });

    await database?.update(
      'Users', 
      {'current_balance': double.parse(receiverCurrentBalance.toStringAsFixed(2))},
      where: 'id = ?',
      whereArgs: [receiverId],
      ).then((value) {
      getDataFromDatabase(database!);
      emit(UpdateReceiverCurrentBalanceSuccessstate());
    }).catchError((error){
      log('updateCurrentBalance failed: ${error.toString()}');
      emit(UpdateReceiverCurrentBalanceErrorstate());
    });
  }

}
