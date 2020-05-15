pipeline {
    agent any
    stages {
        stage('conf') {
            steps {
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
        // stage('Run') {
        //     steps {
        //         sh 'terraform apply -auto-approve'
        //     }
        // }
    }
}