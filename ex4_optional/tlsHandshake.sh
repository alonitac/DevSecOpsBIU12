
server_res=$(curl -POST --url  http://localhost:8080/clienthello --header  'Content-Type: application/json' \
           -d '{"clientVersion":"3.2","message":"Client Hello"}' )
serverVersion=$( jq '.serverVersion' <<< $server_res )
SESSION_ID=$( jq '.sessionID' <<< $server_res )
serverCert=$( jq '.serverCert' <<< $server_res ) 

echo $serverCert >> cert.pem 

#echo "serverVersion = $serverVersion    SESSION_ID=$SESSION_ID="

wget https://devops-may22.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem

VERIFICATION_RESULT=$( openssl verify -CAfile cert-ca-aws.pem cert.pem )

if [ "$VERIFICATION_RESULT" != "cert.pem: OK" ]; then
  echo "Server Certificate is invalid."
  exit 1
fi

openssl rand -base64 -out 'masterKey.txt'  240
MASTER_KEY=$( openssl smime -encrypt -aes-256-cbc -in masterKey.txt -outform DER cert.pem | base64 -w 0 )


server_res=$(curl -POST --url  http://localhost:8080/keyexchange --header  'Content-Type: application/json' \ 
           -d '{"sessionID":"'$SESSION_ID'", "masterKey":"'$MASTER_KEY'", "sampleMessage":"Hi server, please encrypt me and send to client!" }' )


cat encSampleMsg.txt | base64 -d > encSampleMsgReady.txt

if [ "$DECRYPTED_SAMPLE_MESSAGE" != "Hi server, please encrypt me and send to client!" ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 1
else
  echo "Client-Server TLS handshake has been completed successfully"
fi