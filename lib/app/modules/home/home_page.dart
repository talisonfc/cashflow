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
                          CashFlowRoutes.toAuth();
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
            color: Colors.blue[300],
            child: Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: 700,
                    child: RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                          children: [
                            TextSpan(
                                text: 'TUDO QUE VOCÊ PRECISA SABER SOBRE '),
                            TextSpan(
                                text: 'OS TESTES DE COVID-19\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Agente cuida, ',
                                style: TextStyle(fontSize: 20)),
                            TextSpan(
                                text: 'você confia',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ]),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Saiba mais'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Container(
                  width: 200,
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'NOTÍCIAS\n',
                                style:
                                    TextStyle(fontSize: 24, color: Colors.red)),
                            TextSpan(text: 'Confira as nossas novidades!')
                          ],
                        ),
                      ),
                      Container(
                          width: 80,
                          child: Divider(thickness: 4, color: Colors.red)),
                      SizedBox(
                        height: 16,
                        width: 16,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: Text('Ver todas notícias'))
                    ],
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: ListView(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(2, (index) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Container(
                                  child: Placeholder(),
                                )),
                                SizedBox(height: 8,),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            text:
                                                'Horário de funcionamento - Feriado 25 de Janeiro / Aniversário de SP\n'),
                                        TextSpan(
                                            text:
                                                'Confira os horários de funcionamento e coleta das unidades durante o feriado de 25 de janeiro.')
                                      ]),
                                ),
                                SizedBox(height: 8,),
                                InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Leia mais',
                                      style:
                                          TextStyle(color: Colors.red),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.black,
            child: Center(
              child: Builder(builder: (context) {
                final textStyle = Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      MediaInfo(Icons.facebook, 'biosdiagnostico',
                          textStyle: textStyle),
                      MediaInfo(Icons.email, 'biosdiagnostico@gmail.com',
                          textStyle: textStyle),
                      MediaInfo(Icons.phone, '(83) 91828-9292',
                          textStyle: textStyle),
                      MediaInfo(Icons.location_on,
                          'Rua Francisco Leão Veloso, SN, Uiraúna-PB, 58915-000',
                          textStyle: textStyle)
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget MediaInfo(IconData iconData, String description,
      {TextStyle? textStyle, Color textColor = Colors.white}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Icon(
          iconData,
          color: textColor,
        ),
        Text(
          description,
          style: textStyle,
        )
      ],
    );
  }
}
