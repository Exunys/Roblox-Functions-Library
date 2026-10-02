# ROBLOX Reference Library (Services & Functions)

[![Visitors](https://visitor-badge.laobi.icu/badge?page_id=Exunys.Roblox-Functions-Library&right_color=green)](https://github.com/Exunys/Roblox-Functions-Library/blob/main/Documentation.md)

A lightweight utility module that injects common Roblox services and helper functions directly into your global environment. Instead of indexing methods through a library namespace (e.g., `Library.Rejoin()`), you can call them directly (e.g., `Rejoin()`), keeping your codebase clean and efficient.

---

## ⚡ Installation & Quick Start

Import the library directly into your execution environment using `loadstring`:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Roblox-Functions-Library/main/Library.lua"))()

-- Functions are now globally accessible:
SetMouseIconVisibility(false) -- Toggles mouse cursor visibility
```

---

## 📖 Documentation

For a full reference of available functions, services, and signature details, see the official [Documentation Guide](https://github.com/Exunys/Roblox-Functions-Library/blob/main/Documentation.md).

---

## 📜 Update Log

| Version | Date (DD/MM/YYYY) | Changes |
| :--- | :--- | :--- |
| **v1.4** | `19/08/2024` | Optimized source code; added `ServerHop`, `SetStretch`, and `GetService` functions; added `VirtualUser` service. |
| **v1.3** | `26/02/2023` | Source code optimizations. |
| **v1.2** | `26/01/2023` | Replaced `TableDump` with the new `Recursive` function. |
| **v1.1** | `03/05/2022` | Secondary feature release. |
| **v1.0** | `09/04/2022` | Initial public release. |

---

## 📧 Contact & Support

For bug reports, feature requests or questions:

* [Discord](https://discord.com/users/611111398818316309)
* [Email](mailto:exunys@gmail.com)
