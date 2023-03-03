# Add dotfiles scripts path and subpaths
#Should be like below due to mess created by ZSH
export PATH="$DOTFILES/scripts/:$PATH"
chmod -R +x "$DOTFILES/scripts/"

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# export REQUESTS_CA_BUNDLE="$HOME/Documents/ZScaler-Certificates/ZscalerRootCertificate-2048-SHA256.pem"
export REQUESTS_CA_BUNDLE="/opt/homebrew/Cellar/azure-cli/2.45.0/libexec/lib/python3.10/site-packages/certifi/cacert.pem"


# Add dotfiles scripts path and subpaths
#while read -r path; do
#  export PATH="$path:$PATH"
#done <<< "$(find "$DOTFILES/scripts" -type d)"

#for path in $(find "$DOTFILES/scripts" -type d)
#   export PATH="$path:$PATH"
#done ;
