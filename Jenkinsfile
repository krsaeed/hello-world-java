pipeline {
    agent any

    tools {
        maven 'Maven'  // Make sure 'Maven' is configured in Jenkins Tools
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/krsaeed/hello-world-java.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.host.url=http://your-sonarqube-server:9000'
            }
        }

        stage('Upload to JFrog Artifactory') {
            steps {
                sh 'mvn deploy'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-world-java .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker tag hello-world-java krsaeed/hello-world-java:latest'
                sh 'docker push krsaeed/hello-world-java:latest'
            }
        }

        stage('Deploy to Server') {
            steps {
                sh 'docker run -d -p 8080:8080 krsaeed/hello-world-java:latest'
            }
        }
    }
}
