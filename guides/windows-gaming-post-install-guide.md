# Windows Full Setup Guide

---

## 1. Repair System

```powershell
DISM /Online /Cleanup-Image /RestoreHealth ; sfc /SCANNOW ; Repair-Volume -DriveLetter 'C' -OfflineScanAndFix -Confirm:$false -Verbose ; Optimize-Volume -DriveLetter 'C' -ReTrim -Verboses
```

## 2. System Update

* Check and install all pending Windows Update updates.
* Update Microsoft Store and all components.

---

## 3. Driver Installation

### Essential Drivers
  * Chipset (Restart)
  * Graphics Card
  * Network
### Optional Drivers (install as needed)
  * Monitor
  * Headset
  * Mouse
  * Keyboard

---

## 4. Drivers Configuration

### Setup AMD Adrenalin or Nvidia App according to your graphics card

### Realtek Ethernet
* Disable Advanced EEE
* Disable Energy-Efficient Ethernet
* Disable Green Ethernet
* Disable Gigabit Lite
* Disable Auto Disable Gigabit
* Disable Power Saving Mode
* Priority & VLAN

---

## 5. Basic System Configuration

* Run '[1] Setup System' on Gamwin

---

## 6. Remove Bloatware

* Run '[2] Debloat System' on Gamwin

---

## 7. Install Dependencies

* Run '[3] Install Dependencies' on Gamwin

---

## 8. Install Applications

* Run '[4] Install Applications' on Gamwin

---

## 10. Import Backup (if needed)

* Run '[5] Import Backup' on Gamwin

---

## 11. Privacy Configuration

* Run '[6] Configure Privacy' on Gamwin

---

## 12. System Behavior Configuration

* Run '[7] Configure System Behavior' on Gamwin

---

## 13. Disable Services

* Run '[8] Disable Services' on Gamwin

---

## 13. System Personalization and Configuration

### Advanced System Settings

* **Performance:** Disable useless visual effects.
* **Remote:** Disable Remote Assistance.

### System

* **Displays:** Adjust resolution, scale, and refresh rate.
* **Sound:** Set default input and output devices and adjust volume.
* **Notifications:** Disable notifications.
* **Storage:** Disable Storage Sense.
* **Multitasking:** Configure "Snap Windows" behavior.

### Personalization

* **Colors:** Adjust system colors (light/dark mode) and disable transparency.

### Apps

* **Advanced app Settings:**
  * Disable cross-device sharing.
  * Disable app archiving.
* **Startup:** Disable apps that launch at startup.
* **Resume:** Disable.

### Time & Language

* **Date & time:** Sync clock.
* **Typing:** Disable all settings.

### Accessibility

* **Keyboard:**
  * Disable Sticky Keys
  * Click '>' on the left of the option and disable all

### Privacy & Security

* **Recommendations & offers:** Disable 'Improve Start and search results'.
* **Diagnostics & Feedback:** Set feedback frequency to "Never".

### Secondary Drive (Optional)

* Format every secondary drive(SSD/HDD) to NTFS.

---

## 14. Apps Configuration

### Browsers
  * Go to General Settings
  * Enable Memory Saver
  * Disable 'Continue running background extensions when the browser is closed'

### Microsoft Edge specific
  * Disable Start up boost
  * Enable PC Gaming boost
  * Enable Resource control

### Gaming (Optional: just performance tweaks)
* Login and configure the clients you use
  * Steam
    * Go to settings
    * Go to Interface
      * Disable 'Run Steam when computer starts'
      * Go to 'Advanced'
        * Disable everything if your video card has low vram (Transitions and animations will be less smooth, but the load on the graphics card will be lower.)
  * Epic Games Launcher
    * Go to settings
    * Disable 'Run when my computer starts'
    * Disable Notifications

---

## 15. System Cleanup

* System > Storage > Temporary Files
* Run '[6] Clean System' on Gamwin

---
