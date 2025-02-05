#!/usr/bin/env python
# coding: utf-8

# In[1]:


from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json

url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
parameters = {
  'start':'1',
  'limit':'15',
  'convert':'USD'
}
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': '111111111111111111', #use unique API key from CoinMarketCap
}

session = Session()
session.headers.update(headers)

try:
  response = session.get(url, params=parameters)
  data = json.loads(response.text)
  print(data)
except (ConnectionError, Timeout, TooManyRedirects) as e:
  print(e)


# In[3]:


import pandas as pd # import pandas for data analysis tools

pd.set_option("display.max_columns", None)


# In[5]:


df = pd.json_normalize(data["data"])
df["timestamp"] = pd.to_datetime("now") #creating new column "Timestamp" to shop most current time/date


# In[9]:


#setting automation of pulling from cypto API with function
def api_runner():
    global df
    url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest' 
    #Original Sandbox Environment: 'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
    parameters = {
      'start':'1',
      'limit':'15',
      'convert':'USD'
    }
    headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': '111111111111111',
    }

    session = Session()
    session.headers.update(headers)

    try:
      response = session.get(url, params=parameters)
      data = json.loads(response.text)
      #print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
      print(e)

    df2 = pd.json_normalize(data['data'])
    df2['Timestamp'] = pd.to_datetime('now')
    df

    if not os.path.isfile(r"C:\Users\user\Desktop\All files\Personal Projects\Python API cypto Project\CSV api cypto\API.csv"):
        df.to_csv(r"C:\Users\user\Desktop\All files\Personal Projects\Python API cypto Project\CSV api cypto\API.csv", header= "column_names")
    else:
         df.to_csv(r"C:\Users\user\Desktop\All files\Personal Projects\Python API cypto Project\CSV api cypto\API.csv", mode = "a", header = False)
        
        


# In[11]:


import os 
from time import time
from time import sleep

for i in range(333):  
    api_runner()
    print("API Runner completed")
    sleep(60) #sleep for 1 minute
exit()


# In[148]:


df


# In[ ]:




