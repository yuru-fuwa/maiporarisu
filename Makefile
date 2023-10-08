dev:
	python3 script/preBuildScript.py
	flutter run

build: build/web build/ios build/android
build/web:
	python3 script/preBuildScript.py
	flutter build web
build/ios:
	flutter build ios
build/android:
	flutter build android
