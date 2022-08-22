// // ignore_for_file: prefer_const_constructors_in_immutables
//
// part of 'cardandpin_cubit.dart';
//
// abstract class CardandpinState extends Equatable {
//   const CardandpinState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CardandpinInitial extends CardandpinState {}
//
// class CardandPinErrorCode extends CardandpinState {
//   final String errorCode;
//   final CardandPinModel cardandPinModel;
//   CardandPinErrorCode(this.errorCode, this.cardandPinModel);
//   @override
//
//   // TODO: implement props
//   List<Object> get props => [errorCode, cardandPinModel];
// }
//
// class StateLoading extends CardandpinState {}
//
// class GetCardStateSuccess extends CardandpinState {
//   final CardandPinModel cardandPinModel;
//
//   GetCardStateSuccess(this.cardandPinModel);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [cardandPinModel];
// }
//
// class GetCreatePin extends CardandpinState {
//   final String errorCode;
//   final CardandPinModel cardandPinModel;
//
//   GetCreatePin(this.errorCode, this.cardandPinModel);
//   @override
//   // TODO: implement props
//   List<Object> get props => [errorCode, cardandPinModel];
// }
//
// class ActivateCardStateSuccess extends CardandpinState {
//   final CardandPinModel cardandPinModel;
//
//   ActivateCardStateSuccess(this.cardandPinModel);
//
//   @override
//   List<Object> get props => [cardandPinModel];
// }
//
// class UpdateCardStateSuccess extends CardandpinState {
//   final CardandPinModel cardandPinModel;
//
//   UpdateCardStateSuccess(this.cardandPinModel);
//
//   @override
//   List<Object> get props => [cardandPinModel];
// }
//
// class StateFailed extends CardandpinState {
//   final String error;
//
//   StateFailed(this.error);
//   @override
//   List<Object> get props => [error];
// }
//
// class GetReceiptEmailStateSuccess extends CardandpinState {
//   final ReceiptEmailModel receiptEmailModel;
//
//   GetReceiptEmailStateSuccess(this.receiptEmailModel);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [receiptEmailModel];
// }
//
// class SendEmailStateSuccess extends CardandpinState {
//   final ReceiptEmailModel receiptEmailModel;
//
//   SendEmailStateSuccess(this.receiptEmailModel);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [receiptEmailModel];
// }
