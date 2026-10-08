import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';
import 'package:tamir_uy_mobile_flutter/repositories/business_repository.dart';
import 'package:tamir_uy_mobile_flutter/repositories/orders_repository.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';

const _orderJson = {
  'id': 'o1',
  'user_id': 'u1',
  'dealer_name': 'Dealer',
  'total_uzs': 1000,
  'status': 'accepted',
  'created_at': '2026-10-08T10:00:00Z',
  'delivery_address': 'Toshkent',
  'phone': '+998901112233',
  'payment_method': 'cash',
  'lines': [],
};

class _Adapter implements HttpClientAdapter {
  RequestOptions? last;
  Object body = _orderJson;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late _Adapter adapter;
  late ApiClient client;

  setUp(() {
    adapter = _Adapter();
    client = ApiClient(baseUrl: 'http://test.local/api/v1');
    client.httpDioForTest.httpClientAdapter = adapter;
  });

  const line = OrderLineCreate(
    materialId: 'm1',
    productName: 'Boyoq',
    unit: 'litr',
    unitPriceUzs: 100,
    quantity: 2,
  );

  test('createOrder sends delivery address, phone and payment method', () async {
    final order = await OrdersRepository(client).createOrder(
      dealerName: 'Dealer',
      lines: [line],
      deliveryAddress: 'Toshkent',
      phone: '+998901112233',
      paymentMethod: 'cash',
    );
    expect(adapter.last!.path, endsWith('/orders'));
    final data = adapter.last!.data as Map<String, dynamic>;
    expect(data['delivery_address'], 'Toshkent');
    expect(data['phone'], '+998901112233');
    expect(data['payment_method'], 'cash');
    expect(data['dealer_name'], 'Dealer');
    expect(order.deliveryAddress, 'Toshkent');
    expect(order.paymentMethod, 'cash');
  });

  test('createOrder omits the optional fields when not given', () async {
    await OrdersRepository(client).createOrder(
      dealerName: 'Dealer',
      lines: [line],
    );
    final data = adapter.last!.data as Map<String, dynamic>;
    expect(data.containsKey('delivery_address'), isFalse);
    expect(data.containsKey('phone'), isFalse);
    expect(data.containsKey('payment_method'), isFalse);
  });

  test('seller orders are listed and advanced one stage', () async {
    final seller = {..._orderJson}..remove('user_id');
    adapter.body = [seller];
    final repo = BusinessRepository(client);
    final list = await repo.fetchSellerOrders();
    expect(adapter.last!.path, endsWith('/seller/orders'));
    expect(list.single.status, SellerOrderStage.accepted);
    expect(list.single.status.next, SellerOrderStage.gathering);

    adapter.body = {...seller, 'status': 'gathering'};
    final moved = await repo.advanceSellerOrder('o1', SellerOrderStage.gathering);
    expect(adapter.last!.method, 'PATCH');
    expect(adapter.last!.path, endsWith('/seller/orders/o1/status'));
    expect(adapter.last!.data, {'status': 'gathering'});
    expect(moved.status, SellerOrderStage.gathering);
    expect(SellerOrderStage.delivered.next, isNull);
  });
}
