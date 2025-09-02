# Rails Stock Management App - Project Plan

## Overview
A Ruby on Rails 8 stock management application with PostgreSQL that allows creating products, stores, and inventory tracking. The app will be deployed to Azure using Docker and Terraform.

## Technical Stack
- **Backend**: Ruby on Rails 8.x with Ruby 3.4.2
- **Database**: PostgreSQL (local + Azure Database for PostgreSQL)
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Containerization**: Docker + Docker Compose
- **Infrastructure**: Terraform
- **Cloud**: Microsoft Azure
- **Version Control**: GitHub
- **CI/CD**: GitHub Actions
- **Version Management**: asdf (Ruby 3.4.2)

## Project Structure
```
ruby_in_azure/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   └── javascript/
├── config/
├── db/
├── docker/
├── terraform/
├── .github/
│   └── workflows/
├── Dockerfile
├── docker-compose.yml
├── Gemfile
└── README.md
```

## Phase 1: Rails Application Setup

### 1.1 Initialize Rails 8 Application
- [ ] **Git repository setup**
  - Initialize Git repository (`git init`)
  - Create initial `.gitignore` for Rails
  - Initial commit with project structure
- [ ] **asdf setup**
  - Create `.tool-versions` file with Ruby 3.4.2
  - Install Ruby 3.4.2 via asdf
  - Verify Ruby version and gem environment
- [ ] Create new Rails 8 app with PostgreSQL
- [ ] Configure database.yml for PostgreSQL
- [ ] Set up initial gems (pg, rails, hotwire-rails)
- [ ] Configure Hotwire (Turbo + Stimulus)

### 1.2 Database Models & Schema
- [ ] **Product model**
  - name (string, required)
  - barcode (string, unique, required)
  - timestamps
- [ ] **Store model**
  - name (string, required)
  - address (text)
  - contact_info (string)
  - timestamps
- [ ] **Inventory model**
  - product_id (foreign key)
  - store_id (foreign key)
  - available_quantity (integer, default: 0)
  - timestamps
  - Validations: unique product-store combination

### 1.3 Authentication Setup
- [ ] **User model and authentication**
  - User model with email and password
  - Rails 8 built-in authentication (has_secure_password)
  - Session management
  - Password validation and security
- [ ] **Authentication controllers**
  - SessionsController (login/logout)
  - UsersController (registration)
- [ ] **Authorization**
  - Before_action filters for authentication
  - Role-based access control (admin/user)
  - Protected routes and actions

### 1.4 Controllers & Hotwire Views
- [ ] **ProductsController**
  - CRUD operations with Turbo responses
  - Form validation with Stimulus
  - Authentication required
- [ ] **StoresController**
  - CRUD operations with Turbo responses
  - Form validation with Stimulus
  - Authentication required
- [ ] **InventoriesController**
  - Manage available stock levels
  - Real-time updates with Turbo Streams
  - Authentication required
- [ ] **ApplicationController**
  - Common functionality
  - Error handling
  - Authentication helpers

## Phase 1.5: GitHub Actions Pipeline & Staging Deployment

### 1.5.1 GitHub Actions Setup
- [ ] **Create `.github/workflows/` directory**
- [ ] **CI/CD Pipeline** (`.github/workflows/ci.yml`)
  - Trigger on push to main/develop branches
  - Trigger on pull requests
  - Matrix testing (Ruby 3.4.2, PostgreSQL)
- [ ] **Docker Build Pipeline** (`.github/workflows/docker.yml`)
  - Build Docker image on push
  - Push to Azure Container Registry
  - Multi-stage builds for optimization
- [ ] **Staging Deployment** (`.github/workflows/staging.yml`)
  - Deploy to Azure App Service (staging)
  - Run database migrations
  - Health checks post-deployment
  - Terraform infrastructure validation

### 1.5.2 Docker Configuration for CI/CD
- [ ] **Production Dockerfile**
  - Multi-stage build (build + runtime)
  - Ruby 3.4.2 base image
  - PostgreSQL client installation
  - Asset precompilation
  - Security hardening
- [ ] **Docker Compose for CI**
  - Test database setup
  - Redis for caching (if needed)
  - Service dependencies
- [ ] **Docker Registry Setup**
  - Azure Container Registry configuration
  - Image tagging strategy
  - Security scanning
  - Integration with GitHub Actions

