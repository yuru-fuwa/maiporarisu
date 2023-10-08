import os
from dotenv import load_dotenv

load_dotenv()
api_key = os.environ['GOOGLE_MAP_API_KEY']

with open('web/index.html', 'r') as file:
    html_content = file.read()

html_content = html_content.replace('GOOGLE_MAP_API_KEY', api_key)

with open('web/index.html', 'w') as file:
    file.write(html_content)