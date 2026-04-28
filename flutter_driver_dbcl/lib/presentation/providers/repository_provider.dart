import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../data/repositories/ledger_repository_impl.dart';
import 'database_provider.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
ILedgerRepository ledgerRepository(LedgerRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final repo = LedgerRepositoryImpl(db);
  return repo;
}
