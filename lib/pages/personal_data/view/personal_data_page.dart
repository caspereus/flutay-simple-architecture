import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_bloc.dart';
import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDataPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PersonalDataPage());
  }

  // ignore: close_sinks
  final PersonalDataBloc bloc = PersonalDataBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Data"),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: PersonalDataForm(),
      ),
    );
  }
}

