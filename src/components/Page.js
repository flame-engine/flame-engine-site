import React from "react"
import { Header } from "./Header"
import { SEO } from "./Seo"

export const Page = ({ title, children }) => {
  return (
    <>
      <SEO title={title} />
      <Header />
      <main>{children}</main>
    </>
  )
}
