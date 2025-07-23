gcloud storage rm -r gs://www.gadzbi.com/*
rm -rf ./public
hugo
gsutil -m rsync -r public/ gs://www.gadzbi.com/
gsutil -m acl ch -r -u AllUsers:R gs://www.gadzbi.com/
gsutil cors set cors.json gs://www.gadzbi.com
gsutil web set -m index.html -e 404.html gs://www.gadzbi.com/404.html