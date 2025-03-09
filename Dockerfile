FROM openjdk:17
WORKDIR /app
COPY . /app
RUN javac HelloWorld.java  # Adjust based on your project structure
CMD ["java", "HelloWorld"]
