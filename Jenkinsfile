pipeline {
    agent any
    environment {

    }
    stages {
        stage('tests') {
            steps {
                parallel 'unit': {
                    sh 'docker build -t kareemelkasaby/challenge1 -f ./challenge1-project/Dockerfile.dev ./challenge1-project'
                    sh 'docker run kareemelkasaby/challenge1 python3 tests/test.py'
                },
                'integration': {
                    sh "docker-compose up --build --force-recreate"
                    sh "docker-compose down"
                }
            }

            }
           
        // stage('Run') {
        //     steps {
        //         sh 'terraform apply -auto-approve'
        //     }
        // }

    }
}