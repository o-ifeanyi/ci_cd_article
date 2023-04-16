test:
	@echo "╠ Running test..."
	flutter pub get
	flutter test

deploy-android:
	@echo "╠ Sending Android Build to Closed Testing..."
	cd android && bundle install
	cd android/fastlane && bundle exec fastlane deploy

deploy-ios:
	@echo "╠ Sending iOS Build to TestFlight..."
	cd ios/fastlane && bundle install
	cd ios/fastlane && bundle exec fastlane deploy

deploy-web:
	@echo "╠ Sending Build to Firebase Hosting..."
	flutter build web
	firebase deploy

deploy: test deploy-android deploy-ios deploy-web

.PHONY: test deploy-android deploy-ios deploy-web