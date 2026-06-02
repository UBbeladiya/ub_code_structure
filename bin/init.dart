import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

// Enum for all file types
enum FileType {
  validators,
  appBinding,
  initialBinding,
  appPages,
  appRoutes,
  enUS,
  appTranslations,
  appConstants,
  apiConstants,
  assetConstants,
  appColors,
  appTheme,
  textStyles,
  contextExt,
  stringExt,
  widgetExt,
  helpers,
  dateUtils,
  apiClient,
  interceptors,
  customButton,
  customTextField,
  loadingWidget,
  confirmDialog,
  errorDialog,
  authBinding,
  authController,
  loginView,
  registerView,
  authHeader,
  userModel,
  authRepository,
  other,
}

// Map file paths to enum
FileType getFileType(String path) {
  if (path.endsWith('core/utils/validators.dart')) return FileType.validators;
  if (path.endsWith('app/bindings/app_binding.dart')) return FileType.appBinding;
  if (path.endsWith('app/bindings/initial_binding.dart')) return FileType.initialBinding;
  if (path.endsWith('app/routes/app_pages.dart')) return FileType.appPages;
  if (path.endsWith('app/routes/app_routes.dart')) return FileType.appRoutes;
  if (path.endsWith('app/translations/en_US.dart')) return FileType.enUS;
  if (path.endsWith('app/translations/app_translations.dart')) return FileType.appTranslations;
  if (path.endsWith('core/constants/app_constants.dart')) return FileType.appConstants;
  if (path.endsWith('core/constants/api_constants.dart')) return FileType.apiConstants;
  if (path.endsWith('core/constants/asset_constants.dart')) return FileType.assetConstants;
  if (path.endsWith('core/theme/app_colors.dart')) return FileType.appColors;
  if (path.endsWith('core/theme/app_theme.dart')) return FileType.appTheme;
  if (path.endsWith('core/theme/text_styles.dart')) return FileType.textStyles;
  if (path.endsWith('core/extensions/context_ext.dart')) return FileType.contextExt;
  if (path.endsWith('core/extensions/string_ext.dart')) return FileType.stringExt;
  if (path.endsWith('core/extensions/widget_ext.dart')) return FileType.widgetExt;
  if (path.endsWith('core/utils/helpers.dart')) return FileType.helpers;
  if (path.endsWith('core/utils/date_utils.dart')) return FileType.dateUtils;
  if (path.endsWith('core/network/api_client.dart')) return FileType.apiClient;
  if (path.endsWith('core/network/interceptors.dart')) return FileType.interceptors;
  if (path.endsWith('common/widgets/custom_button.dart')) return FileType.customButton;
  if (path.endsWith('common/widgets/custom_text_field.dart')) return FileType.customTextField;
  if (path.endsWith('common/widgets/loading_widget.dart')) return FileType.loadingWidget;
  if (path.endsWith('common/dialogs/confirm_dialog.dart')) return FileType.confirmDialog;
  if (path.endsWith('common/dialogs/error_dialog.dart')) return FileType.errorDialog;
  if (path.endsWith('features/auth/bindings/auth_binding.dart')) return FileType.authBinding;
  if (path.endsWith('features/auth/controllers/auth_controller.dart')) return FileType.authController;
  if (path.endsWith('features/auth/views/login_view.dart')) return FileType.loginView;
  if (path.endsWith('features/auth/views/register_view.dart')) return FileType.registerView;
  if (path.endsWith('features/auth/widgets/auth_header.dart')) return FileType.authHeader;
  if (path.endsWith('features/auth/models/user_model.dart')) return FileType.userModel;
  if (path.endsWith('features/auth/repository/auth_repository.dart')) return FileType.authRepository;
  return FileType.other;
}


String getTodoContent(String path) => '// TODO: Implement $path\n';

Future<void> addDependencies() async {
  final dependencies = ['dio', 'connectivity_plus','get','google_fonts','shared_preferences'];
  // Always try to add dependencies; if already present, pub will skip
  final addCmd = ['pub', 'add', ...dependencies];
  log('Ensuring dependencies: \\${dependencies.join(", ")}');
  try {
    await Process.run('flutter', addCmd, runInShell: true);
    log('Running flutter pub get...');
    await Process.run('flutter', ['pub', 'get'], runInShell: true);
  } catch (e) {
    log('Could not run flutter pub add or pub get. Please run these commands manually:');
    log('flutter \\${addCmd.join(' ')}');
    log('flutter pub get');
  }
}

Future<void> readAndRewriteNetworkFiles(String networkDirPath) async {
  final dir = Directory(networkDirPath);
  if (await dir.exists()) {
    final files = dir.listSync().whereType<File>();
    for (final file in files) {
      final content = await file.readAsString();
      // Here you can modify content if needed before writing
      await file.writeAsString(content);
    }
  }
}

Future<void> printDirectoryTree(Directory dir, {String prefix = ''}) async {
  final entities = dir.listSync();
  for (final entity in entities) {
    final name = entity.path.split(Platform.pathSeparator).last;
    if (entity is Directory) {
      log('$prefix📁 $name');
      await printDirectoryTree(entity, prefix: '$prefix  ');
    } else if (entity is File) {
      log('$prefix📄 $name');
    }
  }
}






