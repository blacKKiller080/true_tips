import 'package:true_tips_mobile/core/http/api_provider.dart';
import 'package:true_tips_mobile/core/models/dtos/pagination_dto.dart';
import 'package:true_tips_mobile/core/models/entities/transaction_entity.dart';
import 'package:true_tips_mobile/core/models/requests/payroll_api_request.dart';
import 'package:true_tips_mobile/core/models/responses/fee_response.dart';
import 'package:true_tips_mobile/core/models/responses/payroll_api_response.dart';
import 'package:true_tips_mobile/core/repositories/base_repository.dart';

class TransactionRepository extends BaseRepository {
  ApiClient httpClient;

  TransactionRepository(this.httpClient) : super(httpClient);

  Future<PaginationDto> transactions(
      {String? date, int? limit, int? offset}) async {
    String query = "";
    if (date != null) {
      query = queryPart(query, date, 'datePeriod');
    }
    if (limit != null) {
      query = queryPart(query, limit, 'limit');
    }
    if (offset != null) {
      query = queryPart(query, offset, 'offset');
    }
    return PaginationDto.fromJson(
        await this.httpClient.get(url('api/transactions/'), query: query),
        TransactionEntity.fromJson);
  }

  Future<FeeResponse> fee() async {
    var fee = FeeResponse.fromJson(await this.httpClient.get(url('api/fee/')));
    print(fee);
    return fee;
  }

  Future<PayrollApiResponse> payroll(PayrollApiRequest request) async {
    return PayrollApiResponse.fromJson(await this.httpClient.post(url('api/payroll/'), request));
  }
}
