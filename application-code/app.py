from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
from bs4 import BeautifulSoup
import requests

app = Flask(__name__, static_folder='static')
CORS(app, resources={r"/get_horoscope": {"origins": "http://0.0.0.0"}})

# Define the mapping of zodiac signs to URLs
signs = {
    "aries": 1,
    "taurus": 2,
    "gemini": 3,
    "cancer": 4,
    "leo": 5,
    "virgo": 6,
    "libra": 7,
    "scorpio": 8,
    "sagittarius": 9,
    "capricorn": 10,
    "aquarius": 11,
    "pisces": 12,
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_horoscope', methods=['GET'])
def get_horoscope():
    zodiac_sign = request.args.get('sign')
    if zodiac_sign in signs:
        URL = f"https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign={signs[zodiac_sign]}"
        response = requests.get(URL)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            container = soup.find("p")
            if container:
                horoscope_text = container.text.strip()
                return jsonify({'horoscope': horoscope_text})
    return jsonify({'horoscope': 'Horoscope not found'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5500)
