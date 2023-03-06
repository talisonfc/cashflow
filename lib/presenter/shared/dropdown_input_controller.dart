import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class DropdownInputController<T, V> extends GetxController
    with StateMixin<List<T>> {
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    load().then((items) {
      change(items, status: RxStatus.success());
    });
  }

  get items => (state ?? []).map<DropdownMenuItem<V>>((item) {
        return DropdownMenuItem(value: getValue(item), child: Text(getLabel(item)));
      }).toList();

  Future<List<T>> load();

  String getLabel(T item);

  V getValue(T item);
}
