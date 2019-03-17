import React from "react"
import { Page } from "./src/components/Page"
require("react-github-button/assets/style.css")
require("./src/components/prism-theme.css")

export const wrapPageElement = ({ element, props }) => (
  <Page {...props}>{element}</Page>
)
