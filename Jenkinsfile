pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/dotnet/sdk:3.1'  // Use the desired .NET SDK version
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Restore Dependencies') {
            steps {
                script {
                    sh 'dotnet restore'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'dotnet build'
                }
            }
        }

        // Add additional stages as needed
    }

    post {
        always {
            // Clean up or perform other tasks as needed
            echo "Always block executed"
        }
    }
}
