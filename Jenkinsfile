pipeline {
    agent { label 'linuxgit' }

    environment {
        GIT_REPO = 'https://github.com/Lavanyabn1997/pipeline-ec2-user.git'
        BRANCH = 'main'
    }

    stages {
        stage('clean Workspace') {
            steps {
                echo 'cleaning Workspace'
                deletedir()
            }
        }
        stage('Lint') {
            steps {
                echo "cloning the repo from github.........."
                git branch: "${BRANCH}",
                    url: "${GIT_REPO}"
                    credentialsId: 'github'
            }
        }
        stage('build') {
            steps {
                sh 'dos2unix build.sh'
                sh 'chmod +x build.sh'
                sh 'bash build.sh'
            }
        }
        stage('push build to artifactory') {
            steps {
                script {
                    def server = Artifactory.server
                    def uploadSpec = """ {
                    "files": [
                    {
                    "pattern": "*.bin",
                    "target": "generic-local/build/${env.JOB_NAME}/${env.BUILD_NUMBER}/"
                    }
                ]
              }
            }
          }               
        }
      }
   }

            
        
