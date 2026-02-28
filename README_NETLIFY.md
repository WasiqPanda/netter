# Netlify Deployment (Free)

## Recommended method: Git import
1) Push this folder to GitHub.
2) Netlify → Add new site → Import from Git → choose your repo.
3) Build command: `npm run build`
4) Publish directory: handled by `@netlify/plugin-nextjs` (keep default)
5) Environment variables (only if you use them):
   - DATABASE_URL (if Prisma is used)
   - NEXTAUTH_URL / NEXTAUTH_SECRET (if auth uses NextAuth)
   - Any other .env variables your app requires

## Notes
- This package pins to Next.js 14 + React 18 for best compatibility with Netlify's Next.js runtime.
- If your app uses Prisma + SQLite, serverless deployments will NOT reliably persist writes. Use Postgres (Supabase/Neon) for real persistence.
