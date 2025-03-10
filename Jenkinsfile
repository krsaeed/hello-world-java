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
                    docker run -d --name hello-world-java -p 8080:8080 khalilurrahmansaeed10634/hello-world-java:latest
                '''
            }
        }
       
    }
}
