pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = 'github_creds'
        GIT_REPO = 'https://github.com/aniket0951/golang-ec2-deployment'
        EC2_HOST = 'ubuntu@ec2-13-234-238-5.ap-south-1.compute.amazonaws.com'
        APP_NAME = 'my-go-app'
        SSH_KEY_ID = 'ec2_ssh_id'
        APP_DIR = 'golang-app'
    }
    stages {

        stage('Connect to EC2 and Setup Directory') {
            steps {
                echo 'Connecting to EC2 and setting up the application directory...'
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_HOST} "
                        if [ ! -d '${APP_DIR}' ]; then
                            echo 'Directory ${APP_DIR} does not exist. Creating...'
                            mkdir -p ${APP_DIR}
                        else
                            echo 'Directory ${APP_DIR} already exists.'
                        fi
                    "
                    """
                }
            }
        }

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository into the application directory...'
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_HOST} "
                        cd ${APP_DIR}
                        echo 'Pulling latest changes...'
                        git pull origin main
                    "
                    """
                }
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the Go application...'
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_HOST} "
                        cd ${APP_DIR}
                        export PATH=\$PATH:/usr/local/go/bin
                        go version
                        go build -o ${APP_NAME}
                    "
                    """
                }
            }
        }

        stage('Run Application') {
            steps {
                echo 'Running the application...'
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_HOST} "
                        cd ${APP_DIR}
                        fuser -k 9090/tcp || true
                        nohup ./${APP_NAME} > ${APP_NAME}.log 2>&1 &
                    "
                    """
                }
            }
        }
    }

}
