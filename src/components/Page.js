import React from "react"
import { ThemeProvider } from "styled-components"
import { Header } from "./Header"
import { SEO } from "./Seo"
import { Container } from "./Container"

import "./layout.css"

const styledTheme = {
  accentColor: "#D20101",
}



export const Page = ({ uri, children }) => {
  return (
    <ThemeProvider theme={styledTheme}>
      <>
        <Header showLogo={uri !== "/"} />
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
