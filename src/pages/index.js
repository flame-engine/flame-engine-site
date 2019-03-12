import React from "react"

import styled from "styled-components"
import { StaticQuery, graphql } from "gatsby"
import Img from "gatsby-image"
import GitHubButton from "react-github-button"

import { PageWrapper } from "../components/Page"
import { ButtonLink } from "../components/Button"
import { AnimatedLogo } from "../components/AnimatedLogo"

const HeroContainer = styled.div`
  height: 100vh;
  min-height: 45.25em;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding-top: 5em;
`

const HeroImageContainer = styled.div`
  width: 12.5em;
`

const HeroImage = () => (
  <HeroImageContainer>
    <StaticQuery
      query={graphql`
        query {
          placeholderImage: file(relativePath: { eq: "flame-icon.png" }) {
            childImageSharp {
              fluid(maxWidth: 200) {
                ...GatsbyImageSharpFluid
              }
            }
          }
        }
      `}
      render={data => (
        <Img fluid={data.placeholderImage.childImageSharp.fluid} />
      )}
    />
  </HeroImageContainer>
)

const Flex = styled.div`
  display: flex;
  align-self: stretch;
  justify-content: center;
  flex-wrap: wrap;
  & > *:first-child {
    margin-right: 2.25em;
  }
`

const HeroText = styled.p`
  font-size: 1.875rem;
  color: #333;
  font-weight: 200;
  margin: 2em 0;
  & b {
    font-weight: 800;
  }
`

const IndexPage = () => {
  return (
    <PageWrapper title="Flame">
      <HeroContainer>
        <HeroImage />
        <AnimatedLogo />
        <GitHubButton
          type="stargazers"
          size="large"
          namespace="luanpotter"
          repo="flame"
        >
          Star
        </GitHubButton>
        <HeroText>
          2D game engine made on top of <b>Flutter</b>
        </HeroText>
        <Flex>
          <ButtonLink>See docs</ButtonLink>
          <ButtonLink border> Github</ButtonLink>
        </Flex>
      </HeroContainer>
    </PageWrapper>
  )
}

export default IndexPage
