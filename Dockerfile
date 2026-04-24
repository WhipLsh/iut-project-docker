# Étape 1
FROM eclipse-temurin:25-jdk AS builder
WORKDIR /app
COPY . .
RUN ./gradlew build -x test
# Étape 2
RUN jlink \
    --add-modules base,naming,logging,management,security.jgss,desktop,xml,instrument \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /minimal-jre
# Étape 3
FROM ubuntu:24.04
WORKDIR /app
COPY --from=builder /minimal-jre /opt/jre
ENV PATH="/opt/jre/bin:$PATH"
COPY --from=builder /app/build/libs/app.jar ./app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
