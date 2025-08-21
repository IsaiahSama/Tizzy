# Tizzy Server

This is the backend server for the Tizzy ecosystem, responsible for device pairing, messaging, and facilitating communication between paired users and their devices (including the Bangle JS 2 smartwatch).

This API will be developed using:

- FastAPI
- MongoDB
- Firebase Messaging

---

## 🚀 Quick Start / Build Instructions

### 1. Prerequisites

- Python 3.10 or newer (recommended: 3.12+)
- [pip](https://pip.pypa.io/en/stable/)
- (Optional) [virtualenv](https://virtualenv.pypa.io/en/latest/) for isolated environments

### 2. Setup

Clone the repository and navigate to the server directory:

```sh
git clone https://github.com/IsaiahSama/Tizzy
cd Tizzy/server
```

Create and activate a virtual environment (recommended):

```sh
python -m venv venv
# On Windows:
venv\Scripts\activate
# On Mac/Linux:
source venv/bin/activate
```

Install dependencies:

```sh
pip install -r requirements.txt
```

### 3. Configuration

- Copy `.env.example` to `.env` and fill in any required environment variables (if present).
- By default, the server uses sensible defaults for local development.
- Setup Firebase Messaging support using [the documentation](https://firebase.google.com/docs/cloud-messaging/server). This will give you a file containing your credentials. You can save this file in `/server` as `/server/sdk.json`. If you choose to store it elsewhere, update the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to point to it.
- Create a Mongo Database, and place the connection URL as `MONGODB_URL` in your environment variables. Be sure to whitelist your server's IP in your Mongo environment.

### 4. Run the Server

```sh
python app.py
```

The server will start on the default port (usually 5000 or as specified in your `.env`).

---

## 🛠️ Project Structure

```
server/
├── app.py                # Main entry point for the server
├── models/               # Data models (e.g., device, tempo_message)
├── routes/               # API route definitions
├── utils/                # Utility modules (DB, messaging, etc.)
├── tests/                # Unit and integration tests
├── requirements.txt      # Python dependencies
├── .env                  # (Optional) Environment variables
├── sdk.json              # SDK or API schema/config (if used)
└── README.md             # This file
```

---

## 📚 How It Works

The Tizzy server is a lightweight Python web server (Flask-based) that provides the following core features:

### 1. Device Registration & Pairing
- Each device registers with the server and receives a unique ID.
- Devices can pair with a companion by sharing and submitting their unique IDs.
- The server manages the pairing logic and stores device relationships.

### 2. Messaging
- Devices can send messages ("Tizzies" or "Tempo" messages) to their paired companion.
- The server receives, stores, and forwards these messages to the appropriate device.
- Messages can include custom text and are delivered in real-time if the recipient is online, or queued for later delivery.

### 3. Watch Integration (Bangle JS 2)
- The server can relay messages to a paired Bangle JS 2 smartwatch via the mobile app.
- The watch receives subtle vibrations and custom messages sent from the paired device.

### 4. API Endpoints
- All core functionality is exposed via RESTful API endpoints (see `routes/` for details).
- Endpoints include device registration, pairing, sending/receiving messages, and status checks.

### 5. Storage
- The server uses a simple database (e.g., MongoDB or in-memory, see `utils/mongo_db.py`) to persist device and message data.

---

## 🧪 Testing

Run tests from the `server/` directory:

```sh
python -m unittest discover tests
```

---

## 🌐 Deployment

- The server can be deployed to any platform that supports Python (Heroku, Render, DigitalOcean, etc.).
- For deployment, ensure you use HTTPS (required for Bangle JS direct communication).
- Adjust environment variables and configuration as needed for your deployment target.

---

## 🤝 Contributing

Pull requests and issues are welcome! Please see the main project README for guidelines.

---