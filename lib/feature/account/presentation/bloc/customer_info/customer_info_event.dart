part of 'customer_info_bloc.dart';

abstract class CustomerInfoEvent extends Equatable {
  const CustomerInfoEvent();
  @override
  List<Object> get props => [];
}

class CustomerInfoFromLocalEvent extends CustomerInfoEvent {
  const CustomerInfoFromLocalEvent();
}

class CustomerInfoFromRemoteEvent extends CustomerInfoEvent {
  const CustomerInfoFromRemoteEvent();
}

class CustomerInfoSetEvent extends CustomerInfoEvent {
  const CustomerInfoSetEvent(this.data);
  final CustomerInfoModel data;
  @override
  List<Object> get props => [];
}
