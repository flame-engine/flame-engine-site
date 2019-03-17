import React from "react"

import { graphql } from "gatsby"

import { PageWrapper } from "../components/Page"
import { MarkdownBody } from "../components/MarkdownBody"
import DocSidebar from "../components/DocSidebar"

import { DocsStructure } from "../components/UI"

export default function Template({ data }) {
  const { markdownRemark } = data
  const {
    frontmatter: { title },
    html,
  } = markdownRemark
  return (
    <PageWrapper title={` ${title} | Flame`}>
      <DocsStructure>
        <DocSidebar />
        <MarkdownBody dangerouslySetInnerHTML={{ __html: html }} />
      </DocsStructure>
    </PageWrapper>
  )
}

export const pageQuery = graphql`
  query($path: String!) {
    markdownRemark(frontmatter: { path: { eq: $path } }) {
      html
      frontmatter {
        path
        title
      }
    }
  }
`
