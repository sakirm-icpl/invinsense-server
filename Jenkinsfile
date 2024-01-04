pipeline {
    agent any

    environment {
        DOTNET_VERSION = "3.1"  // Adjust the version as needed
        DOCKER_IMAGE = "mcr.microsoft.com/dotnet/sdk:${DOTNET_VERSION}"
    }

    stages {
        stage('Install Docker and Build') {
            steps {
                script {
                    // Install Docker
                    sh 'sudo apt-get update && sudo apt-get install -y docker.io'

                    // Build inside a Docker container
                    sh "docker run --rm -v ${PWD}:/app -w /app ${DOCKER_IMAGE} dotnet build"
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
