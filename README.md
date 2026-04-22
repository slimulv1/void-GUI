<div align="center">
	
# Void Linux Cinnamon Installation Script ![void](https://github.com/slimulv1/void-GUI/blob/main/void.png)
  <img src="https://img.shields.io/badge/Gensokyo-Approved-ff69b4?style=for-the-badge&logo=konami" alt="Gensokyo Approved">
  <img src="https://img.shields.io/badge/Spell_Card-High_Quality-blueviolet?style=for-the-badge" alt="Spell Card">
  
![Platform](https://img.shields.io/badge/platform-Void%20Linux-478061?logo=linux&colorA=363a4f)
[![x85_64-glibc](https://img.shields.io/badge/x86__64-glibc-478061?style=plastic&colorA=363a4f&colorB)](#)
![Repo size](https://img.shields.io/github/repo-size/slimulv1/void-GUI?style=badge&logo=protondrive&logoColor=fff&colorA=363a4f&colorB=blue)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/slimulv1/void-GUI/main?style=badge&label=Last%20Commit&logo=git&logoColor=fff&colorA=363a4f&colorB=purple)

<!-- style=for-the-badge / style string
Possible values: [flat, flat-square, plastic, badge, for-the-badge, social] -->

</div>

---

### 🌸 Script này giúp đơn giản hóa việc cài đặt Void Linux với môi trường desktop Cinnamon.

## 📜 Điều kiện cần thiết (Requirements)
* Void Linux (glibc) đã được cài đặt bằng image cơ bản (base image).
* Hệ thống Void Linux đã được khởi động thành công.
* Đã có kết nối Internet (để triệu hồi các gói tin).

---

## 🛠️ Các bước khởi đầu (Initial Steps)
Hãy thực hiện các bước sau để chuẩn bị "trận địa" cho hệ thống của bạn:

1. Đăng nhập vào Void Linux (với tư cách người dùng bình thường).
2. Cài đặt `git`:
      ```bash
   sudo xbps-install git
   ```
3. Sao chép kho lưu trữ (Clone repository):
   ```bash
   git clone https://github.com/slimulv1/void-GUI-install.git   ```
   > Lưu ý: Kho lưu trữ sẽ được tải về thư mục `~/void-GUI-install`.
4. Di chuyển vào thư mục:
   ```bash
   cd void-GUI-install
   ```
5. Cấp quyền thực thi cho Script:
   ```bash
   chmod +x cinnamon_install.sh
      ```
6. Khai triển Script:
   ```bash
   ./cinnamon_install.sh
   ```

---

## ✨ Phép thuật của Script (What does the script do?)
Script này sẽ thay đổi hoàn toàn diện mạo hệ thống của bạn như một tấm "Spell Card" mạnh mẽ:

* 💠 Khởi tạo: Cài đặt Void Linux cùng môi trường desktop Cinnamon (cinnamon-all).
* ⚡ Kích hoạt linh lực (Activates):
  - Xlibre
  - PipeWire (Âm thanh thuần khiết từ Cửu Tiêu)
  - Hỗ trợ máy in (Printer support)
  - Bluetooth
  - Docker (Đóng gói sức mạnh linh hồn)
  - Trình quản lý gói Nix (Nix package manager)
  - Office (Công việc văn phòng)
  - Profile Sync Daemon
  - Cấu hình tiết kiệm pin cho Notebook
* ⛩️ Kết nối không gian: Tự động gắn (mount) các ổ đĩa bằng udisks2 & polkit, giúp bạn không còn phải bận tâm về việc chỉnh sửa phong ấn /etc/fstab.
* 🎨 Tùy chỉnh ảo ảnh (Customizations):
  - Thay đổi hình nền cho Cinnamon và LightDM.
  - Thiết lập kịch bản tự chạy (Autostart) cho Cinnamon:
    - Kích hoạt octoxbps-updater (Luôn cập nhật linh lực cho hệ thống).
    - Thiết lập bố cục bàn phím tiếng Anh.
    - Tự động gắn tất cả các ổ đĩa hệ thống Linux, cực kỳ hữu ích cho thư viện Steam của bạn.

---

## Made with ❤️ for Linux users. May the stars of Gensokyo guide your coding journey! 🌟
</details>

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