### 1.5.3 Terraform Infrastructure for Staging
- [ ] **Terraform Configuration** (`terraform/staging/`)
  - `main.tf` - Main infrastructure configuration
  - `variables.tf` - Input variables
  - `outputs.tf` - Output values
  - `terraform.tfvars` - Environment-specific values
- [ ] **Azure Staging Resources**
  - Resource Group for staging environment
  - Azure Container Registry (staging)
  - Azure App Service Plan (staging)
  - Azure App Service for Containers (staging)
  - Azure Database for PostgreSQL Flexible Server (staging)
  - Virtual Network and Subnets
  - Network Security Groups
  - Application Insights (staging)
- [ ] **Infrastructure as Code**
  - Terraform state management (Azure Storage)
  - Environment-specific configurations
  - Resource tagging strategy
  - Cost management and monitoring

### 1.5.4 Staging Environment Setup
- [ ] **Azure Staging Resources Deployment**
  - Deploy infrastructure with Terraform
  - Configure environment variables
  - Set up secrets management
- [ ] **Staging Deployment Process**
  - Automated deployment on merge to develop
  - Database migration execution
  - Seed data for staging
  - Health check endpoints
- [ ] **Staging Testing**
  - Smoke tests post-deployment
  - Integration test execution
  - Performance monitoring setup

### 1.6 Frontend with Hotwire
- [ ] Set up Turbo for SPA-like experience
- [ ] Implement Stimulus controllers for:
  - Form validation
  - Dynamic form fields
  - Real-time inventory updates
  - Authentication forms
- [ ] Create responsive views with Bootstrap/Tailwind
- [ ] Implement Turbo Streams for live updates
- [ ] Authentication views (login, register)
- [ ] Navigation with user authentication state

### 1.7 Data Generation Scripts
- [ ] **Seed data script** (`db/seeds.rb`)
  - Generate admin user account
  - Generate 100 products with realistic names and barcodes
  - Generate 10 stores with addresses and contact info
  - Generate 1,000 inventory records with random available_quantity
- [ ] **Sample data generator** (`lib/tasks/sample_data.rake`)
  - Rake task for generating test data
  - Configurable quantities (products, stores, inventory)
  - Realistic product names and barcodes
  - Test user accounts
- [ ] **Faker gem integration**
  - Generate realistic product names
  - Generate store addresses and contact information
  - Generate valid barcode formats
  - Generate user email addresses

## Phase 2: Testing & Quality Assurance (After Pipeline Setup)

### 2.1 Test Setup
- [ ] Configure RSpec for testing
- [ ] Set up FactoryBot for test data
- [ ] Configure Capybara for integration tests
- [ ] Add SimpleCov for code coverage
- [ ] Add Faker gem for test data generation
- [ ] Configure RSpec API testing with request specs
- [ ] Set up test database configuration

### 2.2 Test Coverage (MANDATORY - No step proceeds without passing tests)
- [ ] **Model tests**
  - User model validations and authentication
  - Product model validations and associations
  - Store model validations and associations
  - Inventory model validations and associations
  - Custom model methods and scopes
- [ ] **Controller tests**
  - SessionsController (login/logout)
  - UsersController (registration)
  - ProductsController CRUD operations (authenticated)
  - StoresController CRUD operations (authenticated)
  - InventoriesController CRUD operations (authenticated)
  - Error handling and edge cases
  - Authentication redirects
- [ ] **API tests**
  - JSON API endpoints testing
  - Request/response format validation
  - HTTP status code verification
  - Authentication and authorization
  - Token-based authentication
- [ ] **Integration tests**
  - Complete user workflows (login → CRUD operations)
  - Form submissions and redirects
  - Turbo Stream responses
  - Authentication flows
- [ ] **Stimulus controller tests**
  - JavaScript behavior testing
  - DOM manipulation verification
  - Authentication form handling
- [ ] **System tests**
  - End-to-end user scenarios
  - Browser automation with Capybara
  - Authentication workflows
  - Protected route access

### 2.3 Test-Driven Development (TDD) Workflow
- [ ] **Red-Green-Refactor cycle**
  - Write failing test first
  - Implement minimal code to pass
  - Refactor while keeping tests green
- [ ] **Test coverage requirements**
  - Minimum 90% code coverage
  - All public methods must have tests
  - All API endpoints must have tests
- [ ] **Continuous testing**
  - Tests run on every file save
  - Pre-commit hooks for test validation
  - No deployment without 100% test pass rate

