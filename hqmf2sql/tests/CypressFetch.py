from html.parser import HTMLParser
import requests

class CypressLoginParser(HTMLParser):
    def __init__(self, form_data):
        HTMLParser.__init__(self)
        self.form_data = form_data
        
    def handle_starttag(self, tag, attrs):
        if tag == "input":
            d = dict()
            for a in attrs:
                d[a[0]] = a[1]
            if d.get('name') == 'authenticity_token':
               self.form_data['authenticity_token'] = d.get('value')

class CypressFetch:
    def __init__(self, user, passwd, login_url="http://cypress-demo.isi.edu/users/sign_in"):
        self.form_data = {'user[email]' : user, 'user[password]' : passwd}        
        self.outgoing_headers = {'Accept' : 'text/html, application/json' }
        self.login_url = login_url
        self.last_response = None
    def login(self):
        r=requests.get(self.login_url)
        state = dict()
        p=CypressLoginParser(self.form_data)
        p.feed(r.text)
        self.last_response=requests.post(self.login_url, self.form_data, cookies=r.cookies, headers=self.outgoing_headers)
        return self.last_response
    def fetch(self, url):
        if self.last_response == None:
            self.login()
        print(str(self.last_response))            
        self.last_response = requests.get(url, cookies=self.last_response.cookies, headers=self.outgoing_headers)
        return self.last_response
        

