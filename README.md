# LaraKube - Laravel on Kubernetes

## Introduction

This repository contains optimized PHP base images for Laravel applications with MySQL and PostgreSQL support. 
The images are designed to be minimal yet functional foundations that you can quickly build upon for your Laravel deployments.

## Image Features

- Support for PHP 8.2, 8.3, and 8.4
- MySQL and PostgreSQL drivers pre-installed
- Optimized for size (multi-stage builds)
- Compatible with Laravel applications
- Ready to be extended with your application code

## How to Use These Base Images

### 1. With Docker Compose for Development

```yaml
# docker-compose.yml
version: '3'

services:
  app:
    image: ghcr.io/lara-kube/php:8.4
    volumes:
      - ./:/var/www/html
    working_dir: /var/www/html
    networks:
      - laravel

  nginx:
    image: nginx:alpine
    ports:
      - "8000:80"
    volumes:
      - ./:/var/www/html
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    networks:
      - laravel

networks:
  laravel:
```

### 2. In Your Laravel Application's Dockerfile

```dockerfile
# Use the base image
FROM ghcr.io/lara-kube/laravel-php:8.3

# Set working directory
WORKDIR /var/www/html

# Copy application code
COPY --chown=laravel:laravel . .

# Install dependencies
RUN composer install --optimize-autoloader --no-dev
RUN php artisan optimize

# Start PHP-FPM
CMD ["php-fpm"]
```

## Image Size Optimization Techniques

These base images incorporate several techniques to minimize size:

1. **Alpine Linux**: Using Alpine as the base provides a much smaller footprint than Debian/Ubuntu.
2. **Multi-stage builds**: The build process separates the build dependencies from the runtime image.
3. **Selective extension installation**: Only necessary PHP extensions are installed.
4. **Layer optimization**: Commands are grouped to reduce the number of layers.

The resulting images should be ~120-150MB, significantly smaller than the 850MB you were experiencing.

## GitHub Repository Setup

1. Create a new repository on GitHub
2. Make sure your repository has the proper permissions to publish packages:
    - Go to your repository settings
    - Navigate to "Actions" > "General"
    - Under "Workflow permissions", select "Read and write permissions"
3. Push the code structure above to your repository
4. The GitHub Action will build and push the images to GitHub Container Registry when you push to the main branch
5. The images will be available at `ghcr.io/lara-kube/laravel-php:tag`

## Kubernetes Deployment

When deploying to Kubernetes, you can use these base images in your deployment configuration:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: laravel-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: laravel-app
  template:
    metadata:
      labels:
        app: laravel-app
    spec:
      containers:
      - name: laravel-app
        image: ghcr.io/your-github-username/your-laravel-app:latest
        # Your Laravel app built from the base image
```

## Additional Considerations

1. **Customization**: Each application will need to install its own dependencies using Composer.
2. **Node.js**: If your application requires Node.js for asset compilation, you'll need to install it in your application's Dockerfile, not in these base images.
3. **Extensions**: If you need additional PHP extensions beyond what's included, you can add them in your application's Dockerfile.