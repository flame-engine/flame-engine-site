import React from "react"

import { graphql } from "gatsby"
import { PageWrapper } from "../components/Page"
import { MarkdownBody } from "../components/MarkdownBody"
import {
  DocsStructure,
  DocSidebarLink,
  DocSidebarCotainer,
} from "../components/UI"
import Link from "gatsby"

const DocSidebar = () => (
  <DocSidebarCotainer>
    <ul>
      <li>
        <DocSidebarLink as={Link} to="/">
          Get started
        </DocSidebarLink>
      </li>
    </ul>
  </DocSidebarCotainer>
)

export default function Template({ data }) {
  const { markdownRemark } = data
  const {
    frontmatter: { title },
    html,
  } = markdownRemark
  console.log(data)
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
