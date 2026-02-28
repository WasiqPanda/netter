# Deployment Commands Reference
## Military Patrol Tracking System

---

## Quick Deployment

### Deploy to Vercel (Recommended - Free)

**Using Script:**
```bash
./deploy-vercel.sh
```

**Manual Steps:**
```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Login
vercel login

# 3. Deploy from project directory
cd /home/z/my-project
vercel --prod --yes
```

---

### Deploy to Netlify (Free)

**Using Script:**
```bash
./deploy-netlify.sh
```

**Manual Steps:**
```bash
# 1. Install Netlify CLI
npm install -g netlify-cli

# 2. Login
netlify login

# 3. Initialize
netlify init

# 4. Deploy
netlify deploy --prod
```

---

### Deploy to Render (Free Tier)

**Manual Steps:**
1. Go to [render.com](https://render.com)
2. Sign up or login
3. Click "New +" → "Web Service"
4. Connect to GitHub repository
5. Configure:
   - Name: `military-patrol-tracking`
   - Runtime: `Node`
   - Build Command: `bun run build`
   - Start Command: `bun start`
   - Environment: `DATABASE_URL=file:./db/custom.db`
6. Click "Create Web Service"

---

### Deploy to Railway (Free Tier)

**Manual Steps:**
1. Go to [railway.app](https://railway.app)
2. Sign up or login
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose your repository
6. Railway auto-detects Next.js
7. Click "Deploy"

---

## Prerequisites

### Before Deploying:

1. **Code on GitHub:**
```bash
cd /home/z/my-project
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/military-patrol-tracking.git
git push -u origin main
```

2. **Create GitHub Repository:**
   - Go to [github.com/new](https://github.com/new)
   - Repository name: `military-patrol-tracking`
   - Make it public or private
   - Copy repository URL

---

## Environment Variables

### Required Environment Variables

Set these in your platform's environment variables:

```env
DATABASE_URL=file:./db/custom.db
```

### Optional Environment Variables

```env
NEXT_PUBLIC_WEBSOCKET_URL=wss://your-tracking-service-url
NODE_ENV=production
```

---

## Domain Setup

### Free Subdomains (Automatic)

| Platform | Subdomain Format |
|----------|-----------------|
| Vercel | `*.vercel.app` |
| Netlify | `*.netlify.app` |
| Render | `*.onrender.com` |
| Railway | `*.up.railway.app` |

### Custom Domain (Paid)

#### Purchasing a Domain:
- **Freenom**: [freenom.com](https://freenom.com) - Free for 1 year
- **Namecheap**: [namecheap.com](https://namecheap.com) - ~$10/year
- **Porkbun**: [porkbun.com](https://porkbun.com) - ~$6/year

#### Adding Custom Domain to Vercel:
1. Go to Vercel dashboard
2. Settings → Domains
3. Add domain
4. Update DNS records as instructed
5. SSL is automatic

#### Adding Custom Domain to Netlify:
1. Go to Netlify dashboard
2. Domain Settings
3. Add custom domain
4. Update DNS records
5. SSL is automatic

---

## WebSocket Service Deployment

### Option 1: Deploy to Render (Free PostgreSQL)

**Steps:**
1. Create new repository for tracking service
2. Push `mini-services/tracking-service` to repository
3. On Render: "New +" → "Background Worker"
4. Configure:
   - Name: `tracking-service`
   - Runtime: `Node`
   - Build Command: `bun install`
   - Start Command: `bun --hot index.ts`
   - Environment: `PORT=3003`
5. Get WebSocket URL from Render
6. Update frontend environment variable

### Option 2: Deploy to Railway

**Steps:**
1. Create new repository or use existing
2. Push tracking service to repository
3. On Railway: "New Service"
4. Select repository and directory: `mini-services/tracking-service`
5. Configure:
   - Runtime: `Node`
   - Start command: `bun --hot index.ts`
6. Get WebSocket URL

### Option 3: Use Third-Party Service

**Options:**
- Pusher (free tier available)
- Ably (free tier available)
- SocketCluster (free tier available)

---

## Monitoring

### Vercel Analytics

Access at: `vercel.com/dashboard` → Your Project → Analytics

### Netlify Analytics

Access at: `app.netlify.com` → Your Site → Analytics

### Render Metrics

Access at: `dashboard.render.com` → Your Service → Metrics

---

## Troubleshooting Deployment

### Build Failures

**Issue:** Build fails on platform

**Solutions:**
```bash
# Test build locally first
bun run build

# Check build logs on platform
# Review error messages
# Fix errors locally
# Push fixes to GitHub
```

### Database Issues

**Issue:** Database not persisting

**Solutions:**
- Render/Railway: Use PostgreSQL instead of SQLite
- Vercel/Netlify: Use external database or accept file resets
- Regular backups: Download `.db` file regularly

### WebSocket Not Working

**Issue:** WebSocket connection fails

**Solutions:**
- Verify tracking service is deployed
- Check CORS settings
- Update WebSocket URL in environment variables
- Test WebSocket connection separately

---

## Update Process

### To Update the Application

```bash
# 1. Make changes to code

# 2. Commit changes
git add .
git commit -m "Update - description"

# 3. Push to GitHub
git push

# 4. Platform auto-deploys
# (Vercel, Netlify, Render, Railway all auto-deploy on push)
```

### To Update Database Schema

```bash
# 1. Update prisma schema
# File: prisma/schema.prisma

# 2. Push database changes
git add prisma/schema.prisma
git commit -m "Update database schema"
git push

# 3. Platform auto-deploys
```

---

## Cost Breakdown

### Free Tier Costs

| Platform | Monthly Cost | Annual Cost |
|----------|-------------|-------------|
| Vercel | $0 | $0 |
| Netlify | $0 | $0 |
| Render | $0 (first 750h) | ~$25-30 after |
| Railway | $5 credit (~$0) | $5 credit (~$0) |

### Paid Tier Costs (When Needed)

| Platform | Pro Plan | Cost/Month |
|----------|----------|-----------|
| Vercel Pro | $20 | $20 |
| Netlify Pro | $19 | $19 |
| Render | $7/instance | $7+ |
| Railway | $5-30/service | $5-30 |

### Custom Domain Costs

| Provider | Price/Year |
|----------|------------|
| Freenom | FREE (1 year only) |
| Porkbun | ~$6 |
| Namecheap | ~$10 |
| GoDaddy | ~$12 |

---

## Backup & Restore

### Backup Database

```bash
# For SQLite (Vercel/Netlify)
# Access via platform file manager or deploy script
# Download: db/custom.db
```

### Backup Code

Code is automatically backed up in Git/GitHub.

### Restore from Backup

```bash
# Download database backup
# Replace db/custom.db
# Restart application (platform auto-redeploys)
```

---

## Security Best Practices

### 1. Change Default Credentials

```env
# In platform environment variables:
SUPER_ADMIN_PASSWORD=your-secure-password
```

### 2. Use HTTPS

All platforms provide free SSL - use it!

### 3. Limit Repository Access

- Make repository private for production
- Use branch protections
- Enable 2FA if available
- Limit who can deploy

### 4. Regular Updates

```bash
# Update dependencies monthly
bun update

# Security patches as needed
npm audit fix
```

---

## Rollback Procedure

### If Deployment Fails or Has Issues

```bash
# 1. Revert to last known good commit
git revert HEAD~1

# 2. Push fix
git push origin main

# 3. Platform auto-reverts
```

### If Complete Rollback Needed

```bash
# 1. Delete deployment from platform dashboard

# 2. Redeploy with working version
# Either by:
#   - Pushing known good commit
#   - Or redeploy from platform dashboard
```

---

## Performance Optimization

### For Vercel

- Automatic image optimization
- Automatic code splitting
- Edge caching (automatic)
- CDN (automatic)

### For Netlify

- Automatic asset optimization
- CDN (automatic)
- Edge functions (configure as needed)

### For Render

- Enable metrics if needed
- Scale instances if slow
- Consider upgrading for more RAM

### For Railway

- Scale individual services
- Add more resources as needed
- Monitor resource usage

---

## Support Resources

### Platform Documentation
- Vercel: [vercel.com/docs](https://vercel.com/docs)
- Netlify: [netlify.com/docs](https://netlify.com/docs)
- Render: [render.com/docs](https://render.com/docs)
- Railway: [railway.app/docs](https://railway.app/docs)

### Community Support
- GitHub Issues (for this project)
- Platform Community Forums
- Stack Overflow

### Platform Support
- Vercel Support (Pro plans only)
- Netlify Support (Pro plans only)
- Render Support (paid plans only)
- Railway Support (paid plans only)

---

## Quick Reference

### Deploy to Vercel (One Command)
```bash
vercel --prod --yes
```

### Deploy to Netlify (One Command)
```bash
netlify deploy --prod
```

### Check Deployment Status
```bash
# Vercel
vercel ls

# Netlify
netlify list
```

### View Logs
```bash
# Vercel
vercel logs

# Netlify
netlify logs
```

---

**Deployment Commands Reference v1.0**  
Last Updated: February 20, 2025  
Military Patrol Tracking System
