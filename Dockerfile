FROM openjdk:17
WORKDIR /app
COPY src/main/java/com/example /app
RUN javac App.java  # Adjust based on your project structure
CMD ["java", "com.example.App"]
