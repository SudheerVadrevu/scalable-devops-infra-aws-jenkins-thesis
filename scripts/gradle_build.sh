cd app
./gradlew -Dsonar.host.url=http://13.49.10.89:9000 -i sonarqube
gradle build --no-daemon