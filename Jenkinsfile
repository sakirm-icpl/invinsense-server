pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Install Docker and Build') {
            steps {
                script {
                    // Configure sudo to not require a password for the Jenkins user
                    sh 'echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/jenkins'
                    
                    // Install Docker and other necessary tools
                    sh 'sudo apt-get update'
                    // Add more installation steps as needed

                    // Run Docker commands without sudo
                    sh 'docker build -t your-docker-image .'
                    // Add more Docker commands as needed
                }
            }
        }
    }

    post {
        always {
            echo 'Always block executed'
        }
    }
}
