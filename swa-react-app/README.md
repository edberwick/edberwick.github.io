# swa-react-app

Minimal Vite + React app that displays an aggregated feed of Microsoft Azure updates via the serverless API at `/api/aggregate`.

Quick start

1. cd into `swa-react-app`
2. Install dependencies: `npm install`
3. Run locally: `npm run dev` (app) and in a separate terminal `cd ../api && npm install` for the function dependencies
4. Build: `npm run build` (produces `dist`)

Deploy notes

- The GitHub Actions workflow in `.github/workflows/azure-static-web-apps.yml` builds the app and deploys the `dist` folder; the API folder is `api`.
