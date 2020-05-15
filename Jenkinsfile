pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                sh 'docker build -t kareemelkasaby/challenge1 -f Dockerfile.dev'
                sh 'docker run -d kareemelkasaby/challenge1 python3 tests/test.py'

            }
        }
        // stage('Run') {
        //     steps {
        //         sh 'terraform apply -auto-approve'
        //     }
        // }

    }
}