import React from "react"
import { Page } from "./src/components/Page"
require("react-github-button/assets/style.css")


export const wrapPageElement = ({ element, props }) => (
  <Page {...props}>{element}</Page>
)
