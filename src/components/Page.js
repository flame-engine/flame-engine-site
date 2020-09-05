import React from "react"
import { ThemeProvider } from "styled-components"
import { Header } from "./Header"
import { SEO } from "./Seo"
import { FullWidthContainer, Container } from "./UI"

import "./layout.css"

const styledTheme = {
  accentColor: "#D20101",
}

export const Page = ({ children, uri }) => {
  const isHome = uri === "/"
  const hideHeader = uri.match(/^\/?flamecon\/?$/g)

  return (
    <ThemeProvider theme={styledTheme}>
      <>
        <Header isHome={isHome} hideHeader={hideHeader} />
        {children}
      </>
    </ThemeProvider>
  )
}

export const PageWrapper = ({ title, children, fullWitdh }) => {
  const Wrapper = fullWitdh ? FullWidthContainer : Container

  return (
    <ThemeProvider theme={styledTheme}>
      <main>
        <SEO title={title} />
        <Wrapper>{children}</Wrapper>
      </main>
    </ThemeProvider>
  )
}
