import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

/// CLI options for `ub_code_structure:create`.
///
/// These flags control which files are generated and whether generation writes
/// to disk (`dryRun`) or replaces existing modules (`force`).
class CreateOptions {
  const CreateOptions({
    required this.withModel,
    required this.withRepository,
    required this.dryRun,
    required this.force,
    required this.flat,
  });

  final bool withModel;
  final bool withRepository;
  final bool dryRun;
  final bool force;
  final bool flat;
}

/// Converts a feature name into a stable snake_case identifier.
///
/// Supported inputs:
/// - `ProductDetail` -> `product_detail`
/// - `product-detail` -> `product_detail`
/// - `product detail` -> `product_detail`
///
/// This is used for folder and file naming.
String toSnakeCase(String str) {
  final normalized = str
      .trim()
      .replaceAll(RegExp(r'[\s\-]+'), '_')
      .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (match) => '${match.group(1)}_${match.group(2)}')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '')
      .toLowerCase();

  return normalized;
}

/// Converts snake_case to PascalCase for Dart type names.
///
/// Example: `product_detail` -> `ProductDetail`.
String toPascalCase(String snakeCase) {
  return snakeCase
      .split('_')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join();
}

/// Builds the command parser for `create` with all supported flags.
ArgParser _buildParser() {
  return ArgParser()
    ..addFlag('with-model', abbr: 'm', help: 'Generate models/<module>_model.dart.')
    ..addFlag('with-repository', abbr: 'r', help: 'Generate repository/<module>_repository.dart.')
    ..addFlag('dry-run', help: 'Preview what will be created without writing files.')
    ..addFlag('force', abbr: 'o', help: 'Overwrite an existing module directory instead of failing.')
    ..addFlag('flat', abbr: 'f', help: 'Create files directly in module root without subfolders.')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage.');
}

/// Prints help text and examples.
void _printUsage(ArgParser parser) {
  print('Usage: dart run ub_code_structure:create <module_name> [options]');
  print('');
  print('Examples:');
  print('  dart run ub_code_structure:create product');
  print('  dart run ub_code_structure:create user_profile --with-model --with-repository');
  print('  dart run ub_code_structure:create ProductDetail --dry-run');
  print('  dart run ub_code_structure:create ProductDetail -f');
  print('  dart run ub_code_structure:create ProductDetail -f -o');
  print('');
  print(parser.usage);
}

/// Generates a complete feature module under `lib/features/<module>`.
///
/// The method validates the module name, calculates all target directories and
/// files, supports a `dry-run` preview, and writes template files.
Future<void> createModule(String moduleName, CreateOptions options) async {
  try {
    final snakeCase = toSnakeCase(moduleName);
    if (snakeCase.isEmpty) {
      print('Error: module name cannot be empty.');
      return;
    }

    final pascalCase = toPascalCase(snakeCase);

    final libPath = p.join(Directory.current.path, 'lib');
    final featurePath = p.join(libPath, 'features', snakeCase);
    final moduleDirectory = Directory(featurePath);

    if (await moduleDirectory.exists() && !options.force) {
      print('Error: module already created');
      print('Location: $featurePath');
      print('Tip: use --force to overwrite existing generated files.');
      return;
    }

    final directories = <String>[
      // In flat mode all files are placed directly under feature root.
      if (options.flat) featurePath,
      if (!options.flat) p.join(featurePath, 'bindings'),
      if (!options.flat) p.join(featurePath, 'controllers'),
      if (!options.flat) p.join(featurePath, 'views'),
      if (options.withModel && !options.flat) p.join(featurePath, 'models'),
      if (options.withRepository && !options.flat) p.join(featurePath, 'repository'),
    ];

    final plannedFiles = <String>[
      // Keep this list in sync with file creation methods below.
      if (options.flat) '${snakeCase}_binding.dart' else p.join('bindings', '${snakeCase}_binding.dart'),
      if (options.flat) '${snakeCase}_controller.dart' else p.join('controllers', '${snakeCase}_controller.dart'),
      if (options.flat) '${snakeCase}_view.dart' else p.join('views', '${snakeCase}_view.dart'),
      if (options.withModel)
        if (options.flat) '${snakeCase}_model.dart' else p.join('models', '${snakeCase}_model.dart'),
      if (options.withRepository)
        if (options.flat) '${snakeCase}_repository.dart' else p.join('repository', '${snakeCase}_repository.dart'),
    ];

    if (options.dryRun) {
      print('Dry run: no files were changed.');
      print('Module: $snakeCase');
      print('Target: $featurePath');
      print('Directories to create:');
      for (final dir in directories) {
        print('  - $dir');
      }
      print('Files to create:');
      for (final file in plannedFiles) {
        print('  - $file');
      }
      return;
    }

    for (final dir in directories) {
      await Directory(dir).create(recursive: true);
    }

    await _createBindingFile(featurePath, snakeCase, pascalCase, options.flat);
    await _createControllerFile(featurePath, snakeCase, pascalCase, options.flat);
    await _createViewFile(featurePath, snakeCase, pascalCase, options.flat);

    if (options.withModel) {
      await _createModelFile(featurePath, snakeCase, pascalCase, options.flat);
    }

    if (options.withRepository) {
      await _createRepositoryFile(featurePath, snakeCase, pascalCase, options.flat);
    }

    print('Module "$snakeCase" created successfully.');
    print('Location: $featurePath');
    print('Created files:');
    for (final file in plannedFiles) {
      print('  - $file');
    }
    print('');
    print('Add these route entries manually:');
    print('  AppRoutes.$snakeCase = "/$snakeCase"');
    print(
      '  GetPage(name: AppRoutes.$snakeCase, page: () => const ${pascalCase}View(), binding: ${pascalCase}Binding())',
    );
  } catch (e) {
    print('Error creating module: $e');
    exit(1);
  }
}

