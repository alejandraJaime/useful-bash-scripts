echo "Please enter the URL you want to send the request to:"
read url

echo "Please enter the JSON body of the request: (Please make sure it's a valid JSON)"
read json_body

echo "⌛️ Waiting on response from " $url

# Make the curl request and save both response and HTTP code
# Create a temporary file for the response body
response_file=$(mktemp)

# Get both the HTTP status code and response body
http_code=$(curl -X POST $url \
     -H "Authorization: bearer $(gcloud auth print-identity-token)" \
     -H "Content-Type: application/json" \
     -d "$json_body" \
     -w "%{http_code}" \
     -s \
     -o "$response_file" \
    )

# Read the response body
response=$(<"$response_file")

# Clean up the temporary file
rm "$response_file"

# Check the HTTP status code and handle accordingly ✨
case $http_code in
    200)
        echo "✅ Success! (HTTP 200)"
        echo "Response data: $response"
        ;;
    400)
        echo "❌ Bad Request (HTTP 400)"
        echo "Error details: $response"
        ;;
    500)
        echo "⚠️ Server Error (HTTP 500)"
        echo "Error details: $response"
        ;;
    *)
        echo "❓ Unexpected Status Code: $http_code"
        echo "Response: $response"
        ;;
esac

# Add a newline for better formatting
echo
