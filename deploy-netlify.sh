#!/bin/bash

# Quick Deployment Script for Netlify
# Military Patrol Tracking System

set -e

echo "=========================================="
echo "  Military Patrol Tracking System"
echo "  Netlify Deployment Script"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Git is initialized
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Git not initialized. Initializing...${NC}"
    git init
    git add .
    git commit -m "Initial commit - Military Patrol Tracking System"
    echo -e "${GREEN}✓ Git initialized${NC}"
else
    echo -e "${GREEN}✓ Git already initialized${NC}"
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}Uncommitted changes detected. Committing...${NC}"
    git add .
    git commit -m "Update - $(date +'%Y-%m-%d %H:%M:%S')"
    echo -e "${GREEN}✓ Changes committed${NC}"
else
    echo -e "${GREEN}✓ No uncommitted changes${NC}"
fi

# Check if remote exists
if ! git remote get-url origin &>/dev/null; then
    echo -e "${YELLOW}No Git remote configured.${NC}"
    echo ""
    echo "To deploy, you need to:"
    echo "1. Create a repository on GitHub (https://github.com/new)"
    echo "2. Copy the repository URL"
    echo "3. Run: git remote add origin <your-repo-url>"
    echo "4. Run: git push -u origin main"
    echo ""
    echo "Then run this script again."
    exit 1
else
    echo -e "${GREEN}✓ Git remote configured${NC}"
fi

# Check if Netlify CLI is installed
if ! command -v netlify &>/dev/null; then
    echo -e "${YELLOW}Netlify CLI not installed. Installing...${NC}"
    npm install -g netlify-cli
    echo -e "${GREEN}✓ Netlify CLI installed${NC}"
else
    echo -e "${GREEN}✓ Netlify CLI already installed${NC}"
fi

# Check if logged in to Netlify
if ! netlify status &>/dev/null; then
    echo -e "${YELLOW}Not logged in to Netlify. Login required...${NC}"
    netlify login
    echo -e "${GREEN}✓ Logged in to Netlify${NC}"
else
    NETLIFY_AUTH=$(netlify status | grep "Authenticated as")
    echo -e "${GREEN}✓ ${NETLIFY_AUTH}${NC}"
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}Current branch: ${CURRENT_BRANCH}${NC}"

# Push to GitHub
echo ""
echo -e "${YELLOW}Pushing code to GitHub...${NC}"
git push -u origin ${CURRENT_BRANCH}
echo -e "${GREEN}✓ Code pushed to GitHub${NC}"

# Deploy to Netlify
echo ""
echo -e "${YELLOW}Deploying to Netlify...${NC}"

# Check if netlify.toml exists
if [ -f "netlify.toml" ]; then
    echo -e "${GREEN}✓ netlify.toml found${NC}"
    netlify deploy --prod
else
    echo -e "${YELLOW}netlify.toml not found. Creating...${NC}"
    netlify init --prod
    
    # Configure build settings
    echo "Configuring build settings..."
    echo ""
    
    # Create netlify.toml with correct settings
    cat > netlify.toml << 'NETLIFY_EOF'
[build]
  command = "bun run build"
  publish = ".next"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
  force = false

[build.environment]
  NODE_VERSION = "18"
NETLIFY_EOF
    
    git add netlify.toml
    git commit -m "Add netlify.toml configuration"
    git push
    
    echo -e "${GREEN}✓ netlify.toml created${NC}"
    echo -e "${YELLOW}Re-deploying with configuration...${NC}"
    
    netlify deploy --prod --force
fi

echo ""
echo "=========================================="
echo -e "${GREEN}✅ Deployment Complete!${NC}"
echo "=========================================="
echo ""
echo "Your app is now live on Netlify!"
echo ""
echo "App URL will be shown above."
echo ""
echo "Next steps:"
echo "1. Visit your app URL"
echo "2. Test all features"
echo "3. Set environment variables in Netlify dashboard:"
echo "   DATABASE_URL=file:./db/custom.db"
echo "4. Deploy WebSocket service (see documentation)"
echo ""
echo "For full documentation, see:"
echo "  - OPERATING-MANUAL.md (operations)"
echo "  - FREE-PUBLISHING-GUIDE.md (publishing details)"
echo "  - QUICK-DEPLOYMENT-GUIDE.md (deployment steps)"
echo ""
