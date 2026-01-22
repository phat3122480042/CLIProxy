# 📘 TÀI LIỆU HƯỚNG DẪN SỬ DỤNG SERVER AI (CLIProxy)

Đây là tài liệu chi tiết về hệ thống Proxy Server AI mà bạn đã thiết lập. Bạn có thể cung cấp tài liệu này cho AI khác hoặc cho thành viên trong team để họ biết cách kết nối.

---

## 1. Thông Tin Kết Nối (Connection Info)

*   **Máy Chủ (Host):** `http://26.197.92.157:8317` (IP Radmin VPN)
*   **Base URL (Endpoint):** `http://26.197.92.157:8317/v1`
*   **API Key:** `sk-antigravity`
*   **Trang Demo/Test:** Mở file `test_demo.html` trên máy chủ.

## 2. Danh Sách Model (Đã Ánh Xạ)

Sử dụng các tên ngắn (Alias) dưới đây khi gọi API:

| Tên Model (Alias) | Mô Tả | Ưu Điểm |
| :--- | :--- | :--- |
| `gemini-3-flash` | **Gemini 3.0 Flash** | Mới nhất, tốc độ cực nhanh, hỗ trợ Vision (Ảnh). |
| `gemini-3-pro` | **Gemini 3.0 Pro** | Mô hình mạnh mẽ nhất của Google hiện tại. |
| `claude-4.5-sonnet` | **Claude 3.5/4.5 Sonnet** | Best coding & reasoning (từ Antigravity). |
| `claude-4.5-thinking` | **Claude Thinking** | Có khả năng suy luận sâu (CoT) trước khi trả lời. |
| `gemini-2.5-flash` | **Gemini 2.5 Flash** | Bản ổn định, token lớn, rẻ/free. |

## 3. Khả Năng Của Hệ Thống (Capabilities)

### ✅ Những gì CLIProxy LÀM ĐƯỢC:
1.  **Chuyển tiếp Chat/Text:** Hoạt động như OpenAI API chuẩn.
2.  **Xử lý Hình ảnh (Vision):**
    *   **CÓ HỖ TRỢ.** Các model như `gemini-3-flash`, `gemini-2.5-flash` có khả năng nhìn ảnh.
    *   Cách dùng: Client (App Chat) phải gửi ảnh dưới dạng base64 hoặc URL theo chuẩn OpenAI Vision.
3.  **Tự động Retry:** Đã cấu hình thử lại 5 lần nếu gặp lỗi quá tải (Rate Limit).

### ❌ Những gì CLIProxy KHÔNG TỰ LÀM (Cần Client hỗ trợ):
1.  **Tìm kiếm Web (Web Search):**
    *   CLIProxy **không tự tìm Google**.
    *   **Giải pháp:** Bạn cần dùng Client có tính năng này (ví dụ: Chatbox AI, NextChat có plugin Web, hoặc Cursor bật chế độ Web). Client sẽ search trước rồi đưa kết quả vào context cho AI đọc.
2.  **Chạy Code (MCP / Code Execution):**
    *   CLIProxy chỉ là "cái miệng" để AI nói.
    *   Để AI chạy code (như Copilot, Cursor), bạn cần dùng **IDE Extension** (như Continue.dev, Cline, Cursor) và trỏ API về đây. Khi đó IDE sẽ lo việc chạy code.

## 4. Cách Dùng Trong Các Dự Án/IDE

### Cấu hình cho VS Code (dùng Extension "CodeGPT" hoặc "VSC Copilot")
*   **Provider:** OpenAI / Custom
*   **API Key:** `sk-antigravity`
*   **Base URL:** `http://26.197.92.157:8317/v1`
*   **Model:** `gemini-3-flash` (để code nhanh) hoặc `claude-4.5-sonnet` (để code xịn).

### Cấu hình cho Website / App riêng
```javascript
const openai = new OpenAI({
  apiKey: "sk-antigravity",
  baseURL: "http://26.197.92.157:8317/v1",
});
```

## 5. Quy Trình Bảo Trì
1.  **Bật Server:** Chạy file `Start-CLIProxy.bat`. Cửa sổ đen phải luôn mở.
2.  **Đăng nhập lại (nếu lỗi Token):** Chạy lệnh `.\cli-proxy-api.exe -antigravity-login` trong thư mục.
3.  **Xem Log:** Nhìn trực tiếp vào cửa sổ đen để thấy ai đang request gì.

---
*Tài liệu được tạo tự động bởi Antigravity Agent.*
