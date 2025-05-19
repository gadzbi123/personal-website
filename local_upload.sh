sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
sudo dnf install google-cloud-cli
gcloud init
#gcloud storage buckets create gs://personal-website-bucket-20250515 --location=EUROPE-CENTRAL2
gcloud storage buckets create gs://www.gadzbi.com --location=EUROPE-CENTRAL2

# removes whole bucket
gcloud storage rm -r gs://www.gadzbi.com/
rm -rf ./public
hugo-prod
#gcloud storage rm -r gs://personal-website-bucket-20250515/public/
#gcloud storage cp --recursive public/ gs://personal-website-bucket-20250515
#gsutil -m rsync -r public/ gs://personal-website-bucket-20250515/public/
#gsutil -m acl ch -r -u AllUsers:R gs://personal-website-bucket-20250515/public/
#gsutil web set -m public/index.html -e 404.html gs://personal-website-bucket-20250515
gsutil -m rsync -r public/ gs://www.gadzbi.com/
# let all them see
gsutil -m acl ch -r -u AllUsers:R gs://www.gadzbi.com/
# skonfiguruj index.html w GCP dla bucketa

gsutil web set -m index.html -e 404.html gs://www.gadzbi.com
# add data to dns for www and @ like on image (final-dns)
# sync cors
gsutil cors set cors.json gs://personal-website-bucket-20250515
# get bucket list
gcloud compute backend-buckets list
