FROM openjdk:17
WORKDIR /app
COPY . /app
RUN javac App.java  # Adjust based on your project structure
CMD ["java", "HelloWorld"]
