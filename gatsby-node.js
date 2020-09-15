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

const createCountdownPage = ({ createPage }) => {
  const countdownTemplate = path.resolve(`src/templates/countdownTemplate.js`)

  return createPage({
    path: "/countdown",
    component: countdownTemplate,
    context: {},
  })
}

const createMerchPage = ({ createPage }) => {
  const merchTemplate = path.resolve(`src/templates/merchTemplate.js`)
  return createPage({
    path: "/merch",
    component: merchTemplate,
    context: {},
  })
}

const createDiscordPage = ({ createPage }) => {
  const discordTemplate = path.resolve(`src/templates/discordTemplate.js`)
  return createPage({
    path: "/discord",
    component: discordTemplate,
    context: {},
  })
}

exports.createPages = ({ actions, graphql }) => {
  const { createPage } = actions

  return Promise.all([
    createDocsPage({ createPage, graphql }),
    createFlameconPage({ createPage }),
    createCountdownPage({ createPage }),
    createMerchPage({
      createPage,
    }),
    createDiscordPage({
      createPage,
    }),
  ])
}
