set -gx CERT_DIR "~/Library/Cigna"
set -gx CERT_PATH "$CERT_DIR/cacert.pem"

if test -e "$CERT_PATH"
    set -gx CARGO_HTTP_CAINFO $CERT_PATH
    set -gx CURL_CA_BUNDLE $CERT_PATH
    set -gx HEX_CACERTS_PATH $CERT_PATH
    set -gx NODE_EXTRA_CA_CERTS $CERT_PATH
    set -gx REQUESTS_CA_BUNDLE $CERT_PATH
    set -gx SSL_CERT_FILE $CERT_PATH
    set -gx SSL_CERT_PATH $CERT_DIR
end