### 2.4 GitHub Actions CI/CD (Enhanced)
- [ ] **CI Pipeline Integration**
  - Run full test suite on push/PR
  - **Block merge if tests fail**
  - Code quality checks (RuboCop)
  - Security scanning
  - Test coverage reporting
- [ ] **Docker Integration**
  - Build and test Docker image in CI
  - Multi-architecture builds
  - Image vulnerability scanning
- [ ] **Staging Deployment Integration**
  - Automated staging deployment
  - Post-deployment testing
  - Rollback capabilities

## Phase 3: Containerization (Production Ready)

### 3.1 Docker Setup
- [ ] Create Dockerfile with Ruby 3.4.2
- [ ] Multi-stage build for production
- [ ] Create docker-compose.yml for development
- [ ] Configure PostgreSQL container
- [ ] Add .dockerignore file
- [ ] Health checks for containers

### 3.2 Development Environment
- [ ] Docker Compose for local development
- [ ] Volume mounts for code changes
- [ ] Database seeding with sample data
- [ ] Environment variables management
- [ ] Data generation scripts in container

## Phase 4: Azure Infrastructure

### 4.1 Terraform Configuration
- [ ] **Azure Container Registry (ACR)**
  - Private registry for Docker images
  - Authentication setup
- [ ] **Azure App Service for Containers**
  - Web app configuration
  - Environment variables
  - Scaling settings
- [ ] **Azure Database for PostgreSQL**
  - Flexible server configuration
  - Security groups
  - Backup settings
- [ ] **Networking**
  - Virtual Network
  - Subnets
  - Security groups
  - Private endpoints

### 4.2 Security & Monitoring
- [ ] Azure Key Vault for secrets
- [ ] Application Insights for monitoring
- [ ] Log Analytics workspace
- [ ] Security scanning in CI/CD

## Phase 5: Deployment & DevOps

### 5.1 GitHub Actions Deployment
- [ ] Build and push Docker image to ACR
- [ ] Deploy to Azure App Service
- [ ] Database migrations
- [ ] Health checks post-deployment
- [ ] Rollback capabilities

### 5.2 Environment Management
- [ ] Development environment
- [ ] Staging environment
- [ ] Production environment
- [ ] Environment-specific configurations

## Key Features

### Core Functionality
- ✅ User authentication and authorization
- ✅ Product management (name, barcode)
- ✅ Store management
- ✅ Inventory tracking (product available quantity per store)
- ✅ Real-time updates with Hotwire
- ✅ Responsive web interface

### Advanced Features
- 🔄 Inventory alerts (low stock)
- 🔄 Product search and filtering
- 🔄 Inventory reports
- 🔄 Bulk operations
- 🔄 API endpoints for mobile apps

## Development Workflow

### Local Development
1. Clone repository
2. Run `docker-compose up` for development environment
3. Run `rails db:seed` to populate with sample data (admin user, 100 products, 10 stores, 1K inventory)
4. Access app at `http://localhost:3000`
5. Login with seeded admin account
6. Database accessible at `localhost:5432`

### Application Testing Guide

#### **Phase 1.1 Testing (Rails Setup)**
```bash
# 1. Verify Ruby version
ruby --version  # Should show 3.4.2

# 2. Check gem environment
gem env

# 3. Create and migrate databases
rails db:create
rails db:migrate

# 4. Start development server
rails server

# 5. Test server response
curl -I http://localhost:3000  # Should return HTTP 200 OK

# 6. Test in browser
# Open http://localhost:3000 - should show Rails welcome page
```

#### **Phase 1.2 Testing (Database Models)**
```bash
# 1. Test model creation
rails console
Product.create!(name: "Test Product", barcode: "123456789")
Store.create!(name: "Test Store", address: "123 Main St")
Inventory.create!(product: Product.first, store: Store.first, available_quantity: 10)

# 2. Test validations
Product.create(name: "", barcode: "123456789")  # Should fail validation
Product.create(name: "Test", barcode: "")       # Should fail validation

# 3. Test associations
Product.first.stores
Store.first.products
Inventory.first.product.name
```

#### **Phase 1.3 Testing (Authentication)**
```bash
# 1. Test user creation
rails console
User.create!(email: "test@example.com", password: "password123")

# 2. Test authentication
user = User.find_by(email: "test@example.com")
user.authenticate("password123")  # Should return user object
user.authenticate("wrong")        # Should return false

# 3. Test protected routes
# Try accessing /products without login - should redirect to login
```

