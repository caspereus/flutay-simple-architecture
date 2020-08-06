import 'package:amar_bank_test/core/dto/registration_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewDataPage extends StatelessWidget {
  final RegistrationData _registrationData;

  ReviewDataPage({@required RegistrationData registrationData})
      : _registrationData = registrationData;

  static Route route(RegistrationData registrationData) {
    return MaterialPageRoute<void>(
      builder: (_) => ReviewDataPage(
        registrationData: registrationData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Review Data"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListBody(
              children: <Widget>[
                _buildTitleData(
                  "Personal Data",
                ),
                _buildFieldData(
                    "Nation ID", _registrationData.personalData.nationId.value),
                _buildFieldData(
                    "Full Name", _registrationData.personalData.fullName.value),
                _buildFieldData("Bank Account No",
                    _registrationData.personalData.bankAccountNo.value),
                _buildFieldData("Education",
                    _registrationData.personalData.education.value),
                _buildFieldData("Date of Birth",
                    _registrationData.personalData.dateOfBirth.value),
                _buildTitleData("Address Data"),
                _buildFieldData("Domicile Address",
                    _registrationData.addressData?.domicileAddress?.value),
                _buildFieldData("Housing Type",
                    _registrationData.addressData?.housingType?.value),
                _buildFieldData("No", _registrationData?.addressData?.no?.value),
                _buildFieldData(
                    "Province", _registrationData.addressData?.province?.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleData(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _buildFieldData(String title, String value) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          ),
          Container(
            height: 5,
          ),
          Text(
            value ?? "",
            style: TextStyle(fontSize: 14),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
