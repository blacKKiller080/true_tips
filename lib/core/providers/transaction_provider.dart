import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/core/models/dtos/pagination_dto.dart';
import 'package:true_tips_mobile/core/models/requests/payroll_api_request.dart';
import 'package:true_tips_mobile/core/models/responses/fee_response.dart';
import 'package:true_tips_mobile/core/models/responses/payroll_api_response.dart';
import 'package:true_tips_mobile/core/repositories/transaction_repository.dart';

class TransactionProvider with ChangeNotifier {
  TransactionRepository transactionRepository;

  TransactionProvider(this.transactionRepository);

  Future<PaginationDto> transactions(
      {String? date, int? limit, int? offset = 0}) async {
    return transactionRepository.transactions(
        date: date, limit: limit, offset: offset);
  }

  Future<FeeResponse> fee() async {
    return transactionRepository.fee();
  }

  Future<PayrollApiResponse> payroll(String uid, String amount) async {
    return transactionRepository
        .payroll(PayrollApiRequest(uid: uid, amount: amount));
  }
}
