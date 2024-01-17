abstract class HomePageStates{}

class HomePageInitialState extends HomePageStates{}

class CreateDatabaseLoadingState extends HomePageStates{}
class CreateDatabaseSuccessState extends HomePageStates{}
class CreateDatabaseErrorState extends HomePageStates{}

class CreateUsersTableSuccessState extends HomePageStates{}
class CreateUsersTableErrorState extends HomePageStates{}

class CreateTransfersTableSuccessState extends HomePageStates{}
class CreateTransfersTableErrorState extends HomePageStates{}

class InsertSomeUsersSuccessState extends HomePageStates{}
class InsertSomeUsersErrorState extends HomePageStates{}

class GetDataFromDatabaseLoadingState extends HomePageStates{}
class GetDataFromUsersTableSuccessState extends HomePageStates{}
class GetDataFromUsersTableErrorState extends HomePageStates{}
class GetDataFromTransfersTableSuccessState extends HomePageStates{}
class GetDataFromTransfersTableErrorState extends HomePageStates{}

class InsertTransferLoadingState extends HomePageStates{}
class InsertTransferSuccessState extends HomePageStates{}
class InsertTransferErrorState extends HomePageStates{
  final String errorMessage;
  InsertTransferErrorState(this.errorMessage);
}

class UpdateCurrentBalanceLoadingstate extends HomePageStates{}
class UpdateSnderCurrentBalanceSuccessstate extends HomePageStates{}
class UpdateSnderCurrentBalanceErrorstate extends HomePageStates{}
class UpdateReceiverCurrentBalanceSuccessstate extends HomePageStates{}
class UpdateReceiverCurrentBalanceErrorstate extends HomePageStates{}