import 'package:bmitserp/model/payslip.dart';
import 'package:bmitserp/model/payslipattribute.dart';
import 'package:flutter/cupertino.dart';

class PaySlipProvider with ChangeNotifier {
  List<PaySlip> _paySlipList = [
    PaySlip(
        id: "#ASD46546", date: "2022-01-05", payment: "20000", slip: "slip"),
    PaySlip(
        id: "#ASD46543", date: "2022-02-05", payment: "20000", slip: "slip"),
    PaySlip(id: "#ASD3434", date: "2022-03-05", payment: "20000", slip: "slip"),
    PaySlip(
        id: "#ASD423426", date: "2022-04-05", payment: "20000", slip: "slip"),
    PaySlip(
        id: "#ASD454546", date: "2022-05-05", payment: "20000", slip: "slip"),
    PaySlip(
        id: "#ASD45446", date: "2022-06-05", payment: "20000", slip: "slip"),
  ];

  List<PaySlip> get paySlipList {
    return [..._paySlipList];
  }

  List<PaySlipAttribute> _earningList = [
    PaySlipAttribute(title: "Basic Salary", value: 50000.5),
    PaySlipAttribute(title: "House Rent Allowance", value: 5000),
    PaySlipAttribute(title: "Conveyance", value: 8000),
    PaySlipAttribute(title: "Other Allowance", value: 3000),
  ];

  List<PaySlipAttribute> get earningList {
    return [..._earningList];
  }

  double getTotalEarning() {
    var value = 0.0;

    for (var item in _earningList) {
      value += item.value;
    }

    return value;
  }

  List<PaySlipAttribute> _deductionList = [
    PaySlipAttribute(title: "Tax Deducted at Source (T.D.S.)", value: 500.10),
    PaySlipAttribute(title: "Provident Fund", value: 1500),
    PaySlipAttribute(title: "ESI", value: 500),
    PaySlipAttribute(title: "Loan", value: 0),
  ];

  List<PaySlipAttribute> get deductionList {
    return [..._deductionList];
  }

  double getTotalDeduction() {
    var value = 0.0;

    for (var item in _deductionList) {
      value += item.value;
    }

    return value;
  }
}
