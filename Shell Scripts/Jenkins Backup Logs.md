```bash
#!/bin/bash

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)

# Variables
JENKINS_HOME="/var/lib/jenkins"  # Replace with your Jenkins home directory
S3_BUCKET="practisedomain.cloud"  # Replace with your S3 bucket name
S3_PATH="s3://$S3_BUCKET/$YEAR/$MONTH/$DAY/"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it to proceed."
    exit 1
fi

# Iterate through all job directories
for job_dir in "$JENKINS_HOME/jobs/"*/; do
    job_name=$(basename "$job_dir")
    # Iterate through build directories for the job
    for build_dir in "$job_dir/builds/"*/; do
        build_number=$(basename "$build_dir")
        log_file="$build_dir/log"
        # Check if log file exists and was created today
        if [ -f "$log_file" ] && [ "$(date -r "$log_file" +%Y-%m-%d)" == "$(date +%Y-%m-%d)" ]; then
            # Upload log file to S3 with the build number as the filename
            aws s3 cp "$log_file" "s3://$S3_BUCKET/$YEAR/$MONTH/$DAY/$job_name-$build_number.log" --only-show-errors


            if [ $? -eq 0 ]; then
                echo "Uploaded: $job_name/$build_number to $S3_BUCKET/$YEAR/$MONTH/$DAY/$job_name-$build_number.log"
            else
                echo "Failed to upload: $job_name/$build_number"
            fi
        fi
    done
done
```
