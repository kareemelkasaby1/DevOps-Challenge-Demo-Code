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
                    sh 'docker-compose up --build --force-recreate'
                    sh 'rc=$?'
                    sh 'docker-compose down'
                    sh 'exit $rc'
                    /* groovylint-disable-next-line DuplicateStringLiteral */
                    sh 'docker-compose down'
                }
            }
        }
        post {
            always {
                sh 'docker-compose down -v'
            }
        }

    // stage('Run') {
    //     steps {
    //         sh 'terraform apply -auto-approve'
    //     }
    // }
    }
}