/// Creates the GetX binding file and wires controller registration.
Future<void> _createBindingFile(String featurePath, String snakeCase, String pascalCase, bool flat) async {
  final filePath =
      flat ? p.join(featurePath, '${snakeCase}_binding.dart') : p.join(featurePath, 'bindings', '${snakeCase}_binding.dart');
  final controllerImport = flat ? '${snakeCase}_controller.dart' : '../controllers/${snakeCase}_controller.dart';
  final content =
      '''import 'package:get/get.dart';
import '$controllerImport';

class ${pascalCase}Binding extends Bindings {
  @override
  void dependencies() {

     Get.put(${pascalCase}Controller());

  }
}
''';
  await File(filePath).writeAsString(content);
  print('Created: ${flat ? '${snakeCase}_binding.dart' : 'bindings/${snakeCase}_binding.dart'}');
}

/// Creates the GetX controller template for the feature.
Future<void> _createControllerFile(String featurePath, String snakeCase, String pascalCase, bool flat) async {
  final filePath =
      flat ? p.join(featurePath, '${snakeCase}_controller.dart') : p.join(featurePath, 'controllers', '${snakeCase}_controller.dart');
  final content =
      '''import 'package:get/get.dart';

class ${pascalCase}Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    // TODO: Load initial data.
  }
}
''';
  await File(filePath).writeAsString(content);
  print('Created: ${flat ? '${snakeCase}_controller.dart' : 'controllers/${snakeCase}_controller.dart'}');
}

/// Creates a basic GetView scaffold for the feature UI screen.
Future<void> _createViewFile(String featurePath, String snakeCase, String pascalCase, bool flat) async {
  final filePath =
      flat ? p.join(featurePath, '${snakeCase}_view.dart') : p.join(featurePath, 'views', '${snakeCase}_view.dart');
  final controllerImport = flat ? '${snakeCase}_controller.dart' : '../controllers/${snakeCase}_controller.dart';
  final content =
      '''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '$controllerImport';

class ${pascalCase}View extends GetView<${pascalCase}Controller> {
  const ${pascalCase}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${pascalCase}'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '${pascalCase} View',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
''';
  await File(filePath).writeAsString(content);
  print('Created: ${flat ? '${snakeCase}_view.dart' : 'views/${snakeCase}_view.dart'}');
}

/// Creates a placeholder model class with JSON helpers.
Future<void> _createModelFile(String featurePath, String snakeCase, String pascalCase, bool flat) async {
  final filePath = flat ? p.join(featurePath, '${snakeCase}_model.dart') : p.join(featurePath, 'models', '${snakeCase}_model.dart');
  final content =
      '''class ${pascalCase}Model {
  const ${pascalCase}Model();

  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return const ${pascalCase}Model();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }
}
''';
  await File(filePath).writeAsString(content);
  print('Created: ${flat ? '${snakeCase}_model.dart' : 'models/${snakeCase}_model.dart'}');
}

/// Creates a placeholder repository class for data access logic.
Future<void> _createRepositoryFile(String featurePath, String snakeCase, String pascalCase, bool flat) async {
  final filePath =
      flat ? p.join(featurePath, '${snakeCase}_repository.dart') : p.join(featurePath, 'repository', '${snakeCase}_repository.dart');
  final content =
      '''class ${pascalCase}Repository {
  const ${pascalCase}Repository();

  Future<void> fetch() async {
    // TODO: Implement API/data-source call.
  }
}
''';
  await File(filePath).writeAsString(content);
  print('Created: ${flat ? '${snakeCase}_repository.dart' : 'repository/${snakeCase}_repository.dart'}');
}

/// Entrypoint for `dart run ub_code_structure:create ...`.
///
/// Parses CLI args, validates required positional module name, and delegates
/// generation to [createModule].
Future<void> main(List<String> args) async {
  final parser = _buildParser();
  late final ArgResults results;

  try {
    results = parser.parse(args);
  } on FormatException catch (e) {
    print('Error: ${e.message}');
    _printUsage(parser);
    exit(64);
  }

  if (results['help'] as bool) {
    _printUsage(parser);
    return;
  }

  if (results.rest.isEmpty) {
    print('Error: module name is required.');
    _printUsage(parser);
    exit(64);
  }

  final options = CreateOptions(
    withModel: results['with-model'] as bool,
    withRepository: results['with-repository'] as bool,
    dryRun: results['dry-run'] as bool,
    force: results['force'] as bool,
    flat: results['flat'] as bool,
  );

  final moduleName = results.rest.first;
  await createModule(moduleName, options);
}
