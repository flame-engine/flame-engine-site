import React from "react"
import { ThemeProvider } from "styled-components"
import { Header } from "./Header"
import { SEO } from "./Seo"
import { FullWidthContainer, Container } from "./UI"

import "./layout.css"
import { FlameconBanner } from "./flameconBanner"

const styledTheme = {
  accentColor: "#D20101",
}

export const Page = ({ children, uri }) => {
  const isHome = uri === "/"
  const hideHeader =
    uri.match(/^\/?flamecon\/?$/g) || uri.match(/^\/?countdown\/?$/g)

  return (
    <ThemeProvider theme={styledTheme}>
      <>
        <Header isHome={isHome} hideHeader={hideHeader} />
        {children}
      </>
    </ThemeProvider>
  )
}

export const PageWrapper = ({
  title,
  children,
  fullWitdh,
  hideFlameconBanner,
}) => {
  const Wrapper = fullWitdh ? FullWidthContainer : Container

  const mainStyle = hideFlameconBanner && { marginTop: 0 }

  return (
    <ThemeProvider theme={styledTheme || {}}>
      {!hideFlameconBanner && <FlameconBanner />}
      <main style={mainStyle}>
        <SEO title={title} />
        <Wrapper>{children}</Wrapper>
      </main>
    </ThemeProvider>
  )
}
