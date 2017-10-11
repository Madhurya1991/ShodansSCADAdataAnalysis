import shodan
import sys

SHODAN_API_KEY = ""

api = shodan.Shodan(SHODAN_API_KEY)
def has_vuln(banner, vuln):
	if 'vulns' in banner['opts'] and vuln in banner['opts']['vulns']:
	return True
return False

for banner in api.stream.banners():
	if has_vuln(banner, 'CVE-2015-0204'):
	print banner