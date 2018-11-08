import json

with open('resultat.json') as f:
	json_content = json.load(f)

print(json_content['id'])
