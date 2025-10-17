pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning source code...'
                checkout scm
            }
        }

        stage('Clean Workspace') {
            steps {
                echo 'Cleaning workspace...'
                sh 'rm -rf build'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project using build.sh...'
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Post Build - Verify Output') {
            steps {
                echo 'Verifying output...'
                sh 'if [ -f build/MyApp ]; then echo "Build successful!"; else echo " Build failed!" && exit 1; fi'
            }
        }
    }

    post {
        success {
            echo 'Build and run completed successfully!'
        }
        failure {
            echo 'Build failed. Check the logs above.'
        }
    }
}
