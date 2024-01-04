pipeline {
    agent any

    environment {
        DOTNET_VERSION = "3.1"  // Adjust the version as needed
    }

    stages {
        stage('Install .NET SDK') {
            steps {
                script {
                    // Install .NET SDK
                    sh "sudo apt-get update"
                    sh "sudo apt-get install -y dotnet-sdk-${DOTNET_VERSION}"
                }
            }
        }

        stage('Checkout') {
            steps {
                // Checkout your Git repository
                checkout scm
            }
        }

        stage('Restore Dependencies') {
            steps {
                script {
                    // Restore project dependencies
                    sh "dotnet restore"
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build the .NET Core project
                    sh "dotnet build"
                }
            }
        }

        // Add additional stages for testing, publishing, etc. as needed
    }

    post {
        always {
            // Clean up or perform other tasks as needed
            echo "Always block executed"
        }
    }
}
