import '../styles/globals.css'
// The @calliopelabs/ui tokens, vendored from 0.21.0 (dist/css; the package itself needs
// React 19): the site takes the Workbench brand accent from them.
import '../calliope/tokens.css'
import Layout from '../components/layout'
import { useState, useEffect } from 'react'


function MyApp({ Component, pageProps }) {
  const [searchText, setSearchText] = useState('')

  const changeSearch = event => {
    setSearchText(event.target.value)
  }

  return (
    <Layout searchText={searchText} changeSearch={changeSearch}>
      <Component searchText={searchText} {...pageProps} />
    </Layout>
  )
}

export default MyApp
