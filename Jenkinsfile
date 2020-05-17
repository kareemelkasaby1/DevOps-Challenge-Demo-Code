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
                    sh 'docker-compose up --build --no-start --force-recreate'
                }
            }
        }

        stage('beforeDeploy') {
            steps {
                sh 'SHA=$(git rev-parse HEAD)'
                /* groovylint-disable-next-line LineLength */
                sh 'docker build -t kareemelkasaby/challenge1-project:$SHA kareemelkasaby/challenge1-project:latest -f ./challenge1-project/Dockerfile.prod ./challenge1-project'
                /* groovylint-disable-next-line LineLength */
                sh 'docker build -t kareemelkasaby/challenge1-nginx:$SHA kareemelkasaby/challenge1-nginx:latest -f ./nginx/Dockerfile.prod ./nginx'
                sh 'echo '$DOCKERHUB_PASS' | docker login -u '$DOCKERHUB_USER' --password-stdin'
                sh 'docker push kareemelkasaby/kareemelkasaby/challenge1-project:$SHA'
                sh 'docker push kareemelkasaby/kareemelkasaby/challenge1-project:latest'
                sh 'docker push kareemelkasaby/kareemelkasaby/challenge1-nginx:$SHA'
                sh 'docker push kareemelkasaby/kareemelkasaby/challenge1-nginx:latest'

            }
        }
        // stage('deploy') {
        //     steps {
        //         /* groovylint-disable-next-line LineLength */
        //         sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 '[ -d '/home/ec2-user/app' ] && (cd ~/app;sudo docker-compose down);echo hi'"
        //         /* groovylint-disable-next-line LineLength */
        //         sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 '[ ! -d '/home/ec2-user/app' ] && mkdir -p ~/app;echo hi'"
        //         /* groovylint-disable-next-line LineLength */
        //         sh "sudo rsync -rv --update -e 'ssh -i $DEPLOYKEY' ./* ec2-user@52.34.4.128:~/app"
        //         sh "sudo scp -i $DEPLOYKEY -p ./.env ec2-user@52.34.4.128:~/app"
        //         sh "sudo ssh -i $DEPLOYKEY ec2-user@52.34.4.128 'cd ~/app;sudo docker-compose up --build -d;exit'"
        //     }
        // }
    }
}
