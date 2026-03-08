/** @type {import('next').NextConfig} */

const nextConfig = {
  output: 'export',
  distDir: '../public',
  env: {
    name: 'Calliope AI',
    description: 'AI development workspaces by Calliope Labs.',
    icon: '/icons/calliope-logo.png',
    listUrl: 'https://calliopeai.github.io/calliope-kasm/',
    contactUrl: 'https://calliope.ai/support',
  },
  reactStrictMode: true,
  basePath: '/calliope-kasm/1.0',
  trailingSlash: true,
  images: {
    unoptimized: true,
  }
}

module.exports = nextConfig
