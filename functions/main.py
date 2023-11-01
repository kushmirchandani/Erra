
import firebase_admin
from firebase_admin import credentials, db, initialize_app
import requests
import csv
import json

# Initialize Firebase Admin SDK
cred = credentials.Certificate('projFile.json')

firebase_admin.initialize_app(cred)



def copy_data():
    db_ref = db.reference('/')
    db_refTransfer = db.reference('/fires')
    db_refTransfer1 = db.reference('/fires1')

    # Get a reference to the 'fires' node
    fires_ref = db_refTransfer.get()

    if fires_ref is not None:
        db_refTransfer1.set(fires_ref)


def apiCall():


    # Set your map key
    MAP_KEY = 'mapkey'

    # Define the API URL with the map key
    url = 'https://firms.modaps.eosdis.nasa.gov/api/area/csv/' + MAP_KEY + '/VIIRS_NOAA20_NRT/-160,23,-66,71/1'

    try:
   
        batch_size = 10000
        delay_between_batches = .7
        
        db_ref = db.reference('/')
        db_refTransfer = db.reference('/fires')

   #remove oldest data set
        db_refTransfer1 = db.reference('/fires1')
    
        fires1_ref = db_refTransfer1.get()

        for key in fires1_ref:
            db_refTransfer1.child(key).delete()

#get data from new past dataset
     
        copy_data()
# fresh sheet before api call
        db_refTransfer.delete();

# new api call
        response = requests.get(url)
        csv_data = response.text.splitlines()
        csv_reader = csv.reader(csv_data)

        # Skip the header row
        next(csv_reader)
      

        data_batch = []

        for row in csv_reader:
            data = {
                "latitude": row[0],
                "longitude": row[1],
                "bright": row[2],
                "scan": row[3],
                "track": row[4],
                "acq_Date": row[5],
                "acq_time": row[6],
                "satellite": row[7],
                "instrument": row[8],
                "confidence": row[9],
                "version": row[10],
                "bright_ti5": row[11],
                "frp": row[12],
                "daynight": row[13]
            }

            data_batch.append(data)

            if len(data_batch) == batch_size:
                db_ref.child('fires').push().set(data_batch)
                data_batch = []
                time.sleep(delay_between_batches)

        if data_batch:
            db_ref.child('fires').push().set(data_batch)

    except Exception as e:
        print(f"There is an issue with the query: {str(e)}")
        
        
        
apiCall()
