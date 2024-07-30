import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/blocs/localization/localization_cubit.dart';
import 'package:weather_app/services/localization_service.dart';

// Criação de uma classe Mock para LocalizationService usando mockito
class MockLocalizationService extends Mock implements LocalizationService {}

void main() {
  group('LocalizationCubit', () {
    late MockLocalizationService mockLocalizationService;
    late LocalizationCubit localizationCubit;

    setUp(() {
      mockLocalizationService = MockLocalizationService();
      localizationCubit = LocalizationCubit(mockLocalizationService);
    });

    tearDown(() {
      localizationCubit.close();
    });

    test('initial state is LocalizationUnknown', () {
      expect(localizationCubit.state, isA<LocalizationUnknown>());
    });

    blocTest<LocalizationCubit, LocalizationState>(
      'Test reset localization',
      build: () => localizationCubit,
      act: (cubit) => cubit.resetLocalization(),
      expect: () => [
        isA<LocalizationUnknown>(),
        isA<LocalizationLoaded>(),
      ],
    );

    blocTest<LocalizationCubit, LocalizationState>(
      'Test change localization',
      build: () => localizationCubit,
      act: (cubit) => cubit.changeLocalization('en'),
      expect: () => [
        isA<LocalizationUnknown>(),
        isA<LocalizationLoaded>(),
      ],
    );

    blocTest<LocalizationCubit, LocalizationState>(
      'Test change localization with error',
      build: () {
        when(mockLocalizationService.determinePosition())
            .thenThrow(Exception('Error'));
        return localizationCubit;
      },
      act: (cubit) => cubit.changeLocalization('en'),
      expect: () => [
        isA<LocalizationUnknown>(),
        isA<LocalizationError>(),
      ],
    );
  });
}