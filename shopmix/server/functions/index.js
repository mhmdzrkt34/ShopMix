/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const stripe=require("stripe")(functions.config().stripe.testkey)

const calculateOrderAmmount=(items){

    prices=[];
    catalog=[{
        'id':'0','price':2.99,
        'id':'1','price':3.99
    }];

    items.forEach(item=>{

        price=catalog.find(x=>x.id==item.id).price;
        price.push(price);
    });

    return parseInt(prices.reduce((a,b)=>a+b)*100);
}


const generateResponse=function(intent){
    switch(intent.status){
        case 'requires_action':
            return {

                clientSecret:intent.clientSecret,
                requiresAction:true,
                status:intent.status,
            };
            case 'requires_payment_method':
                return {
                    'error':'Your card was denied, please provide a new payment method',
                }

            case 'succeeded':
                console.log("payment succeeded.");
                return {clientSecret:intent.clientSecret,status:intent.status};



    }
    return {error:"Failed"};
}


exports.StripePayEndpointMethodId=funcions.https.onRequest(async (req,res)=>{

    const {paymentMethodId,items,currency,useStripeSdk,}=req.body;

    const orderAmount=calculateOrderAmmount(items);

try{

    if(paymentMethodId){


        const params= {
            amount:orderAmount,
            confirm:true,
            confirmation_method:"manual",
            currency:currency,
            payment_method:paymentMethodId,
            use_stipe_skd:useStripeSdk,
        }
        const intent=await stripe.paymentIntents.create(params);

        console.log(`Intent: ${intent}`);
        return res.send(generateResponse(inten));
    }

    return res.sendStatus(400)


}catch(e){
    return res.send({error:e.message});

}
});

exports.StripePayEndpointIntentId=funcions.https.onRequest(async (req,res)=>{

 const {paymentIntentId}=req.body;

 try {
    if(paymentIntentId){
        const intent=await stripe.paymentIntents.confirm(paymentIntentId);

        return res.send(generateResponse(intent));


    }
    return res.sendStatus(400);


 }catch(e){
    return res.send({error:e.message});

 }
     
});




// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