#### **Phase 1.4 Testing (Controllers & Views)**
```bash
# 1. Test CRUD operations
rails console
# Create test data
product = Product.create!(name: "Test Product", barcode: "123456789")
store = Store.create!(name: "Test Store", address: "123 Main St")

# 2. Test API endpoints
curl -X GET http://localhost:3000/products
curl -X POST http://localhost:3000/products -d "product[name]=New Product&product[barcode]=987654321"

# 3. Test Hotwire functionality
# Navigate to /products in browser
# Test form submissions with Turbo
# Test real-time updates with Turbo Streams
```

#### **Phase 1.5 Testing (GitHub Actions & Docker)**
```bash
# 1. Test Docker build
docker build -t ruby-in-azure .

# 2. Test Docker run
docker run -p 3000:3000 ruby-in-azure

# 3. Test GitHub Actions locally
act -j ci  # If using act tool
```

#### **Phase 1.6 Testing (Frontend with Hotwire)**
```bash
# 1. Test Turbo functionality
# Navigate between pages - should be SPA-like
# Check browser network tab - should see Turbo requests

# 2. Test Stimulus controllers
# Open browser dev tools
# Check for Stimulus controller registrations
# Test form validations and dynamic behavior

# 3. Test responsive design
# Resize browser window
# Test on mobile devices
```

#### **Phase 1.7 Testing (Data Generation)**
```bash
# 1. Test seed data
rails db:seed
rails console
User.count        # Should be 1 (admin user)
Product.count     # Should be 100
Store.count       # Should be 10
Inventory.count   # Should be 1000

# 2. Test sample data generator
rails sample_data:generate
# Verify data was created correctly
```

#### **General Testing Commands**
```bash
# Run all tests
rspec

# Run specific test types
rspec spec/models/          # Model tests
rspec spec/controllers/     # Controller tests
rspec spec/requests/        # API tests
rspec spec/system/          # System tests

# Run with coverage
COVERAGE=true rspec

# Check code quality
rubocop
brakeman

# Test database
rails db:test:prepare
rails test
```

### Testing (MANDATORY - No deployment without passing tests)
1. Run `rspec` for complete test suite
2. Run `rspec spec/requests/` for API tests
3. Run `rspec spec/system/` for end-to-end tests
4. GitHub Actions runs on every push/PR
5. **Merge blocked if any test fails**
6. Code coverage reports generated (minimum 90%)

### Deployment (Only after all tests pass)
1. **All tests must pass before deployment**
2. Push to main branch triggers deployment
3. Docker image built and pushed to ACR
4. Azure App Service updated
5. Database migrations run automatically
6. Post-deployment health checks

## Security Considerations
- **Authentication & Authorization**
  - Rails 8 built-in authentication (has_secure_password)
  - Session management and security
  - Password strength requirements
  - Role-based access control
- **Data Protection**
  - Environment variables for sensitive data
  - Azure Key Vault integration
  - Database connection encryption
  - Password hashing with bcrypt
- **Application Security**
  - HTTPS enforcement
  - Input validation and sanitization
  - CSRF protection with Rails
  - SQL injection prevention
  - XSS protection

## Monitoring & Maintenance
- Application Insights for performance monitoring
- Log aggregation and analysis
- Automated backups
- Health check endpoints
- Error tracking and alerting

## Estimated Timeline
- **Phase 1**: 3-4 days (Rails setup + Hotwire + Data generation)
- **Phase 1.5**: 2-3 days (GitHub Actions + Docker + Staging deployment)
- **Phase 2**: 3-4 days (Comprehensive testing + TDD + CI/CD integration)
- **Phase 3**: 1-2 days (Production Docker optimization + testing)
- **Phase 4**: 2-3 days (Azure infrastructure + testing)
- **Phase 5**: 1-2 days (Production deployment + testing)

**Total**: 12-18 days (extended due to comprehensive testing and pipeline requirements)

## Prerequisites
- Ruby 3.4.2 (via asdf)
- Docker and Docker Compose
- Azure CLI
- Terraform
- GitHub account
- Azure subscription

## Next Steps
1. Confirm plan approval
2. Initialize Rails 8 application
3. Set up GitHub repository
4. Begin Phase 1 implementation
