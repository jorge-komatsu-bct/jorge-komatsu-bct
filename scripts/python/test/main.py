import subprocess
import json
import csv
from datetime import datetime

# Run the command in the terminal
try:
    process = subprocess.Popen(["az", "login"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # Wait for the process to finish
    stdout, stderr = process.communicate()

    if process.returncode != 0:
        raise subprocess.CalledProcessError(process.returncode, process.args, stdout, stderr)

    # Save JSON string to file
    date_format = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    json_filename = f"data_{date_format}.json"
    with open(json_filename, "w") as json_file:
        json_file.write(stdout)

except subprocess.CalledProcessError as e:
    print(f"Command failed with exit code {e.returncode}.")
    print(f"Error output: {e.stderr}")
except Exception as e:
    print("An error occurred:", e)

except Exception as e:
    print("An error occurred:", e)
