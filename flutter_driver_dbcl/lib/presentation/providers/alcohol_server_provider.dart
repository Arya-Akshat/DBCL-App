import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/alcohol_server_datasource.dart';
import '../../providers/app_providers.dart';
import 'usecase_provider.dart';

part 'alcohol_server_provider.g.dart';

@riverpod
Future<void> alcoholServer(AlcoholServerRef ref) async {
  final useCase = ref.watch(alcoholBridgeUseCaseProvider);
  final driverId = ref.watch(appControllerProvider).valueOrNull?.currentUser?.userId;
  
  final server = AlcoholServerDataSource(
    onAlcoholDetected: (confidence) {
      if (driverId != null && driverId.isNotEmpty) {
        useCase.onAlcoholDetected(driverId, confidence);
      }
    },
  );

  await server.start();

  ref.onDispose(() async {
    await server.stop();
  });
}
