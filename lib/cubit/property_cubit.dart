import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/property_model.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial()){
    getAllProperties();
  }

  // القائمة التي تحتوي كل الشقق (من النت أو أضفناها )
   final  List<PropertyModel> _properties = [];

  List<PropertyModel> get properties => _properties;

  // جلب البيانات (سنربطها بال API)
  void getAllProperties() {
    emit(PropertyLoading()); // إظهار لودينج


    //  API كود الاتصال بالسيرفر
    emit(PropertyUpdated(List.from(_properties)));
  }

  // إضافة شقة
  void addProperty(PropertyModel property) {
    _properties.add(property);
    // نحدث الواجهة بالقائمة الجديدة
    emit(PropertyUpdated(List.from(_properties)));
  }

  // تعديل الشقة
  void editProperty(String id, PropertyModel updated) {
    final index = _properties.indexWhere((p) => p.id == id);
    if (index != -1) {
      _properties[index] = updated;
      emit(PropertyUpdated(List.from(_properties)));
    }
  }

  void deleteProperty(String id) {
    _properties.removeWhere((p) => p.id == id);
    emit(PropertyUpdated(List.from(_properties)));
  }
}