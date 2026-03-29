# SubSmart — Web3 Subscription Protocol UI

## Overview
A modern, fully static Web3 frontend for the **SubSmart** decentralized subscription protocol. Built for a MetaDAO submission. Uses plain HTML + Tailwind CSS (CDN) + vanilla JavaScript, served via `static-web-server` on port 5000.

## Pages

### `index.html` — Landing Page
- Grid-background hero with animated fade-in sections
- Headline: "Subscriptions Without Trust" (blue accent)
- Subheading, CTA button ("Launch Dashboard →"), stat cards (0.5% fee, ∞ cycles, 100% on-chain)
- Sticky frosted-glass navbar with logo and nav links

### `dashboard.html` — Merchant Terminal
- Navbar: SubSmart logo + stacked MetaDAO/wallet address (top-right)
- Page header: "Merchant Terminal" + green "Live MVP" badge
- Three stacked cards:
  1. Blue card — Revenue Fee (0.5%)
  2. White card — Contract Address with copy-to-clipboard button
  3. White card — Active subscription (Cloud Storage Pro / 25 USDC / ACTIVE)
- Back link to landing page

## Stack
- HTML5, Tailwind CSS (via CDN), vanilla JavaScript
- `static-web-server` serving from project root on port 5000
- Google Fonts: Inter (400–900 weights)

## Workflow
- **Start application** — `static-web-server --host 0.0.0.0 --port 5000 --root ./ --log-level error`

## Navigation
- Landing page → Dashboard via "Launch Dashboard" button / nav link
- Dashboard → Landing page via "Back to Home" link / logo click
