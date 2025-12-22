# DermaWind

DermaWind is a utility-first styling library for Garry's Mod Derma, heavily inspired by Tailwind CSS. It allows developers to style VGUI panels using concise string classes instead of writing verbose Lua method calls for every visual property.

## Features

- **Utility-First Workflow**: Style panels using composable classes like `bg-primary`, `p-4`, `rounded-lg`.
- **Hover States**: Easily handle hover effects with the `hover:` prefix (e.g., `hover:bg-danger`).
- **Responsive Sizing**: Support for percentage-based width/height relative to screen size (e.g., `w-[50%]`).
- **Theming**: Centralized configuration for colors, spacing, and fonts.
- **Automatic Mapping**: Automatically maps unknown utilities to `Set*` methods on the panel (e.g., `wrap-true` -> `SetWrap(true)`).

## Installation

1. Download or clone this repository.
2. Place the folder into your `garrysmod/addons/` directory.

## Usage

The library extends the default `Panel` metatable with a `DWClassName` method.

```lua
-- Create a frame
local frame = vgui.Create("DFrame")
frame:SetTitle("Styled Frame")
frame:ShowCloseButton(false)
frame:MakePopup()

-- Apply styles: 50% width/height, secondary background, rounded corners
frame:DWClassName("w-[50%] h-[50%] bg-secondary rounded-lg")
frame:Center()

-- Create a button inside the frame
local btn = vgui.Create("DButton", frame)
btn:SetText("Hover Me")

-- Apply styles: Primary background, black text, margin, hover turns red
btn:DWClassName("bg-primary text-black text-lg rounded-lg hover:bg-danger m-4 h-10 dock-top")
```

## Utilities Reference

### Layout & Sizing

| Class         | Description                                                                             |
| ------------- | --------------------------------------------------------------------------------------- |
| `w-{size}`    | Sets width. Supports pixels (`w-10`), percentages (`w-[50%]`), or `w-full` (Docks Top). |
| `h-{size}`    | Sets height. Supports pixels (`h-10`) or percentages (`h-[50%]`).                       |
| `dock-{side}` | Docks the panel (`top`, `bottom`, `left`, `right`, `fill`, `center`).                   |
| `p-{size}`    | Sets `DockPadding` based on theme spacing.                                              |
| `m-{size}`    | Sets `DockMargin` based on theme spacing.                                               |
| `z-{index}`   | Sets Z-Position.                                                                        |

### Appearance

| Class            | Description                                    |
| ---------------- | ---------------------------------------------- |
| `bg-{color}`     | Sets background color from theme.              |
| `rounded-{size}` | Sets border radius (`sm`, `md`, `lg`, `full`). |
| `border-{val}`   | Sets border size (number) or color (name).     |
| `opacity-{perc}` | Sets panel opacity (0-100).                    |

### Typography

| Class          | Description                                |
| -------------- | ------------------------------------------ |
| `text-{color}` | Sets text color from theme.                |
| `text-{font}`  | Sets font from theme (`sm`, `base`, `lg`). |
| `text-center`  | Sets content alignment to center.          |
| `wrap-{bool}`  | Enables or disables text wrapping.         |

### Modifiers

- **Hover**: Prefix any utility with `hover:` to apply it only when the mouse is hovering over the panel (e.g., `hover:text-white`).

## Configuration

You can customize the theme (colors, spacing, fonts) in `lua/zks_dermawind/sh_theme.lua`.

```lua
ZKsDermaWind.Theme.Colors = {
    ["primary"]   = Color(59, 130, 246),
    ["secondary"] = Color(107, 114, 128),
    ["danger"]    = Color(239, 68, 68),
    -- Add your own...
}
```

## License

Distributed under the MIT License. See `LICENSE` for more information.
