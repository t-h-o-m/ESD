import json

with open('resultat.json') as f:
	json_content = json.load(f)

for content in json_content:
	print(content['ip'])
