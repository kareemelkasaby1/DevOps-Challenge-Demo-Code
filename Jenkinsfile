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
                sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'cd ~/app;sudo docker-compose down'"
                // sh "sudo ssh-add -i $DEPLOYKEY ec2-user@52.34.4.128"
                // sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'rm -rf ~/app'"
                // sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'mkdir ~/app'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo rsync -rv --existing --dry-run --update -e 'ssh -i $DEPLOYKEY ec2-user@52.34.4.128' ./* ec2-user@52.34.4.128:~/app"
                sh "sudo scp -i $DEPLOYKEY -p ./.env ec2-user@52.34.4.128:~/app"
                sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'cd ~/app;sudo docker-compose up --build -d;exit'"

                // sh 'sleep 15'
                // sh 'exit'
            }
        }
    }
}
