const path = require("path")

const createDocsPage = ({ createPage, graphql }) => {
  const docTemplate = path.resolve(`src/templates/docTemplate.js`)

  return graphql(`
    {
      allMarkdownRemark(
        sort: {
          order: [ASC, ASC]
          fields: [frontmatter___category, frontmatter___order]
        }
        limit: 1000
      ) {
        edges {
          node {
            frontmatter {
              path
            }
          }
        }
      }
    }
  `).then(result => {
    if (result.errors) {
      return Promise.reject(result.errors)
    }

    result.data.allMarkdownRemark.edges.forEach(({ node }) => {
      createPage({
        path: node.frontmatter.path,
        component: docTemplate,
        context: {},
      })
    })
  })
}

const createFlameconPage = ({ createPage }) => {
  const flameconTemplate = path.resolve(`src/templates/flameconTemplate.js`)

  return createPage({
    path: "/flamecon",
    component: flameconTemplate,
    context: {},
  })
}

exports.createPages = ({ actions, graphql }) => {
  const { createPage } = actions

  return Promise.all([
    createDocsPage({ createPage, graphql }),
    createFlameconPage({ createPage }),
  ])
}
