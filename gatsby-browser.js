import React from "react"
import { Page } from "./src/components/Page"

export const wrapPageElement = ({ element, props }) => (
  <Page {...props}>{element}</Page>
)
