import { Head, Html, Main, NextScript } from 'next/document'

export default function Document() {
  return (
    // The Workbench brand accent from calliope/tokens.css. The registry has one
    // look, a light one, so it stays light whatever the system prefers.
    <Html lang="en" data-product="workbench" data-mode="light" data-accent="workbench-blue">
      <Head />
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  )
}
