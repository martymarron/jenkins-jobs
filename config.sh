#!/bin/sh

if [ -z "${JENKINS_URL+x}" ]; then
  JENKINS_URL=http://localhost:8080/
  echo "info: set default JENKINS_URL=${JENKINS_URL} ."
fi

cat << EOF > /etc/jenkins_jobs/jenkins_jobs.ini
[job_builder]
recursive=True
ignore_cache=True

[jenkins]
user=jenkins
password=jenkins
url=${JENKINS_URL}
query_plugins_info=False
EOF

JOBS_DIR=${HOME}/jobs
if [ ${#} -ne 1 ]; then
  ls ${JOBS_DIR}
elif [ -f "${JOBS_DIR}/${1}.yml" ]; then
  cat ${JOBS_DIR}/${1}.yml
else
  echo "error: ${JOBS_DIR}/${@}.yml does not exist."
fi