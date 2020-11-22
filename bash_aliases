alias ..='cd ..'
alias fvim='vim $(fzf)'

alias atlas-ng='. ~/venvs/atlas-ng/bin/activate'
alias dashboard='cd ~/Unyc/atlas/atlas-ng/atlas/dashboard/'
alias dashboard-frontend='cd ~/Unyc/atlas/atlas-ng/atlas/frontend/src/components/shortcuts'
alias dashboard-frontend-module='cd ~/Unyc/atlas/atlas-ng/atlas/frontend/src/stores/modules/dashboard'

alias minio-server='sudo docker run -p 9000:9000 -v ~/minio_data:/data \
    -e "MINIO_ACCESS_KEY=minioadmin" -e "MINIO_SECRET_KEY=minioadmin" minio/minio server /data'
