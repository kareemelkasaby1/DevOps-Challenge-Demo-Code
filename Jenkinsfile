pipeline {
    agent any
    stages {
        stage('conf') {
            steps {
                sh 'ansible-playbook -i inventory playbook.yml -e ansible_python_interpreter="/usr/bin/python3"'
            }
        }
        // stage('Run') {
        //     steps {
        //         sh 'terraform apply -auto-approve'
        //     }
        // }
        //hi tany l2aaa
    }
}