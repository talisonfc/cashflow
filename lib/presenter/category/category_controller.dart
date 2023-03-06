import 'package:cashflow/domain/domain.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'category.dart';

class CategoryController extends GetxController with StateMixin<CategoryState> {
  final IGetCategories getCategories;
  final IUpdateCategories updateCategories;
  final IDeleteCategoryById deleteCategoryById;

  CategoryController(
      {required this.getCategories,
      required this.updateCategories,
      required this.deleteCategoryById});

  final isLoading = false.obs;

  final form = FormGroup({'categories': fb.array<FormGroup>([])});

  FormArray<FormGroup> get formArray =>
      form.control('categories') as FormArray<FormGroup>;

  List<CategoryEntity> get currentValues => formArray.value!
      .map((fg) => CategoryEntity(
          id: fg!.control('id').value, name: fg.control('name').value))
      .toList();

  @override
  void onInit() async {
    super.onInit();
    final categories = await getCategories();
    formArray.value = categories.map<FormGroup>((cat) {
      return fb.group({
        'id': FormControl<String>(value: cat.id),
        'name': FormControl<String>(
            value: cat.name, validators: [Validators.required]),
      });
    }).toList();
    change(CategoryState.success(categories: categories),
        status: RxStatus.success());
  }

  Future<void> save() async {
    isLoading.value = true;
    final categories = await updateCategories(currentValues);
    categories.asMap().forEach((index, cat) {
      formArray.value![index]!.control('id').value = cat.id;
    });
    change(CategoryState.success(categories: categories),
        status: RxStatus.success());
    isLoading.value = false;
  }

  Future<void> deleteByIndex(int index) async {
    final item = formArray.value![index];
    final id = item!.control('id').value;
    final result = await deleteCategoryById(id);
    if(result){
      formArray.removeAt(index);
    }
  }
}
