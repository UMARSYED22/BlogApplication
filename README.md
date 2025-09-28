# Blog Application 📝

A full-featured Ruby on Rails blog application with user authentication, commenting system, and email notifications. Built with Docker for easy deployment and development.

## 🚀 Features

- **User Authentication** - Powered by Devise with forgot password functionality
- **Blog Management** - Create, edit, and publish blog posts
- **Comments System** - Nested comments on blog posts and tweets
- **Tweet Functionality** - Short-form posting system
- **Email Notifications** - Password reset and other notifications
- **Admin Panel** - Role-based access control with PeterGate
- **Responsive Design** - Bootstrap-powered responsive UI
- **Pagination** - Efficient content pagination with Kaminari
- **SEO Friendly** - Friendly URLs with FriendlyId gem

## 🛠 Tech Stack

- **Backend**: Ruby 3.3.6, Rails 7.2.2
- **Database**: MySQL 8.0
- **Cache**: Redis
- **Authentication**: Devise
- **Authorization**: PeterGate
- **Frontend**: Bootstrap, Stimulus, Turbo
- **Containerization**: Docker & Docker Compose
- **Deployment**: AWS ECS, ECR, RDS

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop/)
- **Git** - For cloning the repository
- **Text Editor** - VS Code, Sublime, etc.

## 🏃‍♂️ Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/blog-application.git
cd blog-application
```

### 2. Set Up Environment Variables

Create a `.env` file in the project root:

```bash
cp .env.example .env
```

Edit the `.env` file with your email credentials:

```env
# Email Configuration (for password reset emails)
GMAIL_USERNAME=your-email@gmail.com
GMAIL_PASSWORD=your-gmail-app-password

# Database Configuration (already configured for Docker)
DATABASE_URL=mysql2://rails:Rails@1234@db:3306/project_development
REDIS_URL=redis://redis:6379/0
```

**📧 Gmail Setup for Email Features:**
1. Enable 2-factor authentication on your Google account
2. Generate an App Password: Google Account → Security → App Passwords
3. Use the 16-character app password (not your regular Gmail password)

### 3. Run with Docker Compose (Recommended)

**Start the entire application stack:**

```bash
# Build and start all services (database, redis, web app)
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

**Wait for the services to start**, then visit: **http://localhost:3000**

### 4. Set Up the Database

In a new terminal window:

```bash
# Create and migrate the database
docker-compose exec web rails db:create db:migrate

# Seed with sample data (optional)
docker-compose exec web rails db:seed
```

### 5. Access the Application

- **Application**: http://localhost:3000
- **Database**: MySQL on localhost:3306
- **Redis**: localhost:6379

**Sample Users Created by Seeding:**
- Email: `user1@example.com` to `user5@example.com`
- Password: `password123`

## 🔧 Development Commands

### Essential Docker Commands

```bash
# View logs
docker-compose logs web
docker-compose logs -f web  # Follow logs

# Access Rails console
docker-compose exec web rails console

# Run tests
docker-compose exec web rails test

# Access container shell
docker-compose exec web bash

# Stop all services
docker-compose down

# Rebuild after code changes
docker-compose up --build
```

### Database Commands

```bash
# Reset database
docker-compose exec web rails db:drop db:create db:migrate db:seed

# Create migration
docker-compose exec web rails generate migration YourMigrationName

# Run specific migration
docker-compose exec web rails db:migrate:up VERSION=20250101000000
```

### Debugging Commands

```bash
# Check container status
docker-compose ps

# View container resource usage
docker stats

# Access MySQL directly
docker-compose exec db mysql -u rails -pRails@1234 project_development
```

## 🚀 Production Deployment

### Local Production Testing

```bash
# Build production image
docker build -t blog-app:latest .

# Run production container
docker run -p 3000:3000 --env-file .env blog-app:latest
```

### AWS Deployment

The application includes AWS ECS deployment configuration:

1. **Prerequisites**: AWS CLI configured with appropriate permissions
2. **Update deployment script**: Edit `deploy-aws.sh` with your AWS details
3. **Deploy**: Run `./deploy-aws.sh`

See `ecs-task-definition.json` and `docker-compose.prod.yml` for production configuration.

## 📁 Project Structure

```
├── app/                    # Rails application code
│   ├── controllers/        # Request handlers
│   ├── models/            # Data models
│   ├── views/             # Templates
│   └── mailers/           # Email functionality
├── config/                # Configuration files
├── db/                    # Database migrations and seeds
├── docker-compose.yml     # Development Docker setup
├── docker-compose.prod.yml # Production Docker setup
├── Dockerfile             # Production Docker image
├── Dockerfile.dev         # Development Docker image
└── deploy-aws.sh          # AWS deployment script
```

## 🐛 Troubleshooting

### Common Issues

**Port already in use:**
```bash
docker-compose down
# Or change ports in docker-compose.yml
```

**Database connection errors:**
```bash
docker-compose down
docker-compose up -d db
# Wait 30 seconds for MySQL to fully start
docker-compose up web
```

**Email not sending:**
- Verify Gmail credentials in `.env`
- Check that Gmail App Password is used (not regular password)
- Ensure 2FA is enabled on Google account

**Permission errors:**
```bash
sudo chown -R $USER:$USER .
```

### Viewing Logs

```bash
# Application logs
docker-compose logs web

# Database logs
docker-compose logs db

# All logs
docker-compose logs
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Run tests: `docker-compose exec web rails test`
5. Commit changes: `git commit -am 'Add feature'`
6. Push to branch: `git push origin feature-name`
7. Submit a Pull Request

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Support

If you encounter any issues:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Review Docker and application logs
3. Create an issue on GitHub with error details

---

**Happy Coding! 🎉**
