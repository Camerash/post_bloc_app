import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('JsonPlaceholderApiClient', () {
    late http.Client httpClient;
    late JsonPlaceholderApiClient jsonPlaceholderApiClient;

    setUpAll(() {
      // Use to let MockHttpClient to accept any() in test
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      jsonPlaceholderApiClient = JsonPlaceholderApiClient(client: httpClient);
    });

    group('constructor', () {
      test('does not require a httpClient', () {
        expect(JsonPlaceholderApiClient(), isNotNull);
      });
    });

    group('postRequest', () {
      const start = 0;
      const limit = 10;
      test('make correct http request', () async {
        // Create a mock response with proper parameters
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        // Then, setup the httpClient to response with this response
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Perform query action
        try {
          await jsonPlaceholderApiClient.getPosts(start, limit);
        } catch (_) {}

        // Verify the call
        verify(
          () => httpClient.get(
            Uri.https(
              'jsonplaceholder.typicode.com',
              '/posts',
              {
                'start': start.toString(),
                'limit': limit.toString(),
              },
            ),
          ),
        ).called(1);
      });

      test('throw PostRequestFailure if http status is not 200', () {
        // Create a mock response with proper parameters
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        // Then, setup the httpClient to response with this response
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Test
        expect(
          () async => await jsonPlaceholderApiClient.getPosts(start, limit),
          throwsA(isA<PostRequestFailure>()),
        );
      });
    });
  });
}