Future<void> copyApiStateFile() async {
  try {
    // 1. Resolve your package file URI (Omit 'lib/' in package URIs)
    const packageFileUri = 'package:ub_code_structure/api/api_state.dart';
    final packageUri = Uri.parse(packageFileUri);
    final resolvedUri = await Isolate.resolvePackageUri(packageUri);

    if (resolvedUri == null) {
      log('❌ Error: Could not find package location.');
      return;
    }
    final sourceFile = File(resolvedUri.toFilePath());

    if (!await sourceFile.exists()) {
      log('❌ Error: Source file missing at: ${sourceFile.path}');
      return;
    }

    // 2. Your exact target directory method
    final networkDir = Directory('${Directory.current.path}/lib/core/network');

    // 3. Create the directory if it does not exist
    if (!await networkDir.exists()) {
      await networkDir.create(recursive: true);
    }

    // 4. Extract file name and build destination path
    final fileName = p.basename(sourceFile.path); // extracts 'api_state.dart'
    final destinationPath = p.join(networkDir.path, fileName);

    // 5. Copy the file
    await sourceFile.copy(destinationPath);

    log('✅ File successfully created!');
    log('📍 Path: $destinationPath');

  } catch (e) {
    log('❌ Error: $e');
  }
}

Future<void> copyAllAppFiles() async {
  try {
    // 1. Anchor using the main api.dart file to find your package's 'lib' directory
    const packageAnchorUri = 'package:ub_code_structure/api.dart';
    final packageUri = Uri.parse(packageAnchorUri);
    final resolvedUri = await Isolate.resolvePackageUri(packageUri);

    if (resolvedUri == null) {
      log('❌ Error: Could not find package location.');
      return;
    }

    // Get the package's 'lib' absolute path
    final packageLibPath = p.dirname(resolvedUri.toFilePath());

    // Target your package's source directory: 'lib/app' (the folder with multiple subfolders)
    final sourceAppDir = Directory(p.join(packageLibPath, 'app'));

    // Verify if your source folder exists inside the package template
    if (!await sourceAppDir.exists()) {
      log('❌ Error: Source "app" directory missing at: ${sourceAppDir.path}');
      return;
    }

    // 2. Your exact target directory context pointing directly to 'lib'
    final targetLibDir = Directory('${Directory.current.path}/lib');

    // Ensure the main lib directory exists (it always does in standard projects)
    if (!await targetLibDir.exists()) {
      await targetLibDir.create(recursive: true);
    }

    log('📂 Syncing package/lib/app structures into project/lib/app...');

    // 3. Loop through all subfolders and files inside package's lib/app/
    await for (var entity in sourceAppDir.list(recursive: true)) {
      if (entity is File) {
        // Get the relative path from the package's source 'app' folder
        // For example: 'features/home/home_screen.dart'
        final relativePath = p.relative(entity.path, from: sourceAppDir.path);

        // Build target path combining: project root/lib/app + the relative structure
        final destinationPath = p.join(targetLibDir.path, 'app', relativePath);
        final destinationFile = File(destinationPath);

        // This dynamically recreates all the missing nested subfolders one by one!
        await destinationFile.parent.create(recursive: true);

        // Copy file content over
        await entity.copy(destinationFile.path);

        log('  ✨ Created: ./lib/app/$relativePath');
      }
    }

    log('✅ All folders and files successfully copied to your project\'s lib/app directory!');

  } catch (e) {
    log('❌ Error during code structure extraction: $e');
  }
}

Future<void> copyAllLibFiles() async {
  try {
    // Anchor using the package's public entry file to find its lib directory.
    const packageAnchorUri = 'package:ub_code_structure/api.dart';
    final packageUri = Uri.parse(packageAnchorUri);
    final resolvedUri = await Isolate.resolvePackageUri(packageUri);

    if (resolvedUri == null) {
      log('Error: Could not find package location.');
      return;
    }

    final sourceLibDir = Directory(p.dirname(resolvedUri.toFilePath()));
    if (!await sourceLibDir.exists()) {
      log('Error: Source lib directory missing at: ${sourceLibDir.path}');
      return;
    }

    final targetLibDir = Directory('${Directory.current.path}/lib');
    if (!await targetLibDir.exists()) {
      await targetLibDir.create(recursive: true);
    }

    log('Syncing all package lib folders/files into project lib...');

    await for (final entity in sourceLibDir.list(recursive: true, followLinks: false)) {
      final relativePath = p.relative(entity.path, from: sourceLibDir.path);

      // Skip package entry file; this is not needed inside consuming project lib.
      if (relativePath == 'api.dart') {
        continue;
      }

      final destinationPath = p.join(targetLibDir.path, relativePath);

      if (entity is Directory) {
        final destinationDir = Directory(destinationPath);
        if (!await destinationDir.exists()) {
          await destinationDir.create(recursive: true);
          log('  Created dir: ./lib/$relativePath');
        }
        continue;
      }

      if (entity is File) {
        final destinationFile = File(destinationPath);
        await destinationFile.parent.create(recursive: true);

        if (await destinationFile.exists()) {
          log('  Skipped existing file: ./lib/$relativePath');
          continue;
        }

        await entity.copy(destinationFile.path);
        log('  Created file: ./lib/$relativePath');
      }
    }

    log('All package lib folders/files are available in your project lib directory.');
  } catch (e) {
    log('Error during lib structure extraction: $e');
  }
}

void main(List<String> args) async {
  final base = Directory('${Directory.current.path}/lib');
  if (!await base.exists()) {
    await base.create(recursive: true);
  }

  final packageRoot = p.normalize(p.join(p.dirname(Platform.script.toFilePath()), '..'));
  log('Installing files into $packageRoot ...\n');
  await copyApiStateFile();
  await copyAllLibFiles();
 // await copyTemplates(packageRoot);


  await addDependencies();
  log('Project structure created in: \\${base.path}');
}
