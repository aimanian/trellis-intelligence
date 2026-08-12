# Trellis Intelligence — website

Single-file marketing site + interactive aviation demo for **Trellis Intelligence LLC**.
Static, self-contained (`index.html`, inline CSS/JS) — deploys to any static host.

## What's here
- `index.html` — the whole site (nav · hero · live aviation demo · how-it-works · domains · comparison · contact · footer).
- `CNAME` — custom domain for GitHub Pages (currently `trellisintelligence.com`; edit if your domain differs).

## The live demo
The "See it reason" section is driven by **real rows** pulled from the Trellis aviation knowledge graph:
- Flight **DAL1514** (real MIA→JFK ADS-B track, ICAO24 a44197)
- Real ATC clearance from LiveATC audio → Whisper → intent ("descend and maintain 2,000, heading 030")
- Real SWIM NOTAM ("RWY 04/22 SAFETY AREA RUTTING…")
- Real KJFK METAR (`KJFK 081551Z 20009KT 10SM…`)

Values are **pre-fetched** (a public static site can't run the live Python backend / LLM agent). To make it truly live later, host the Streamlit/Ask-agent backend and swap the demo's hard-coded steps for a `fetch()` to that API.

## Preview locally
Just open the file:
```
open index.html
```
or serve it:
```
cd website && python3 -m http.server 8000    # → http://localhost:8000
```

## Deploy to a custom domain

### Option A — GitHub Pages (free, uses the CNAME file)
1. Create a GitHub repo, push this `website/` folder's contents to the repo root (so `index.html` + `CNAME` are at the top level).
2. Repo → **Settings → Pages** → Source: `main` branch, `/ (root)`.
3. At your domain registrar, add DNS records for `trellisintelligence.com`:
   - Four `A` records → `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - One `CNAME` for `www` → `<your-github-username>.github.io`
4. Back in Settings → Pages, set the custom domain to `trellisintelligence.com` and enable **Enforce HTTPS**.

### Option B — Netlify or Vercel (drag-and-drop, easiest)
1. Netlify: drag the `website/` folder onto app.netlify.com → instant URL.
2. Add your custom domain in **Domain settings**, then point DNS as Netlify/Vercel instructs (usually a `CNAME`/`ALIAS` to their host, or their nameservers).
3. HTTPS is automatic.

> You need to own the domain first (register `trellisintelligence.com` at any registrar — Namecheap, Cloudflare, Google/Squarespace Domains, etc.). Then follow whichever host above.

## Editing
- Contact email is set to `anahita.imanian@gmail.com` — change the two `mailto:` links in `index.html` if you want a company address.
- Colors/fonts reuse the v15 pitch design tokens (the `:root` CSS variables at the top).
