pipeline {
    agent any

    environment {
        // Name must match your SonarQube server configuration in Jenkins
        SONARQUBE_ENV = 'MySonarQubeServer'
        BUILD_DIR = 'build'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Clean Workspace') {
            steps {
                echo 'Cleaning workspace...'
                sh 'rm -rf ${BUILD_DIR}'
            }
        }

        stage('Lint Code') {
            steps {
                echo 'Running cppcheck for static analysis...'
                // Run cppcheck and save the report
                sh '''
                cppcheck --enable=all --inconclusive --xml --xml-version=2 src 2> cppcheck-report.xml || true
                '''
            }
        }

        stage('Build') {
            steps {
                echo '⚙ Building the project using build.sh...'
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Unit Test') {
            steps {
                echo 'Running basic test (verify output)...'
                sh '''
                if ./build/MyApp | grep -q "Hello from C program"; then
                    echo "Test Passed!"
                else
                    echo "Test Failed!"
                    exit 1
                fi
                '''
            }
        }

        stage('SonarQube Analysis') {
            environment {
                // Set SonarQube scanner path if installed manually
                PATH = "/opt/sonar-scanner/bin:${PATH}"
            }
            steps {
                echo 'Running SonarQube analysis...'
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh '''
                    sonar-scanner \
                        -Dsonar.projectKey=MyCProject \
                        -Dsonar.sources=src \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_AUTH_TOKEN
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo 'checking SonarQube quality gate...'
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully — build, lint, and SonarQube passed!'
        }
        failure {
            echo 'Pipeline failed. Check the logs above for details.'
        }
    }
}
