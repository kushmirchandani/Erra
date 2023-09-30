/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


const {onCall} = require("firebase-functions/v2/https");
const {onDocumentWritten} = require("firebase-functions/v2/firestore");

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started
 exports.helloWorld = onRequest((request, response) => {
   logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
     
///////new//////
     /*
      How are we going to process the API Data
      How do we export the data given by the cloud function/ remote config  into a swift/python file/how do we use python here
      
      */
     const functions = require('firebase-functions');
     const axios = require('axios');

     exports.callExternalAPI = functions.https.onRequest(async (req, res) => {
       // Replace 'YOUR_MAP_KEY' with your actual map key
       const MAP_KEY = 'YOUR_MAP_KEY';

       const url = `https://firms.modaps.eosdis.nasa.gov/mapserver/mapkey_status/?MAP_KEY=${MAP_KEY}`;

       try {
         const response = await axios.get(url);
         
         // Process the API response as needed
         if (response.status === 200) {
           const data = response.data;
           // Do something with 'data'
           res.status(200).json({ message: 'Data fetched successfully', data });
         } else {
           res.status(response.status).json({ message: 'Error fetching data' });
         }
       } catch (error) {
         console.error(error);
         res.status(500).json({ message: 'Internal server error' });
       }
     });
/////new///////
     
     
 });
