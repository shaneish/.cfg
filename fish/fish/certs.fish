set CERT_DIR "$HOME/Library/Cigna"
set CERT_FILE "combined.pem"
set CERT_PATH "$CERT_DIR/$CERT_FILE"

if test -f $CERT_PATH
    set -gx CARGO_HTTP_CAINFO $CERT_PATH
    set -gx CURL_CA_BUNDLE $CERT_PATH
    set -gx HEX_CACERTS_PATH $CERT_PATH
    set -gx NODE_EXTRA_CA_CERTS $CERT_PATH
    set -gx REQUESTS_CA_BUNDLE $CERT_PATH
    set -gx SSL_CERT_FILE $CERT_PATH
    set -gx SSL_CERT_PATH $CERT_DIR
end

# aws stuff
set -gx AWS_DEFAULT_REGION us-east-1

function awsl --description "login to aws via aws2saml"
    saml2aws login -a $argv --skip-prompt
    set -gx AWS_PROFILE $argv
end
