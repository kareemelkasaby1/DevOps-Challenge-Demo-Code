/* groovylint-disable-next-line CompileStatic */
pipeline {
    /* groovylint-disable-next-line NoDef, UnusedVariable, VariableName, VariableTypeRequired */
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
                    sh 'docker-compose -f ./docker-compose.yml.dev up --build --no-start'
                }
            }
        }

        stage('beforeDeploy') {
            steps {
                sh 'git rev-parse HEAD > /tmp/gitrev'
                /* groovylint-disable-next-line LineLength */
                sh 'SHA=$(cat /tmp/gitrev);docker build -t kareemelkasaby/challenge1-project:$SHA -t kareemelkasaby/challenge1-project:latest -f ./challenge1-project/Dockerfile.prod ./challenge1-project'
                /* groovylint-disable-next-line LineLength */
                sh 'SHA=$(cat /tmp/gitrev);docker build -t kareemelkasaby/challenge1-nginx:$SHA -t kareemelkasaby/challenge1-nginx:latest -f ./nginx/Dockerfile.prod ./nginx'
                sh "docker login -u '$DOCKERHUB_USER' -p '$DOCKERHUB_PASS'"
                sh 'SHA=$(cat /tmp/gitrev);docker push kareemelkasaby/challenge1-project:$SHA'
                sh 'docker push kareemelkasaby/challenge1-project:latest'
                sh 'SHA=$(cat /tmp/gitrev);docker push kareemelkasaby/challenge1-nginx:$SHA'
                sh 'docker push kareemelkasaby/challenge1-nginx:latest'
            }
        }
        stage('integrationTestAfterPush') {
            steps {
                sh 'docker-compose up --build --no-start --force-recreate'
            }
        }
        stage('deploy') {
            steps {
                /* groovylint-disable-next-line LineLength */
                sh "sudo ssh -i $DEPLOYKEY ec2-user@$EC2IP '[ -d '/home/ec2-user/app' ] && (cd ~/app;sudo docker-compose down);echo hi'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo ssh -i $DEPLOYKEY ec2-user@$EC2IP '[ ! -d '/home/ec2-user/app' ] && mkdir -p ~/app/challenge1-project/static;echo hi'"
                /* groovylint-disable-next-line LineLength */
                sh "sudo rsync -rv --update -e 'ssh -i $DEPLOYKEY' ./challenge1-project/static ec2-user@$EC2IP:~/app/challenge1-project"
                sh "sudo scp -i $DEPLOYKEY -p ./docker-compose.yml ec2-user@$EC2IP:~/app"
                sh "sudo scp -i $DEPLOYKEY -p ./.env ec2-user@$EC2IP:~/app"
                sh "sudo ssh -i $DEPLOYKEY ec2-user@$EC2IP 'cd ~/app;sudo docker-compose up --build -d;exit'"
            }
        }
    }
}
