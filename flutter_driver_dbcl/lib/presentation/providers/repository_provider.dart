import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../data/repositories/ledger_repository_impl.dart';
import 'database_provider.dart';
import '../../providers/app_providers.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
ILedgerRepository ledgerRepository(LedgerRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final api = ref.watch(dbclApiServiceProvider);
  final repo = LedgerRepositoryImpl(db, api);
  return repo;
}
