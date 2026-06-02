<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# ub_code_structure

`ub_code_structure` is a Flutter package that helps you quickly scaffold a clean, modular GetX project structure.

It includes two CLI commands:
- `init`: copies starter architecture files into your project.
- `create`: generates a new feature module with bindings, controller, and view (plus optional model/repository).

## Features

- Bootstrap project folders/files under `lib/` for a structured app setup.
- Generate feature modules using snake_case, kebab-case, PascalCase, or spaced names.
- Optional `--with-model` and `--with-repository` generation.
- Safe generation with `--dry-run` preview and `--force` overwrite options.
- Optional flat mode (`--flat`) to generate module files without subfolders.

## Getting Started

### 1) Add the package

```yaml
dev_dependencies:
  ub_code_structure: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### 2) Initialize base structure

Run this inside your Flutter app project root:

```bash
dart run ub_code_structure:init
```

This command copies package starter files into your project `lib/` and tries to add required dependencies.

## Usage

### Create a module

```bash
dart run ub_code_structure:create product
```

### More examples

```bash
dart run ub_code_structure:create user_profile --with-model --with-repository
dart run ub_code_structure:create ProductDetail --dry-run
dart run ub_code_structure:create ProductDetail --flat
dart run ub_code_structure:create ProductDetail --flat --force
```

### Generated module layout (default)

```text
lib/features/product/
  bindings/product_binding.dart
  controllers/product_controller.dart
  views/product_view.dart
  models/product_model.dart            # if --with-model
  repository/product_repository.dart   # if --with-repository
```

### Generated module layout (`--flat`)

```text
lib/features/product/
  product_binding.dart
  product_controller.dart
  product_view.dart
  product_model.dart                   # if --with-model
  product_repository.dart              # if --with-repository
```

## Command Options

### `create`

- `-m`, `--with-model`: generate `<module>_model.dart`
- `-r`, `--with-repository`: generate `<module>_repository.dart`
- `--dry-run`: show planned folders/files without writing
- `-o`, `--force`: allow overwrite when module folder exists
- `-f`, `--flat`: generate files directly in module root
- `-h`, `--help`: print help output

## Notes

- `create` prints route snippets you can add manually to your app routing files.
- The generator uses GetX-based templates (`Bindings`, `GetxController`, `GetView`).

## Publishing on pub.dev Checklist

Before publishing, make sure:
- `pubspec.yaml` has final `description`, `homepage`/`repository`, and semantic version.
- `CHANGELOG.md` includes release notes for the new version.
- `LICENSE` is present.
- Example app or usage in `example/` works.
- `dart pub publish --dry-run` passes without warnings.

## Additional Information

- Report issues and feature requests in your repository issue tracker.
- Keep templates backward compatible when possible, since they are copied into consumer projects.
- Update version and changelog for every published release.
