import os
import logging
from passgen import passgen
from flask import Flask
from flask import jsonify
from flask import request
import google.cloud.logging
from google.cloud.logging.handlers import CloudLoggingHandler
from google.oauth2 import service_account

keyfile = "./key.json"
gcpproject=""
if 'STACKDRIVER_PROJECT' in os.environ:
    gcpproject = os.environ['STACKDRIVER_PROJECT']

logger = logging.getLogger(__name__)
script_path = os.path.abspath(__file__)
script_dir = os.path.split(script_path)[0]
script_file = os.path.split(script_path)[1]
abs_keyfile_path = os.path.join(script_dir, keyfile)
logger.info('Loading credential file "%s"', abs_keyfile_path)  
logger_credentials = service_account.Credentials.from_service_account_file(abs_keyfile_path)

client = google.cloud.logging.Client(credentials=logger_credentials)
client.project = gcpproject
handler = CloudLoggingHandler(client, script_file)
google.cloud.logging.handlers.setup_logging(handler)

app = Flask(__name__)

@app.route('/hello', methods=["GET", "POST"])
def hello_world():
    logger = logging.getLogger(__name__)
    logger.info("/hello route has been invoked")
    return 'Hello, World!'

@app.route('/health', methods=["GET", "POST"])
def health():
    logger = logging.getLogger(__name__)
    logger.info("/health route has been invoked")
    return jsonify({"status":"healthy"})

@app.route('/chat', methods=["GET", "POST"])
def chat():
    logger = logging.getLogger(__name__)
    logger.info("/chat route has been invoked")

    structlogger = client.logger(script_file)
    try:
        json_data = request.get_json(force=True)
    except Exception as ex:
        logger.exception(ex)
        json_data = None

    data = {"message":"Chat post data", "postdata": json_data}
    structlogger.log_struct(data,severity="INFO")
    logger.info(str(data))

    passwordlength = 12
    if json_data is not None:
        variables = json_data['memoryVariables']
        try:
            passwordlength = int(variables[0]['value'])
            logger.info("password length set to " + passwordlength)

        except:
            pass

    passwd = passgen(length=passwordlength, punctuation=False, digits=True, letters=True, case='both')
    logger.info("password generated")

    return jsonify({"text": str(passwd)})

structlogger = client.logger(script_file)
structlogger.log_struct({"message":"webhook-start", "webhook":script_file})
app.run(host='0.0.0.0',debug=False, port=8080)
structlogger.log_struct({"message":"webhook-end", "webhook":script_file})
