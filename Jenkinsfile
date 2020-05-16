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
                sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'cd ~/app &&sudo docker-compose down'"
                sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 '[ ! -d '~/app' ] && mkdir -p ~/app'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo rsync -rv --update -e 'ssh -p22' ./* ec2-user@52.34.4.128:~/app"
                sh "sudo scp -i $DEPLOYKEY -p ./.env ec2-user@52.34.4.128:~/app"
                sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'cd ~/app;sudo docker-compose up --build -d;exit'"

                // sh 'sleep 15'
                // sh 'exit'
            }
        }
    }
}
