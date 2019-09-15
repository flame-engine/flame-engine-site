import React from "react"
import styled from "styled-components"

import { Link, graphql, StaticQuery } from "gatsby"
import { ButtonLink } from "./UI"

const DocSidebarLink = styled(ButtonLink)`
  padding: 0;
  font-weight: 400;
  font-size: 0.9em;
  &.active {
    font-weight: 800;
  }
`

const DocSidebarContainer = styled.div`
  min-width: 15em;
  border: solid 0 #d8d8d8;
  border-right-width: 1px;
  padding: 1em 2em 0 0;
  margin: 0 2em 0 0;

  & ul {
    margin-bottom: 1.5em;
  }
  & li {
    color: ${props => props.theme.accentColor};
    padding-left: 0.855em;
    font-size: 1.25em;
    padding: 0.625em 0.4em;

    & li {
      list-style-type: circle;
      font-size: 0.8em;
    }
    & a {
      display: inline;
    }
  }
`

const CategoryTitle = styled.div`
    padding: 0.5em;
    background-color: #f1f1f1;
    font-size: 1em;
    color: #000;
    font-weight: 700;
}
`

// TODO read this form the generated files, somehow
const categoriesNames = {
  0: "",
  1: "Core Concepts",
  2: "Rendering",
  3: "Other Modules",
}

const DocSidebar = ({ allMarkdownRemark }) => {
  const categories = allMarkdownRemark.edges.reduce((acc, act, index) => {
    const {
      node: { frontmatter },
    } = act

    const { category } = frontmatter

    acc[category] = [...(acc[category] || []), act]

    return acc
  }, {})

  const edges = Object.keys(categories).map(key => {
    const pages = categories[key]
    const links = pages.map(({ node: { frontmatter: page } }, index) => (
      <li key={index}>
        <DocSidebarLink activeClassName="active" as={Link} to={page.path}>
          {page.title}
        </DocSidebarLink>
      </li>
    ))
    return (
      <ul key={key}>
        {categoriesNames[key] ? (
          <CategoryTitle>{categoriesNames[key]}</CategoryTitle>
        ) : null}
        {links}
      </ul>
    )
  })

  return <DocSidebarContainer>{edges}</DocSidebarContainer>
}

export default () => (
  <StaticQuery
    query={graphql`
      query {
        allMarkdownRemark(
          sort: {
            order: [ASC, ASC]
            fields: [frontmatter___category, frontmatter___order]
          }
        ) {
          edges {
            node {
              headings {
                depth
                value
              }
              frontmatter {
                title
                path
                category
                order
              }
            }
          }
        }
      }
    `}
    render={DocSidebar}
  />
)
