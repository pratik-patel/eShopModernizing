# 🚀 eShop Legacy WebForms - Quick Start Guide

## Prerequisites Setup (One-Time)

✅ **COMPLETED:**
- Hyper-V and Containers features enabled
- Docker Desktop installed
- Application built and ready
- Docker configuration files created

⚠️ **REQUIRED:** Restart your computer to activate Hyper-V

---

## After Restart - Quick Start

### 1️⃣ Start Docker Desktop
- Open Docker Desktop from Start Menu
- Wait for the whale icon to be steady (not animated)
- Takes ~1-2 minutes

### 2️⃣ Run the Application
```cmd
cd C:\Users\pratikp6\codebase\eShopModernizing\eShopLegacyWebFormsSolution
start.cmd
```

**First run:** 15-20 minutes (downloads Windows base images)
**Subsequent runs:** 1-2 minutes

### 3️⃣ Access the Application
- **WebForms App:** http://localhost:5112
- **SQL Server:** localhost:5433

---

## 📝 Helper Scripts

| Script | Purpose |
|--------|---------|
| `start.cmd` | Start the application (auto-builds if needed) |
| `stop.cmd` | Stop all containers |
| `logs.cmd` | View live container logs |
| `rebuild.cmd` | Rebuild everything from scratch |
| `build.cmd` | Build only the .NET application |

---

## 🔧 Common Commands

### View Running Containers
```cmd
docker-compose ps
```

### View Logs
```cmd
docker-compose logs -f
```

### Stop Containers
```cmd
docker-compose down
```

### Restart Containers
```cmd
docker-compose restart
```

### Remove Everything (including data)
```cmd
docker-compose down -v
docker rmi eshop/legacywebforms:latest
```

---

## 🐛 Troubleshooting

### Container Won't Start
```cmd
# Check logs
logs.cmd

# Rebuild from scratch
rebuild.cmd
```

### Port Already in Use
```cmd
# Stop all containers
docker-compose down

# Check what's using the port
netstat -ano | findstr :5112
```

### Can't Access via Localhost
Due to Windows Container NAT limitations, use container IP:
```cmd
# Find container ID
docker ps

# Get container IP
docker inspect <CONTAINER-ID> -f "{{.NetworkSettings.Networks.nat.IPAddress}}"

# Access via: http://<CONTAINER-IP>:80
```

### Database Connection Issues
The app uses mock data by default. To use real database:
1. Edit `docker-compose.override.yml`
2. Set `UseMockData=False`
3. Restart: `docker-compose restart`

---

## ⏱️ Timeline

| Phase | First Time | Subsequent |
|-------|-----------|------------|
| Computer restart | 3-5 min | - |
| Docker Desktop start | 1-2 min | 1-2 min |
| Build images | 15-20 min | - |
| Start containers | 1-2 min | 1-2 min |
| **TOTAL** | **20-30 min** | **2-4 min** |

---

## 📚 Project Structure

```
eShopLegacyWebFormsSolution/
├── start.cmd              # ⭐ Main startup script
├── stop.cmd               # Stop containers
├── logs.cmd               # View logs
├── rebuild.cmd            # Full rebuild
├── build.cmd              # Build .NET app
├── docker-compose.yml     # Container configuration
├── docker-compose.override.yml  # Environment settings
├── README-Docker.md       # Detailed documentation
├── src/
│   └── eShopLegacyWebForms/
│       ├── Dockerfile     # Container definition
│       └── ...
└── deploy/
    └── webforms/
        └── obj/Docker/publish/  # Published app files
```

---

## 🎯 Next Steps

1. **Restart your computer now**
2. **Start Docker Desktop**
3. **Run `start.cmd`**
4. **Open http://localhost:5112**

That's it! 🎉
