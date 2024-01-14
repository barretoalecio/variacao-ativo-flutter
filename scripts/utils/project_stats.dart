import 'dart:io';

void main() {
  changeDirectoryToRootFolder();

  final fileStream = getAllFilesRecusively();

  int linesOfProductionCode = 0;
  int linesOfTestingCode = 0;
  int unitTests = 0;
  int blocs = 0;
  int usecases = 0;
  int repositories = 0;
  int dataSources = 0;
  int modules = 0;

  fileStream.listen(
    (fileSystemEntity) {
      if (fileSystemEntity is File && fileSystemEntity.path.endsWith('.dart')) {
        final fileLines = fileSystemEntity.readAsLinesSync();
        final linesQuantity = fileLines.length;
        bool isTestFile = false;

        if (fileSystemEntity.path.endsWith('test.dart')) {
          linesOfTestingCode += linesQuantity;
          isTestFile = true;
        } else {
          linesOfProductionCode += linesQuantity;
        }

        if (isTestFile) {
          for (final line in fileLines) {
            if (line.contains('test(') || line.contains('blocTest<')) {
              unitTests++;
            }
          }

          return;
        }

        for (final line in fileLines) {
          if (line.contains('extends Module {')) {
            modules++;
            return;
          }

          if (line.contains('extends Bloc')) {
            blocs++;
            return;
          }

          if (line.contains('extends AsyncUsecase') ||
              line.contains('extends Usecase')) {
            usecases++;
            return;
          }

          if (line.contains('Repository {')) {
            repositories++;
            return;
          }

          if (line.contains('DataSource {')) {
            dataSources++;
            return;
          }
        }
      }
    },
  ).onDone(
    () => showStats(
      linesOfProductionCode: linesOfProductionCode,
      linesOfTestingCode: linesOfTestingCode,
      unitTests: unitTests,
      blocs: blocs,
      usecases: usecases,
      repositories: repositories,
      dataSources: dataSources,
      modules: modules,
    ),
  );
}

void changeDirectoryToRootFolder() {
  final rootDirectory = Directory.current.parent.parent.path;
  Directory.current = rootDirectory;
}

Stream<FileSystemEntity> getAllFilesRecusively() async* {
  yield* Directory.current.list(recursive: true);
}

void showStats({
  required int linesOfProductionCode,
  required int linesOfTestingCode,
  required int unitTests,
  required int blocs,
  required int usecases,
  required int dataSources,
  required int repositories,
  required int modules,
}) {
  print(
    '''Stats for Variação do Ativo Mobile

Lines of production code: $linesOfProductionCode
Lines of testing code: $linesOfTestingCode
Total lines of code: ${linesOfProductionCode + linesOfTestingCode}
Total unit tests: $unitTests
Total blocs: $blocs
Total usecases: $usecases
Total repositories: $repositories
Total data sources: $dataSources
Total modules: $modules''',
  );
}
