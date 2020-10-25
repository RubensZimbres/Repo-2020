from twilio.rest import Client

def sms(erro):
    account_sid = 'ABCD12345'
    auth_token = 'abcd1234'
    client = Client(account_sid, auth_token)
    
    message = client.messages \
        .create(
             body=erro,
             from_='+12514512222',
             to='+5511998332222'
         )
    print(message.sid)

