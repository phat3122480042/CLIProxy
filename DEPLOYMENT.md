# Hướng dẫn Deploy lên Free Server 24/7

## Lựa chọn Hosting

### 1. **Railway.app** ⭐ (Khuyến nghị)
- **Chi phí**: $5/tháng free, sau đó $0.50 per hour running
- **Uptime**: 24/7
- **Setup**: Đơn giản nhất
- **Link**: https://railway.app

#### Bước setup Railway:
1. Đăng ký tại [railway.app](https://railway.app)
2. Kết nối GitHub account
3. Chọn repository này
4. Railway tự động detect và deploy
5. Set environment variables:
   ```
   HOST=0.0.0.0
   PORT=8317
   ```
6. Xong! Server sẽ chạy 24/7 ở URL: `https://your-app.railway.app`

### 2. **Render.com**
- **Chi phí**: Free nhưng sleep sau 15 phút
- **Fix**: Dùng uptimebot để ping liên tục
- **Link**: https://render.com

#### Bước setup Render:
1. Đăng ký tại [render.com](https://render.com)
2. Chọn "New +" → "Web Service"
3. Connect GitHub
4. Điền thông tin:
   - Name: `cliproxy`
   - Build Command: `npm install`
   - Start Command: `npm start` hoặc `./cli-proxy-api`
   - Environment: Thêm PORT=8317

### 3. **Fly.io** (Nâng cao)
- **Chi phí**: $5/tháng free
- **Uptime**: 24/7
- **Setup**: Cần cài fly CLI
- **Link**: https://fly.io

## Chuẩn bị GitHub

### Clone/Push lên GitHub:

```bash
# Nếu chưa là git repo
git init
git add .
git commit -m "Initial commit: CLI Proxy deployment setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/CLIProxy.git
git push -u origin main
```

## Railway Deploy Chi Tiết

### Option 1: Qua UI (Dễ nhất)
1. Vào https://railway.app → "Start a new Project"
2. "Deploy from GitHub repo"
3. Chọn repo `CLIProxy`
4. Railway auto-deploy
5. Vào "Settings" → Add Variables:
   ```
   HOST=0.0.0.0
   PORT=8317
   API_KEY=sk-your-key-here
   ```

### Option 2: Dùng Railway CLI (Dev)
```bash
npm install -g @railway/cli
railway login
railway link  # Select project
railway up
```

## Environment Variables

Thêm vào `.env` (local) hoặc Railway/Render environment:

```
HOST=0.0.0.0
PORT=8317
API_KEYS=sk-antigravity,sk-custom-key
AUTH_DIR=./auth
GEMINI_API_KEY=your-gemini-key
```

## Health Check URL

Railway/Render sẽ check health endpoint:
```
GET https://your-app.railway.app/health
```

Thêm vào `main.go` hoặc app code nếu chưa có:
```go
router.GET("/health", func(c *gin.Context) {
    c.JSON(200, gin.H{"status": "ok"})
})
```

## Fix Sleep Issue (Render)

Nếu dùng Render, thêm uptimebot để ping:

1. Đăng ký [uptimebot.com](https://uptimebot.com)
2. Add monitor: `https://your-app.render.com/health`
3. Set interval 5 phút
4. Server sẽ luôn active

## Monitoring

### Railway Dashboard
- Vào https://railway.app → Project → Deployments
- Xem logs, status, metrics

### Access API
- Local: `http://localhost:8317`
- Remote: `https://your-app.railway.app`

## Troubleshooting

### Port issue
```yaml
# config.yaml
host: "0.0.0.0"
port: 8317
```

### Build lỗi
```bash
# Check logs locally
npm run build
npm start
```

### Auth files missing
- Thêm `auth/` folder vào `.gitignore`
- Update auth qua API hoặc web dashboard

## Production Checklist

- [ ] Environment variables đã set
- [ ] Port = 8317 hoặc $PORT env var
- [ ] Auth files đã upload hoặc configure
- [ ] Health endpoint hoạt động
- [ ] Domain custom (optional)

## Đốc Lệnh Nhanh

```bash
# Deploy to Railway
railway up

# View logs
railway logs

# Add environment variable
railway variables set KEY=value

# Deploy specific file/config
railway variables set CONFIG_PATH=./config.yaml
```

## Tham Khảo
- Railway Docs: https://docs.railway.app
- Render Docs: https://render.com/docs
- Fly.io Docs: https://fly.io/docs
