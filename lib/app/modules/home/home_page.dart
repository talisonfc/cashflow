import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetView<CashFlowRepository> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BioS Diagnósticos',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          CashFlowRoutes.toWorkspace();
                        },
                        child: Text('Acesso restrito'),
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16))),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Agendar exame'),
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                      )
                    ],
                  )
                ],
              )),
          Container(
            color: Colors.blue,
            child: Wrap(
              children: [
                'Resultados de exames',
                'Exames oferecidos',
                'Convênios',
                'Unidades',
                'Fale conosco',
                'Mais opções'
              ].map((e) {
                return TextButton(
                    onPressed: () {},
                    child: Text(
                      e,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ));
              }).toList(),
            ),
          ),
          Container(
            height: 300,
            color: Colors.grey[300],
            child: Center(
              child: Text('Carroseu'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(
              'Noticias',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              primary: false,
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    color: Colors.blue[100],
                    child: Center(child: Text('Noticia $index'),),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );

    
  }
}
