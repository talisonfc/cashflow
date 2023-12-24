import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/presenter/origin/origin.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OriginController extends GetxController with StateMixin {
  final IGetOrigins getOrigins;
  final IUpdateOrigins updateOrigins;
  final IDeleteOriginById deleteOriginById;

  OriginController(
      {required this.getOrigins,
      required this.updateOrigins,
      required this.deleteOriginById});

  final form = FormGroup({'origins': fb.array<FormGroup>([])});

  final isLoading = false.obs;

  FormArray<FormGroup> get formArray =>
      form.control('origins') as FormArray<FormGroup>;

  List<OriginEntity> get currentValues => formArray.value!
      .map((fg) => OriginEntity(
          id: fg!.control('id').value, name: fg.control('name').value))
      .toList();

  @override
  void onInit() async {
    super.onInit();
    final origins = await getOrigins();
    formArray.value = origins.map<FormGroup>((origin) {
      return fb.group({
        'id': FormControl<String>(value: origin.id),
        'name': FormControl<String>(
            value: origin.name, validators: [Validators.required]),
      });
    }).toList();
    change(OriginState.success(origins: origins), status: RxStatus.success());
  }

  Future<void> save() async {
    isLoading.value = true;
    final origins = await updateOrigins(currentValues);
    origins.asMap().forEach((index, cat) {
      formArray.value![index]!.control('id').value = cat.id;
    });
    change(OriginState.success(origins: origins), status: RxStatus.success());
    isLoading.value = false;
  }

  Future<void> deleteByIndex(int index) async {
    final item = formArray.value![index];
    final id = item!.control('id').value;
    final result = await deleteOriginById(id);
    if (result) {
      formArray.removeAt(index);
    }
  }
}
