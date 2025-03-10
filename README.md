# hello-world-java

# Hello World Java - CI/CD Pipeline

This project demonstrates a CI/CD pipeline for a simple Java "Hello World" application using:

- **Git** for version control
- **Maven** for build automation
- **Jenkins** for CI/CD
- **SonarQube** for code quality analysis
- **Docker** for containerization

## 📌 Prerequisites
Ensure you have the following installed on your system:

- Java 17+
- Maven
- Git
- Docker
- Jenkins (with necessary plugins: Git, Maven Integration, SonarQube Scanner, Docker Pipeline)

---

## 🚀 Step 1: Java Code and Project Setup
### Create the Java Project
```sh
mkdir hello-world-java
cd hello-world-java
```
### Initialize a Maven Project
```sh
mvn archetype:generate -DgroupId=com.example -DartifactId=hello-world-java -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```
### Java Source Code (`src/main/java/com/example/App.java`)
```java
package com.example;
public class App {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```
### Unit Test (`src/test/java/com/example/AppTest.java`)
```java
package com.example;

import static org.junit.Assert.assertTrue;
import org.junit.Test;

public class AppTest {
    @Test
    public void testApp() {
        assertTrue(true);
    }
}
```
### Maven Configuration (`pom.xml`)
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>hello-world-java</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
</project>
```
### Build the Java Application
```sh
mvn clean package
```
### Target Folder Explanation
After building, Maven generates the following inside the `target/` directory:
- `hello-world-java-1.0-SNAPSHOT.jar` → The compiled Java application.
- `test-classes/` → Compiled test classes.
- `surefire-reports/` → Unit test reports.
- `maven-archiver/` → Metadata related to the build.

---

## 🔧 Step 2: Set Up Git & GitHub
### Initialize Git
```sh
git init
git remote add origin https://github.com/krsaeed/hello-world-java.git
git branch -M main
```
### Add and Commit Code
```sh
git add .
git commit -m "Initial commit"
```
### Push to GitHub
```sh
git push -u origin main
```

---

## 🛠 Step 3: Configure Jenkins Pipeline
1. Install Jenkins and required plugins: Git, Maven Integration, SonarQube Scanner, Docker Pipeline.
2. Create a new **Pipeline Job** in Jenkins.
3. Add the following `Jenkinsfile`:

```groovy
pipeline {
    agent any

    tools {
        maven 'M3'  // Ensure Maven is configured in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/krsaeed/hello-world-java.git'
            }
        }
        
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    sh 'mvn sonar:sonar -Dsonar.host.url=http://192.168.1.77:9000 -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-world-java .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "khalilurrahmansaeed10634" --password-stdin'
                    sh 'docker tag hello-world-java khalilurrahmansaeed10634/hello-world-java:latest'
                    sh 'docker push khalilurrahmansaeed10634/hello-world-java:latest'
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sh '''
                    docker stop hello-world-java || true
                    docker rm hello-world-java || true
                    docker run -d --name hello-world-java -p 8085:8080 khalilurrahmansaeed10634/hello-world-java:latest
                '''
            }
        }
    }
}
```

---

## 🐳 Step 4: Docker Setup & Deployment
### Create a Dockerfile
```dockerfile
FROM openjdk:17
WORKDIR /app
COPY target/hello-world-java-1.0-SNAPSHOT.jar /app/app.jar
CMD ["java", "-jar", "/app/app.jar"]
```
### Build the Docker Image
```sh
docker build -t hello-world-java .
```
### Run the Docker Container
```sh
docker run -d --name hello-world-container -p 8080:8080 hello-world-java
```
Verify if the container is running:
```sh
docker ps
```
Check container logs:
```sh
docker logs hello-world-container
```

---

## ✅ Testing the Application
Once deployed, open your browser and visit:
```
http://localhost:8080
```

---

## 📜 License
This project is licensed under the MIT License.

---

### 🚀 Congratulations! Your CI/CD Pipeline is Successfully Set Up! 🚀

