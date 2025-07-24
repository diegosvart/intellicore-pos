# IntelliCore POS

**Intelligent, Modular Point-of-Sale Engine for Modern Businesses**

🚀 **Universal Commerce Core:** Adaptable sales engine that powers any business type  
🧠 **AI-Driven Analytics:** Built-in machine learning for predictive insights  
🔧 **Modular Architecture:** Enable only the features you need  
📊 **Real-time Intelligence:** Customer journey tracking and behavioral analytics  
🌐 **Omnichannel Ready:** QR self-service, traditional POS, online integration  
⚡ **High Performance:** PostgreSQL-based with optimized queries  
🔒 **Enterprise Security:** Multi-tenant, role-based access control  

## Perfect for:
- Restaurants & Bars (QR self-service + traditional)
- Retail Stores (inventory + sales)
- Service Businesses (appointments + billing)
- Multi-location Chains (centralized analytics)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/tu-usuario/intellicore-pos.git
cd intellicore-pos

# Start development environment
docker-compose up -d

# Install dependencies
npm install
```

## Project Structure

```
intellicore-pos/
├── docs/                    # Documentation
├── shared/                  # Shared code between frontend/backend
├── backend/                 # FastAPI backend
├── frontend/                # Angular frontend
├── database/                # Database schemas and migrations
├── infrastructure/          # AWS/Docker configurations
└── scripts/                 # Utility scripts
```

## Tech Stack

- **Backend:** Python 3.11, FastAPI, SQLAlchemy
- **Frontend:** Angular 17, TypeScript, RxJS
- **Database:** PostgreSQL 15
- **Analytics:** Pandas, Scikit-learn
- **Infrastructure:** Docker, AWS
- **Documentation:** LLM-optimized Markdown

## Features

### 🎯 Core Business Logic
- Multi-table management with real-time status
- Customer identification and tracking
- Product catalog with recipes and cost control
- Inventory management with automatic alerts

### 🔄 QR Self-Service
- Complete customer journey tracking
- Real-time decision analytics
- Abandoned cart analysis
- ML-powered recommendations

### 💳 Advanced Payment Processing
- Split billing support (pay individually or together)
- Multiple payment methods per transaction
- Real-time payment validation
- Integrated tip management

### 📊 Business Intelligence
- Real-time dashboard with KPIs
- Predictive analytics for demand forecasting
- Customer behavior analysis
- Performance optimization recommendations

## Development

### Prerequisites
- Node.js 18+
- Python 3.11+
- Docker & Docker Compose
- PostgreSQL 15

### Setup Development Environment
```bash
# Install dependencies
npm run setup:dev

# Start all services
npm run dev

# Run tests
npm run test

# Deploy demo
npm run deploy:demo
```

## Architecture

The system follows a layered architecture:

1. **Core Business Layer:** Essential POS functionality
2. **Advanced Operations:** Multi-client, inventory, kitchen workflow
3. **QR Self-Service:** Customer-facing digital experience
4. **Payment Processing:** Split billing and multi-method support
5. **Analytics & ML:** Business intelligence and predictions

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---
*From simple POS to intelligent business platform*
