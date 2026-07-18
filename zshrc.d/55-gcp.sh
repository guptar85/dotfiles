# ==========================================================
# Google Cloud Storage Toolkit
# ==========================================================

export GCP_PROJECT="family-cloud-backup"
export GCS_BUCKET="travel-photo-videos"

gspwd() {
  echo "========================================"
  echo "Project : $GCP_PROJECT"
  echo "Bucket  : gs://$GCS_BUCKET"
  echo "========================================"
}

gsbucket() {
  echo "Command : gsbucket"
  echo "Purpose : Change active bucket"

  export GCS_BUCKET="$1"
  gspwd
}

gshelp() {
  cat <<EOF

======== Google Cloud Storage Toolkit ========

gspwd
    Show current project and bucket

gsbucket <bucket>
    Change active bucket

gsls [path]
    List files

gstree [path]
    Recursive list

gsdu [path]
    Show size

gsup <source> <destination>
    Upload file/folder

gssync <source> <destination>
    Sync local folder to bucket

gsget <source> <target>
    Download from bucket

gsmv <source> <target>
    Move inside bucket

gsrm <path>
    Delete file/folder

gsverify <local> <remote>
    Compare sizes

Examples:

gsup ~/Movies/Andaman Andaman

gssync ~/Videos Family

gsget Family ~/Downloads

gsmv "North Bay" Andaman/

EOF
}

gsls() {
  gspwd
  gcloud storage ls "gs://$GCS_BUCKET/$1"
}

gstree() {
  gspwd
  gcloud storage ls --recursive "gs://$GCS_BUCKET/$1"
}

gsdu() {
  gspwd
  gcloud storage du -sh "gs://$GCS_BUCKET/$1"
}

gsup() {

  echo "========================================"
  echo "Command : gsup"
  echo "Purpose : Upload file/folder"
  echo "Source  : $1"
  echo "Target  : gs://$GCS_BUCKET/$2"
  echo "========================================"

  read "REPLY?Proceed? [y/N]: "
  [[ "$REPLY" =~ ^[Yy]$ ]] || return

  gcloud storage cp --recursive "$1" "gs://$GCS_BUCKET/$2"
}

gssync() {

  echo "========================================"
  echo "Command : gssync"
  echo "Purpose : Sync local folder to bucket"
  echo "Source  : $1"
  echo "Target  : gs://$GCS_BUCKET/$2"
  echo "========================================"

  read "REPLY?Proceed? [y/N]: "
  [[ "$REPLY" =~ ^[Yy]$ ]] || return

  gcloud storage rsync "$1" "gs://$GCS_BUCKET/$2" --recursive
}

gsget() {

  echo "========================================"
  echo "Command : gsget"
  echo "Purpose : Download file/folder"
  echo "Source  : gs://$GCS_BUCKET/$1"
  echo "Target  : $2"
  echo "========================================"

  read "REPLY?Proceed? [y/N]: "
  [[ "$REPLY" =~ ^[Yy]$ ]] || return

  gcloud storage cp --recursive "gs://$GCS_BUCKET/$1" "$2"
}

gsmv() {

  echo "========================================"
  echo "Command : gsmv"
  echo "Purpose : Move inside bucket"
  echo "Source  : gs://$GCS_BUCKET/$1"
  echo "Target  : gs://$GCS_BUCKET/$2"
  echo "========================================"

  read "REPLY?Proceed? [y/N]: "
  [[ "$REPLY" =~ ^[Yy]$ ]] || return

  gcloud storage mv "gs://$GCS_BUCKET/$1" "gs://$GCS_BUCKET/$2"
}

gsrm() {

  echo "WARNING: DELETE OPERATION"
  echo "Target : gs://$GCS_BUCKET/$1"

  read "REPLY?Really delete? [y/N]: "
  [[ "$REPLY" =~ ^[Yy]$ ]] || return

  gcloud storage rm "gs://$GCS_BUCKET/$1"
}

gsverify() {

  echo "Local:"
  du -sh "$1"

  echo ""
  echo "Remote:"
  gcloud storage du -sh "gs://$GCS_BUCKET/$2"
}

gsarchive() {

  echo "Step 1 - Upload"
  gcloud storage rsync "$1" "gs://$GCS_BUCKET/$2" --recursive

  echo ""
  echo "Step 2 - Verify"

  gsverify "$1" "$2"

  echo ""
  echo "Archive completed."
  echo "Delete local files manually after checking."
}
