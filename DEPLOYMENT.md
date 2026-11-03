# SmartHire Deployment Guide

## 🚀 Quick Start Local Development

### Prerequisites
- Python 3.11+
- MongoDB Atlas account (free tier available)
- Node.js (optional, for frontend tooling)

### 1. Backend Setup
```bash
cd backend
pip install -r requirements.txt
export MONGO_URI="mongodb+srv://yogalaxmi2710_db_user:8ddKLA0SDgFG4pcy@cluster0.nmb2hie.mongodb.net"
export MONGO_DB="smarthire"
python app.py
```
Backend will run on: `http://localhost:5000`

### 2. Frontend Setup
```bash
cd frontend
python -m http.server 3000
```
Frontend will run on: `http://localhost:3000`

---

## 🐳 Docker Deployment

### Prerequisites
- Docker installed
- Docker Compose installed

### Quick Deploy
```bash
docker-compose up -d
```

### Access
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000
- API Docs: http://localhost:5000/api/candidates

### Stop Services
```bash
docker-compose down
```

### View Logs
```bash
docker-compose logs -f backend
docker-compose logs -f frontend
```

---

## ☁️ Cloud Deployment Options

### Option 1: Azure App Service
```bash
# Login to Azure
az login

# Create resource group
az group create --name smarthire-rg --location eastus

# Create App Service Plan
az appservice plan create --name smarthire-plan --resource-group smarthire-rg --sku B1 --is-linux

# Create Web App
az webapp create --resource-group smarthire-rg --plan smarthire-plan --name smarthire-app --runtime "python|3.11"

# Configure environment variables
az webapp config appsettings set --resource-group smarthire-rg --name smarthire-app --settings \
  MONGO_URI="mongodb+srv://yogalaxmi2710_db_user:8ddKLA0SDgFG4pcy@cluster0.nmb2hie.mongodb.net" \
  MONGO_DB="smarthire"

# Deploy
cd backend
az webapp up --resource-group smarthire-rg --name smarthire-app
```

### Option 2: AWS Elastic Beanstalk
```bash
# Install AWS CLI and EB CLI
pip install awsebcli

# Initialize Elastic Beanstalk
cd backend
eb init -p "python-3.11" smarthire-app

# Create environment
eb create smarthire-env

# Set environment variables
eb setenv MONGO_URI="mongodb+srv://yogalaxmi2710_db_user:8ddKLA0SDgFG4pcy@cluster0.nmb2hie.mongodb.net" \
          MONGO_DB="smarthire"

# Deploy
eb deploy
```

### Option 3: Heroku
```bash
# Install Heroku CLI
# Login
heroku login

# Create app
heroku create smarthire-app

# Add MongoDB Atlas addon
heroku addons:create mongolab:sandbox

# Set config variables
heroku config:set MONGO_URI="mongodb+srv://yogalaxmi2710_db_user:8ddKLA0SDgFG4pcy@cluster0.nmb2hie.mongodb.net"
heroku config:set MONGO_DB="smarthire"

# Deploy
git push heroku main
```

---

## 📝 Environment Variables

Create a `.env` file in the backend directory:
```
MONGO_URI=mongodb+srv://yogalaxmi2710_db_user:8ddKLA0SDgFG4pcy@cluster0.nmb2hie.mongodb.net
MONGO_DB=smarthire
FLASK_ENV=production
SECRET_KEY=change-this-to-random-string
DEBUG=False
```

---

## 📊 Monitoring & Logs

### Docker Logs
```bash
# View all logs
docker-compose logs -f

# View specific service
docker-compose logs -f backend

# Filter by time
docker-compose logs --since 2h
```

### Health Checks
```bash
# Check backend health
curl http://localhost:5000

# Check API endpoints
curl http://localhost:5000/api/candidates/
curl http://localhost:5000/api/jobs/
```

---

## 🔒 Security Checklist

- [ ] Change SECRET_KEY to random value
- [ ] Set DEBUG=False in production
- [ ] Use HTTPS in production
- [ ] Update MongoDB Atlas IP whitelist
- [ ] Use strong passwords for accounts
- [ ] Enable rate limiting
- [ ] Set up CORS properly
- [ ] Use environment variables for secrets
- [ ] Regular backups of MongoDB

---

## 🧪 Testing

### Run API Tests
```bash
cd backend
python -m pytest tests/
```

### Test Coverage
```bash
pytest --cov=routes tests/
```

---

## 🛠️ Troubleshooting

### MongoDB Connection Issues
1. Verify IP whitelist in MongoDB Atlas
2. Check connection string format
3. Ensure network connectivity
4. Review MongoDB Atlas logs

### Frontend Not Loading
1. Check CORS configuration in Flask
2. Verify API URL in frontend config
3. Check browser console for errors
4. Review nginx logs

### Performance Issues
1. Enable caching headers
2. Use database indexes
3. Optimize queries
4. Consider CDN for static assets

---

## 📞 Support & Contact

For issues or questions:
1. Check application logs
2. Review MongoDB Atlas metrics
3. Contact support team

---

## 🔄 CI/CD Pipeline Setup

### GitHub Actions Example
Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy to Production

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build and Deploy
        run: |
          docker build -t smarthire .
          docker-compose up -d
```

---

**Last Updated:** October 5, 2026
**Version:** 1.0
