pipeline {
  options {
      buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  agent any
  environment {
     NODE_ENV = 'prod'
  }
  stages {
    stage('Checkout SCM') {
      steps {
        script {
          
          // calculate GIT lastest commit short-hash
          gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
          shortCommitHash = gitCommitHash.take(7)
          // calculate a sample version tag
          VERSION = shortCommitHash
          // set the build display name
          currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
          IMAGE = "$PROJECT:$VERSION"

          echo 'git_branch:' + env.GIT_BRANCH
 
        }
      }
    }
    stage('Deploy Step') {
	  steps {
	    script {
	       sh 'buil.sh $NODE_ENV'
		}
	  }
    }
  }
}
