/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any
    stages {
        stage('tests') {
            steps {
                /* groovylint-disable-next-line SpaceAroundMapEntryColon */
                parallel 'unit': {
                    /* groovylint-disable-next-line LineLength */
                    sh 'docker build -t kareemelkasaby/challenge1 -f ./challenge1-project/Dockerfile.dev ./challenge1-project'
                    sh 'docker run kareemelkasaby/challenge1 python3 tests/test.py'
                },
                /* groovylint-disable-next-line SpaceAroundMapEntryColon */
                'integration': {
                    sh 'docker-compose up --build --no-start --force-recreate'
                }
            }
        }

        stage('deploy') {
            steps {
                /* groovylint-disable-next-line LineLength */
                sh "sudo ssh -o StrictHostKeyChecking=no -i $DEPLOYKEY ec2-user@$DEVEC2IP '[ -d '/home/ec2-user/app' ] && (cd ~/app;sudo docker-compose down);echo hi'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo ssh -o StrictHostKeyChecking=no -i $DEPLOYKEY ec2-user@$DEVEC2IP '[ ! -d '/home/ec2-user/app' ] && mkdir -p ~/app;echo hi'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo rsync -rv --update -e 'ssh -o StrictHostKeyChecking=no -i $DEPLOYKEY' ./* ec2-user@$DEVEC2IP:~/app"
                sh "sudo scp -o StrictHostKeyChecking=no -i $DEPLOYKEY -p ./.env ec2-user@$DEVEC2IP:~/app"
                sh "sudo ssh -o StrictHostKeyChecking=no -i $DEPLOYKEY ec2-user@$DEVEC2IP 'cd ~/app;sudo docker-compose up --build -d;exit'"

                // sh 'sleep 15'
                // sh 'exit'
            }
        }
    }
}
