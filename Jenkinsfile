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

        

       
    }
}
