import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/detect_fatigue_usecase.dart';
import '../../domain/usecases/alcohol_bridge_usecase.dart';
import '../../domain/usecases/verify_face_usecase.dart';
import '../../data/datasources/secure_storage_datasource.dart';
import 'repository_provider.dart';

part 'usecase_provider.g.dart';

@Riverpod(keepAlive: true)
DetectFatigueUseCase detectFatigueUseCase(DetectFatigueUseCaseRef ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return DetectFatigueUseCase(repo);
}

@Riverpod(keepAlive: true)
AlcoholBridgeUseCase alcoholBridgeUseCase(AlcoholBridgeUseCaseRef ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return AlcoholBridgeUseCase(repo);
}

@Riverpod(keepAlive: true)
VerifyFaceUseCase verifyFaceUseCase(VerifyFaceUseCaseRef ref) {
  return VerifyFaceUseCase(SecureStorageDataSource());
}
