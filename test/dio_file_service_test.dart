import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_file_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ResponseMock extends Mock implements Response<List<int>> {}

void main() {
  var dioResponseMock = ResponseMock();

  var httpResponse = HttpGetResponse(dioResponseMock, true, Duration(days: 7));

  // Extension tests
  test('Retrives file extension from mime-type', () {
    when(dioResponseMock.headers).thenReturn(Headers.fromMap({
      HttpHeaders.contentTypeHeader: ["image/jpg"]
    }));
    expect(httpResponse.fileExtension, equals('.jpg'));
  });

  test('Retrives file extension from reqest URL when mime-type is not present', () {
    final request = RequestOptions(baseUrl: "google.com", path: "/image.jpg");
    when(dioResponseMock.request).thenReturn(request);

    expect(httpResponse.fileExtension, equals('.jpg'));
  });

  test('Retrives file extension from mime-type when extension is present in request URL',
      () {
    final request = RequestOptions(baseUrl: "google.com", path: "/image.jpg");
    when(dioResponseMock.request).thenReturn(request);
    when(dioResponseMock.headers).thenReturn(Headers.fromMap({
      HttpHeaders.contentTypeHeader: ["image/jpg"]
    }));

    when(dioResponseMock.request).thenReturn(request);
    expect(httpResponse.fileExtension, equals('.jpg'));
  });

  test(
      'Returns empty string when mime-type is not present/invalid and extension is not present in request URL',
      () {
    final request = RequestOptions(baseUrl: "google.com", path: "/image");
    when(dioResponseMock.request).thenReturn(request);
    when(dioResponseMock.headers).thenReturn(Headers.fromMap({
      HttpHeaders.contentTypeHeader: ["fsggsfd"]
    }));

    when(dioResponseMock.request).thenReturn(request);
    expect(httpResponse.fileExtension, equals(''));
  });

  // Cache time tests
}
