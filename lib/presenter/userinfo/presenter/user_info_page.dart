import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'user_info_controller.dart';

class UserInfoPage extends GetView<UserInfoController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 16, right: 16, bottom: 16),
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              ClipOval(
                                  child: Image.network(
                                state?.photoUrl ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Icon(
                                      Icons.person_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  );
                                },
                              )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Text(state?.email ?? ''),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  // padding: EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    ListTile(
                      leading: Icon(Icons.category_outlined),
                      title: Text('Categorias'),
                      onTap: () {
                        Get.toNamed(RouteName.category);
                      },
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.spoke_outlined),
                      title: Text('Contextos'),
                      onTap: () {
                        Get.toNamed(RouteName.context);
                      },
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.account_balance_outlined),
                      title: Text('Origens'),
                      onTap: () {
                        Get.toNamed(RouteName.origin);
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Sair do aplicativo')),
              )
            ],
          ),
        ));
  }
}
