pipeline {
    agent any

    tools {
        maven 'M3'  // Make sure 'Maven' is configured in Jenkins Tools
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
                sh 'mvn sonar:sonar -Dsonar.host.url=http://192.168.1.77:9000'
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
                sh 'docker tag hello-world-java your-docker-repo/hello-world-java:latest'
                sh 'docker push your-docker-repo/hello-world-java:latest'
            }
        }

        stage('Deploy to Server') {
            steps {
                sh 'docker run -d -p 8080:8080 your-docker-repo/hello-world-java:latest'
            }
        }
       
    }
}
