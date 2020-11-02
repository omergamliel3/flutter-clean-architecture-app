import 'package:connectivity/connectivity.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:getx_hacker_news_api/app/core/network/network_info.dart';

class ConnectivityMock extends Mock implements Connectivity {}

void main() {
  NetworkInfoI networkInfo;
  Connectivity connectivity;

  setUp(() {
    connectivity = ConnectivityMock();
    networkInfo = NetworkInfo(connectivity: connectivity);
  });

  group('isConnected ', () {
    test(
      'should call Connectivity.checkConnectivity and return true if result is wifi / mobile, else return false',
      () async {
        // arrange
        when(connectivity.checkConnectivity())
            .thenAnswer((_) => Future.value(ConnectivityResult.wifi));

        // act
        final result = await networkInfo.isConnected();

        // assert
        verify(connectivity.checkConnectivity());
        expect(result, true);
      },
    );
  });
}
