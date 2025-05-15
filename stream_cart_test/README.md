# Flutter Stream Cart App

Ứng dụng Flutter với kiến trúc Clean Architecture và BLoC pattern, tích hợp chức năng đăng nhập và đăng ký sử dụng API thực tế.

## Tính năng

- **Đăng nhập / Đăng ký**: Tích hợp với API thực tế, hỗ trợ xác thực người dùng.
- **Quản lý phiên (Session)**: Sử dụng AccessToken và RefreshToken để duy trì phiên đăng nhập.
- **Bảo mật**: Lưu trữ token an toàn bằng Flutter Secure Storage.
- **UI hiện đại**: Thiết kế theo phong cách Apple với tông màu đen-trắng và animation mượt mà.
- **Xử lý lỗi thông minh**: Hiển thị thông báo lỗi chi tiết từ API.

## Kiến trúc

Dự án được xây dựng theo Clean Architecture với 3 layer chính:

1. **Presentation Layer**: UI và BLoC
   - Gồm Pages, Widgets và BLoC
   - Xử lý tương tác người dùng và hiển thị dữ liệu

2. **Domain Layer**: Business Logic
   - Các Entity và UseCase
   - Định nghĩa các Repository Interface

3. **Data Layer**: Data Access
   - Repository Implementation
   - Remote Data Source (API)
   - Model và chuyển đổi dữ liệu

## Setup

1. Cài đặt dependencies:
```
flutter pub get
```

2. Cấu hình môi trường:
- Tạo file `.env` tại thư mục gốc của dự án với nội dung:
```
API_URL=https://api.v2.vinshuttle.site
```

3. Chạy ứng dụng:
```
flutter run
```

## Chức năng mới

### 1. Quản lý JWT Authentication

Đã thêm các tính năng:
- Lưu trữ AccessToken và RefreshToken an toàn
- Tự động xử lý refresh token khi token hết hạn
- Tự động thêm Authorization header vào API request

### 2. Xử lý lỗi nâng cao

- Hiển thị thông báo lỗi chi tiết từ API
- Xử lý các trường hợp lỗi 401 (Unauthorized)
- Xử lý lỗi mạng và timeout
