import 'package:cuidapet/app/core/database/migrations/migration_v1.dart';

import 'migrations/migration.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
        MigrationV1(),
      ];

  List<Migration> getUpdateMigrations(int version) {
    return [];
  }
}


// if (version == 2) {
    //   return [
    //     MigrationV1(),
    //     MigrationV2(),
    //   ];
    // }