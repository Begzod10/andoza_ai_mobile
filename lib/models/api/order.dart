import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

/// Backend order status (`app/schemas/order.py::OrderStatus`).
enum OrderStatus {
  @JsonValue('accepted')
  accepted,

  @JsonValue('gathering')
  gathering,

  @JsonValue('on_the_way')
  onTheWay,

  @JsonValue('delivered')
  delivered,
}

/// One line in a `POST /orders` request body. `materialId` is the backend
/// catalog material UUID when known, else null (free-text / synthetic item).
/// The server computes the order total from these lines.
@freezed
class OrderLineCreate with _$OrderLineCreate {
  const factory OrderLineCreate({
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') required String productName,
    required String unit,
    @JsonKey(name: 'unit_price_uzs') required int unitPriceUzs,
    required num quantity,
  }) = _OrderLineCreate;

  factory OrderLineCreate.fromJson(Map<String, dynamic> json) =>
      _$OrderLineCreateFromJson(json);
}

/// A persisted order line (`OrderLineOut`).
@freezed
class ServerOrderLine with _$ServerOrderLine {
  const factory ServerOrderLine({
    required String id,
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') required String productName,
    required String unit,
    @JsonKey(name: 'unit_price_uzs') required int unitPriceUzs,
    required num quantity,
  }) = _ServerOrderLine;

  factory ServerOrderLine.fromJson(Map<String, dynamic> json) =>
      _$ServerOrderLineFromJson(json);
}

/// A persisted order (`GET /orders` element / `OrderOut`). Newest first from
/// the list endpoint. `totalUzs` is server-computed.
@freezed
class ServerOrder with _$ServerOrder {
  const factory ServerOrder({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'dealer_name') required String dealerName,
    @JsonKey(name: 'total_uzs') required int totalUzs,
    required OrderStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(<ServerOrderLine>[]) List<ServerOrderLine> lines,
  }) = _ServerOrder;

  factory ServerOrder.fromJson(Map<String, dynamic> json) =>
      _$ServerOrderFromJson(json);
}
