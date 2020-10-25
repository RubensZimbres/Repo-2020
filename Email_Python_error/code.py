# Activate a plan on GCP marketplace (free - https://console.cloud.google.com/marketplace/details/sendgrid-app/sendgrid-email)
# Create an api key in sendgrid (https://app.sendgrid.com/settings/api_keys)
# Validate your sendgrid account email

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 24 20:15:07 2020

@author: theone
"""

import numpy as np
import os

os.environ['EMAIL_API_KEY'] = 'ABCD1234'


a=np.array([1])

def email(erro):
    import os
    from sendgrid import SendGridAPIClient
    from sendgrid.helpers.mail import Mail, Email
    from python_http_client.exceptions import HTTPError

    sg = SendGridAPIClient(os.environ['EMAIL_API_KEY'])

    html_content = "<p>{}</p>".format(erro)

    message = Mail(
        to_emails="rubenszmm@gmail.com",
        from_email=Email('rubenszmm@gmail.com', "Rubens"),
        subject="Erro Python Andy",
        html_content=html_content
        )
    #message.add_bcc("[YOUR]@gmail.com")

    try:
        response = sg.send(message)
        return "email.status_code={}".format(response.status_code)
        #expected 202 Accepted

    except HTTPError as e:
        return e.message
    
try:
    a[2]
except Exception as e:
    print('error')
    email(e)

