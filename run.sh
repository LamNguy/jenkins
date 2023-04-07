node {

    def VAULT_ADDR = 'https://vault-dso.techcombank.com.vn'
    def VAULT_PATH_SSH = ''
    def NEXUS_ADDR = 'https://nexus-dso.techcombank.com.vn'
    def NEXUS_CRED = 'nexus-dso-rw'

    def secrets = [
        [
            path: "${VAULT_PATH_SSH}", engineVersion: 2,
            secretValues: [
                [vaultKey: 'VAULT_TOKEN'],
                [vaultKey: 'window_os_user'], [vaultKey: 'window_os_pass']
            ]
        ]
    ]

    def configuration : LinkedHashMap = [
        vaultUrl: "${VAULT_ADDR}",
        vaultCredentialId: 'jenkins_approle',
        engineVersion: 2
    ]

    stage("Checkout SCM") {
        cleanWs()
        checkout scm
    }

    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${NEXUS_CRED}", usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASSWORD']]){
        withVault([configuration: configuration, vaultSecrets: secrets]){
            stage("Run playbook") {
                sh '''
                cat <<EOT > extra_var.yaml
window_os_user: ${window_os_user}
window_os_pass: ${window_os_pass}
nexus_user: ${NEXUS_USER}
nexus_password: ${NEXUS_PASSWORD}
                '''
                sh "cat extra_var.yaml"
                sh """
                    ansible-playbook -i inventory/hosts_window --extra-vars @extra_var.yaml --extra-vars "nexus_addr=${NEXUS_ADDR}" window.yaml
                """
            }
        }
    }
}
