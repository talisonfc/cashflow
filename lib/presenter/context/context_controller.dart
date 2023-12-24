import 'package:cashflow/domain/_exports.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'context.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ContextController extends GetxController with StateMixin<ContextState> {
  final IGetContexts getContexts;
  final IUpdateContexts updateContexts;
  final IDeleteContextById deleteContextById;

  ContextController({
    required this.getContexts,
    required this.updateContexts,
    required this.deleteContextById,
  });

  final isLoading = false.obs;

  final form = FormGroup({'contexts': fb.array<FormGroup>([])});

  FormArray<FormGroup> get formArray =>
      form.control('contexts') as FormArray<FormGroup>;

  @override
  void onInit() async {
    super.onInit();

    final contexts = await getContexts();
    formArray.value = contexts.map<FormGroup>((ctx) {
      return fb.group({
        'id': FormControl<String>(value: ctx.id),
        'name': FormControl<String>(
            value: ctx.name, validators: [Validators.required]),
      });
    }).toList();
    change(ContextState.success(contexts: contexts),
        status: RxStatus.success());
  }

  Future<void> save() async {
    isLoading.value = true;
    final contexts = await updateContexts(formArray.value!
        .map((fg) => ContextEntity(
            id: fg!.control('id').value, name: fg.control('name').value))
        .toList());
    contexts.asMap().forEach((index, ctx) {
      formArray.value![index]!.control('id').value = ctx.id;
    });
    change(ContextState.success(contexts: contexts),
        status: RxStatus.success());
    isLoading.value = false;
  }

  Future<void> deleteByIndex(int index) async {
    final item = formArray.value![index];
    final id = item!.control('id').value;
    final result = await deleteContextById(id);
    if (result) {
      formArray.removeAt(index);
    }
  }
}
