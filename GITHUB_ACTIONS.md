# GitHub Actions + Railway Deploy Setup

## 🚀 Cách hoạt động

```
Bạn push code → GitHub Actions tự động chạy → Deploy lên Railway → Server 24/7
```

## ⚙️ Setup GitHub Actions Deploy

### Bước 1: Tạo Railway Token
1. Vào https://railway.app → Account → Tokens
2. Click "Create Token"
3. Copy token

### Bước 2: Thêm Secret vào GitHub
1. Vào repo Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Name: `RAILWAY_TOKEN`
4. Value: Paste token từ bước 1
5. Click "Add secret"

### Bước 3: Trigger Deploy
Cách 1 - Tự động (mỗi khi push):
```bash
git push origin main
# → GitHub Actions tự động deploy
```

Cách 2 - Manual (tùy chọn):
1. Vào repo → Actions tab
2. Chọn "Deploy to Railway" workflow
3. Click "Run workflow"

### Bước 4: Check Status
- GitHub: Actions tab → Xem logs
- Railway: https://railway.app → Deployments tab

## 📋 Alternatives - Chạy trên GitHub

### Option 1: GitHub Codespaces (Dev Environment)
**Free**: 60 giờ/tháng + compute credit

```bash
# Click "Code" button → Codespaces → Create
# Terminal:
cd /workspaces/CLIProxy
./cli-proxy-api
# Server chạy trong Codespace, có thể giữ 24/7
```

**Pros**: Dev environment đầy đủ, SSH vào được
**Cons**: Compute giờ hạn chế

### Option 2: GitHub Actions Scheduled Job
**Giới hạn**: 6 giờ/job, 35 ngày/tháng

```yaml
on:
  schedule:
    - cron: '0 * * * *'  # Mỗi giờ
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - run: ./cli-proxy-api  # Chạy 1 giờ rồi timeout
```

**Không khuyến nghị** cho production 24/7

### Option 3: Docker Hub + GitHub Actions
Deploy image lên registry:

```yaml
- name: Push to Docker Hub
  run: |
    docker build -t username/cliproxy .
    docker push username/cliproxy
```

Rồi pull + chạy trên Railway/Render

## ✅ Khuyến nghị

| Nhu cầu | Solution | Cost |
|--------|----------|------|
| Deploy 1-click + 24/7 server | GitHub Actions → Railway | $5/tháng (Railway) |
| Dev environment online | GitHub Codespaces | $0 (60h/tháng free) |
| Local testing | GitHub Actions workflow | $0 (shared runner) |
| Self-hosted | Setup runner trên VPS | $5-10/tháng VPS |

## 🔧 Workflow Files

- `.github/workflows/deploy.yml` - Auto-deploy to Railway
- `.github/workflows/codespace-keep-alive.yml` - Optional keepalive

## 📝 Notes

- Railway free tier: $5/tháng, sau đó $0.50/hr chạy
- GitHub Actions: 2,000 phút/tháng free (shared runners)
- Codespaces: 60 giờ/tháng free (personal computing)

## 🐛 Troubleshooting

**Action failed**: Check logs in Actions tab
**Token invalid**: Regenerate token in Railway account settings
**Server not starting**: Check config.yaml, PORT env var

---

**Next**: Push code lên GitHub rồi test workflow!
