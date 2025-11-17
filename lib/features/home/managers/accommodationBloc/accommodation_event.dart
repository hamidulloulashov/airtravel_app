part of 'accommodation_bloc.dart';

sealed class AccommodationEvent {}

final class FetchAccommodation extends AccommodationEvent {
  int id = 1;
  FetchAccommodation(this.id);
}
class FetchUmraTripDetail extends AccommodationEvent {
  final int tripId;
  FetchUmraTripDetail(this.tripId);
}