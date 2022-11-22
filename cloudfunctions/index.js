const functions = require("firebase-functions");

 // Create and deploy your first functions
 // https://firebase.google.com/docs/functions/get-started

const admin = require('firebase-admin');
admin.initializeApp();
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');


exports.saveFCMToken = functions.https.onRequest(async (request, response) => {

  //supaya flutter nggak ngomel kalau cross origin, untuk yang versi WEB
  response.set('Access-Control-Allow-Origin', "*")
  response.set('Access-Control-Allow-Methods', 'GET, POST');

  const fcmToken = request.query.fcm;

  const db = getFirestore();

  const tokenRef = db.collection('fcm').doc('token');
  const token1 = await tokenRef.get();
  const token = token1.data();


//  response.json({result: token.data()});

  //masukan kalau belum ada
  if (token["tokenList"].indexOf(fcmToken) < 0){
      token["tokenList"].push(fcmToken)
  }

  const res = await db.collection('fcm').doc('token').set(token);

  response.json({result: fcmToken});

});


exports.sendFCM = functions.https.onRequest(async (request, response) => {

  //supaya flutter nggak ngomel kalau cross origin, untuk yang versi WEB
  response.set('Access-Control-Allow-Origin', "*")
  response.set('Access-Control-Allow-Methods', 'GET, POST');

  const message = request.query.message;

  const db = getFirestore();

  const tokenRef = db.collection('fcm').doc('token');
  const token1 = await tokenRef.get();
  const token = token1.data();

  const tokenList = token["tokenList"];

  for (i = 0; i < tokenList.length; i++) {
    const fcmToken = tokenList[i];
    const payload = {
        token: fcmToken,
        notification: {
            title: 'cloud function demo',
            body: message
        },
        data: {
            body: message,
        }
    };

    admin.messaging().send(payload).then((response) => {
        // Response is a message ID string.
        console.log('Successfully sent message:', response);
        return {success: true};
    }).catch((error) => {
        return {error: error.code};
    });
  }

  response.json({result: message});

});


// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
