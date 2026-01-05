import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/core/repos/property_repo.dart';
import 'package:rent/models/property_model.dart';

import '../../models/my_properties_booking_model.dart';

part 'properties_state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  PropertiesCubit() : super(PropertiesState.init());

  PropertyRepo propertyRepo = PropertyRepo();

  Future<void> getProperties() async {
    try {
      var properties = await propertyRepo.getProperties();
      emit(PropertiesState.success(properties));
    } catch (e) {
      emit(PropertiesState.error(e.toString()));
    }
  }

  // ---------------- NEW METHOD ----------------
  Future<void> getBookings(String propertyId) async {

    try {
      // 1. Fetch Pending
      var pending = await propertyRepo.getPendingBookings(propertyId);

      // 2. Fetch Current
      var current = await propertyRepo.getCurrentBookings(propertyId);

      // 3. Fetch Updates (Mocked/Empty for now)
      var updates = await propertyRepo.getUpdateRequests(propertyId);

      // 4. Emit Success with all lists
      emit(PropertiesState.bookingsSuccess(
        pending: pending,
        current: current,
        updates: updates,
        existingProperties: state.properties,
      ));
    } catch (e) {
      emit(PropertiesState.error(e.toString()));
    }
  }


}
// Future<void> postProperty(var body) async{
//   try{
//     var properties = await propertyRepo.postProperty(body);
//     emit(PropertiesState.success(properties));
//   }catch(e){
//     emit(PropertiesState.error(e.toString()));
//   }
// }