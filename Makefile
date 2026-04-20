# Makefile for Flutter projects managed by FVM

.PHONY: get run build clean analyze format test gen ios android

# Install dependencies
get:
	fvm flutter pub get

# Run app on all connected devices
run:
	fvm flutter run

# Build release versions
build:
	fvm flutter build apk --release
	fvm flutter build ios --release

# Remove build and cache folders
clean:
	fvm flutter clean
	fvm flutter pub get

# Run analyzer with lint rules
analyze:
	fvm flutter analyze

# Format all Dart files
format:
	fvm dart format lib test

# Run tests
test:
	fvm flutter test --coverage

# Generate code (for build_runner)
gen:
	fvm dart run build_runner build --delete-conflicting-outputs

