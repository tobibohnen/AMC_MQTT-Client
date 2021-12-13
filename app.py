import argparse
import uuid
import paho.mqtt.client as mqtt
import ssl



# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    if arg_results.serverMode:
        client.subscribe(topic + "/s/+", qos=0)
    else:
        client.subscribe(topic + "/+", qos=0)


def on_disconnect(mqttc, userdata, rc):
    if rc != 0:
        print("Unexpected disconnection. Reconnecting...")
        client.reconnect()
    else:
        print("Disconnected successfully")


client_id = str(uuid.uuid4())
print("Start up!")
parser = argparse.ArgumentParser(description='SocketCAN To MQTT Conduit')
parser.add_argument('-u', action='store', dest='username', default='test', help='Specify MQTT Username')
parser.add_argument('-p', action='store', dest='password', default='test', help='Specify MQTT Password')
parser.add_argument('-t', action='store', dest='topic', default="AMC", help='Set MQTT topic to use')
parser.add_argument('-H', action='store', dest='mqtthost', default="192.168.178.113",
                    help='Set hostname of MQTT Broker')
parser.add_argument('-P', action='store', dest='mqttport', default=1883, type=int,
                    help='Set port to connect to on MQTT Broker')

arg_results = parser.parse_args()

topic = arg_results.topic

msg = "test"

client = mqtt.Client(client_id=client_id, clean_session=True)

if arg_results.mqttport == 8883:
    client.tls_set(ca_certs=None, certfile=None, keyfile=None, cert_reqs=ssl.CERT_REQUIRED,
                   tls_version=ssl.PROTOCOL_TLS, ciphers=None)
if len(arg_results.username) > 0:
    client.username_pw_set(arg_results.username, arg_results.password)

client.connect(arg_results.mqtthost, arg_results.mqttport, 60)

print("Initialized. Tunneling traffic now.")
client.loop_start()

run = True
while run:
    fullTopic = topic
    client.publish(fullTopic, msg, qos=0)
