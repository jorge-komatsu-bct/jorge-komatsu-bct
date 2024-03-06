import os
import csv
import subprocess
import json

# Run the Azure CLI command to log in and get the account list
login_output = subprocess.check_output('az login', shell=True)
account_list_output = subprocess.check_output('az account list', shell=True)

# Convert the output to JSON
login_data = json.loads(login_output.decode('utf-8'))
account_list_data = json.loads(account_list_output.decode('utf-8'))

# Specify the CSV file path
csv_file_path = 'output.csv'

# Specify the fieldnames for the CSV header
fieldnames = ['id', 'nombre', 'estado']

# Open the CSV file in write mode
with open(csv_file_path, mode='w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=fieldnames)

    # Write the CSV header
    writer.writeheader()

    # Iterate over each account and write it to the CSV file
    for account in account_list_data:
        # Write only the specified fields
        writer.writerow({'id': account['id'], 'nombre': account['name'], 'estado': account['state']})

print("CSV file has been created successfully!")
