import React from "react"


import { graphql } from "gatsby"
import { PageWrapper } from "../components/Page"
import { MarkdownBody } from "../components/MarkdownBody"

export default function Template({ data }) {
  const { markdownRemark } = data
  const {
    frontmatter: { title },
    html,
  } = markdownRemark
  return (
    <PageWrapper title={` ${title} | Flame`}>
      <MarkdownBody dangerouslySetInnerHTML={{ __html: html }} />
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
