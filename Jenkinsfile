pipeline {
    agent any
    stages {

        stage('Connect to EC2 and Setup Directory') {
            steps {
                echo 'Connecting to EC2 and setting up the application directory...'
                withCredentials([sshUserPrivateKey(credentialsId: ${{ secrets.SSH_KEY_ID }}, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ] ${{ secrets.SSH_KEY_ID }} ${{ secrets.EC2_HOST}} "
                        if [ ! -d '${{ secrets.APP_DIR}}' ]; then
                            echo 'Directory ${{ secrets.APP_DIR}} does not exist. Creating...'
                            mkdir -p ${{ secrets.APP_DIR}}
                        else
                            echo 'Directory ${{ secrets.APP_DIR}} already exists.'
                        fi
                    "
                    """
                }
            }
        }

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository into the application directory...'
                withCredentials([sshUserPrivateKey(credentialsId: ${{ secrets.SSH_KEY_ID }}, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${{ secrets.SSH_KEY_ID }}${{ secrets.EC2_HOST}} "
                        cd ${{ secrets.APP_DIR}}
                        // if [ ! -d '.git' ]; then
                        //     echo 'Cloning repository...'
                        //     git clone ${GIT_REPO} .
                        // else
                        //     echo 'Pulling latest changes...'
                        //     git pull origin main
                        // fi

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
                withCredentials([sshUserPrivateKey(credentialsId: ${{ secrets.SSH_KEY_ID }}, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${{ secrets.SSH_KEY_ID }} ${{ secrets.EC2_HOST}} "
                        cd ${{ secrets.APP_DIR}}
                        export PATH=\$PATH:/usr/local/go/bin
                        go version
                        go build -o ${{ secrets.APP_NAME }}
                    "
                    """
                }
            }
        }

        stage('Run Application') {
            steps {
                echo 'Running the application...'
                withCredentials([sshUserPrivateKey(credentialsId: ${{ secrets.SSH_KEY_ID }}, keyFileVariable: 'SSH_KEY')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${{ secrets.SSH_KEY_ID }} ${{ secrets.EC2_HOST}} "
                        cd ${{ secrets.APP_DIR}}
                        fuser -k 9090/tcp || true
                        nohup ./${{ secrets.APP_NAME }} > ${{ secrets.APP_NAME }}.log 2>&1 &
                    "
                    """
                }
            }
        }
    }

}
