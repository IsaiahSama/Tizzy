from utils import MessagingService
from os import getenv
from dotenv import load_dotenv
load_dotenv()

tk = getenv("TEST_KEY")
payload = {"body": "Hello there!", "title": "IT ME!"}

if (tk):
    MessagingService.notify_user(tk, payload)