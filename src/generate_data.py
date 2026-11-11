from pathlib import Path 
import pandas as pd
from faker import Faker

BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR /"data" / "raw"
PROCESSED_DIR = BASE_DIR / "data" / "processed"

TOTAL_CUSTOMERS = 500

def generate_customers():
    Faker.seed(42)
    fake = Faker()

    #Load existing customers 
    customers = pd.read_csv(
        RAW_DIR / "customers.csv",
        dtype={"Phone" : "string"}
        )
    
    # Generate new customers
    new_customers = []
    existing_ids = set(customers["CustomerID"])

    for customer_id in range(1, TOTAL_CUSTOMERS + 1):
        if customer_id not in existing_ids:
            continue
            new_customers.append({
                "CustomerID": customer_id,
                "FirstName": fake.first_name(),
                "LastName": fake.last_name(),
                "Email": fake.email(),
                "Phone": fake.phone_number(),
                "Address": fake.address().replace("\n", ", "),
                "City": fake.city(),
                "State": fake.state_abbr(),
                "ZipCode": fake.zipcode()
            })

#combine original and new customers
generated_customers = pd.concat([customers, pd.DataFrame(new_customers)], ignore_index=True)