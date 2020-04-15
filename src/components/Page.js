import React from "react"
import { ThemeProvider } from "styled-components"
import { Header } from "./Header"
import { SEO } from "./Seo"
import { Container } from "./UI"

import "./layout.css"

const styledTheme = {
  accentColor: "#D20101",
}

export const Page = ({ children, uri }) => {
  const isHome = uri === "/"
  return (
    <ThemeProvider theme={styledTheme}>
      <>
        <Header isHome={isHome} />
        {children}
      </>
    </ThemeProvider>
  )
}

export const PageWrapper = ({ title, children }) => {
  return (
    <ThemeProvider theme={styledTheme}>
      <main>
        <SEO title={title} />
        <Container>{children}</Container>
      </main>
    </ThemeProvider>
  )
}
