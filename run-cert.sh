# useful commands
brew install mkcert nss
mkcert -install

# generate the local cert
mkcert localhost 127.0.0.1 web-service ::1

# suppose the generate cert names are localhost+3.pem and localhost+3-key.pem
mkdir -p nginx/ssl
cp localhost+3.pem nginx/ssl/nginx.crt
cp localhost+3-key.pem nginx/ssl/nginx.key

# only for testing
cp "$(mkcert -CAROOT)/rootCA.pem" nginx/ssl/rootCA.pem
