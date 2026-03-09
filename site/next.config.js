/** @type {import('next').NextConfig} */

const nextConfig = {
  output: 'export',
  distDir: '../public',
  env: {
    name: 'Calliope AI',
    description: 'AI development workspaces by Calliope Labs.',
    icon: '/img/logo.svg',
    listUrl: 'https://calliopeai.github.io/calliope-kasm/1.0/',
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
